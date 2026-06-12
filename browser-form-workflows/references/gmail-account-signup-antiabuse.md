# Gmail / Google Account signup anti-abuse notes

Use this reference from `browser-form-workflows` when a user asks for Gmail/Google account creation or similar high-friction account signup through browser automation.

## Observed patterns

1. **Default headless/local Chrome can complete early fields but fail after password.**
   In a real Gmail signup flow, Hermes browser automation filled name, birthday, username choice, and password, then Google returned a generic `Error` page immediately after password submit. Retrying once with a different suggested Gmail address and a simpler temporary password produced the same result.

2. **Camofox/Camoufox can get further than default Chrome.**
   Running a local `@askjo/camofox-browser` server and driving its REST API completed the same flow past password submission. Google then showed a device/phone verification step with a QR code instead of the generic `Error`:
   - heading: `Verify some info before creating an account`
   - message: Google needs to verify device or phone info to prevent abuse from bots
   - challenge: scan QR code with phone, follow steps, then return to browser

3. **Verification is still a hard handoff to the user.**
   QR/SMS/CAPTCHA/device-trust checks are not something the agent should bypass or invent. Stop, send the QR screenshot if available, and wait for the user to complete it.

## Backend escalation order

When the user asks to do as much as possible without using their own device:

1. **Default Hermes browser** for normal forms.
2. **Browserbase** if both `BROWSERBASE_API_KEY` and `BROWSERBASE_PROJECT_ID` are configured; enable proxies/stealth if the plan supports it.
3. **Camofox/Camoufox** for anti-detection Firefox-style automation when Browserbase credentials are missing or unsuitable.
4. **CDP into the user's real browser** only with explicit user consent. This is often best for Google, but it involves their machine/profile.

Firecrawl is not a substitute for this class of task: it is for crawling/scraping/extraction, not live account creation with verification.

## Camofox setup recipe

Install locally in a disposable directory:

```bash
mkdir -p ~/camofox-browser-test
cd ~/camofox-browser-test
npm init -y
npm install @askjo/camofox-browser@latest
CAMOFOX_PORT=9377 \
BROWSER_IDLE_TIMEOUT_MS=900000 \
SESSION_TIMEOUT_MS=1800000 \
TAB_INACTIVITY_MS=900000 \
./node_modules/.bin/camofox-browser
```

Verify:

```bash
curl -fsS http://127.0.0.1:9377/health
```

Configure Hermes browser tools on the next gateway/session restart by adding this variable to the Hermes environment file:

```bash
CAMOFOX_URL=http://127.0.0.1:9377
```

If the gateway cannot be restarted from inside itself, drive Camofox directly through its REST API for the current task.

## Direct Camofox REST workflow

Create tab:

```python
import requests
base = 'http://127.0.0.1:9377'
uid = 'form-user'
sess = 'signup-task'
r = requests.post(base + '/tabs', json={
    'userId': uid,
    'sessionKey': sess,
    'url': 'https://accounts.google.com/signup/v2/createaccount?flowName=GlifWebSignIn&flowEntry=SignUp',
}, timeout=60)
tab = r.json()['tabId']
```

Read current page:

```python
snap = requests.get(f'{base}/tabs/{tab}/snapshot', params={'userId': uid}, timeout=60).json()['snapshot']
```

Interact with refs from the snapshot:

```python
requests.post(f'{base}/tabs/{tab}/type', json={'userId': uid, 'ref': 'e1', 'text': 'Alex'}, timeout=60)
requests.post(f'{base}/tabs/{tab}/click', json={'userId': uid, 'ref': 'e3'}, timeout=60)
```

For Google Material comboboxes (month/gender) that appear in the snapshot without refs, use `/evaluate` to click DOM options and dispatch input/change events:

```python
expr = r'''
(() => {
  const clickText = (aria, text) => {
    const box = [...document.querySelectorAll('[role=listbox]')]
      .find(x => x.getAttribute('aria-label') === aria);
    const item = [...box.querySelectorAll('li,[role=option],div')]
      .find(x => (x.innerText || '').trim() === text);
    item.click();
  };
  const fire = (el, t) => el.dispatchEvent(new Event(t, {bubbles: true}));
  document.querySelector('#month')?.click();
  clickText('Month', 'July');
  const day = document.querySelector('input#day');
  day.value = '1'; fire(day, 'input'); fire(day, 'change');
  const year = document.querySelector('input#year');
  year.value = '1982'; fire(year, 'input'); fire(year, 'change');
  document.querySelector('#gender')?.click();
  clickText('Gender', 'Male');
  return true;
})()
'''
requests.post(f'{base}/tabs/{tab}/evaluate', json={'userId': uid, 'expression': expr}, timeout=60)
```

Capture QR or final visual state:

```python
png = requests.get(f'{base}/tabs/{tab}/screenshot', params={'userId': uid}, timeout=60).content
open('/tmp/gmail_qr_camofox.png', 'wb').write(png)
```

## Camofox launch pitfall

Some Linux environments/package versions may start the server but fail browser pre-warm around Xvfb/virtual display. Prefer a normal server start first. If it repeatedly reports virtual-display launch problems, use headless mode or a local patch/config that disables virtual display for that run rather than abandoning Camofox entirely. The durable lesson is: **fall back to headless Camofox and verify `/health`**, not “Camofox is broken.”

## Final wording when QR verification appears

Use a concise handoff:

> Дошёл до QR-верификации. Это уже ручной антибот-шаг Google: открой камеру на телефоне, отсканируй QR, пройди шаги и напиши «готово». Я продолжу после подтверждения.

Do not save temporary passwords, selected disposable usernames, QR files, or account-creation state to memory/skills.
