---
name: camofox-browser-operator
description: "Full browser-operator workflow for using Camofox/Camoufox with Hermes: reliable browsing, form filling, QA checks, session persistence, and human-in-the-loop verification."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos]
metadata:
  hermes:
    tags: [browser, camofox, camoufox, forms, web-automation, qa, human-in-the-loop]
    related_skills: [hermes-agent, browser-form-workflows, dogfood, google-workspace, himalaya, watchers]
---

# Camofox Browser Operator

Use this skill when the user asks Hermes to work in a browser autonomously: open sites, click through flows, fill forms, inspect pages, test web apps, or operate account dashboards using the Camofox/Camoufox browser backend.

This skill is about **reliable legitimate browser operation**, not bypassing bot detection. Do not claim invisibility or guarantee that a site will not identify automation. For CAPTCHA, SMS, 2FA, legal consent, payment, government ID, or other human-verification steps, stop and ask the user to complete/confirm the step.

## Load with these skills

When this skill is relevant, also load the relevant supporting skills:

1. `hermes-agent` — browser backend configuration, gateway restart, Camofox/Browserbase/CDP docs.
2. `browser-form-workflows` — account signup, onboarding, multi-step forms.
3. `dogfood` — systematic page exploration, console checks, screenshots, evidence.
4. `google-workspace` — after Google login/OAuth, prefer API/MCP over fragile UI.
5. `himalaya` — optional fallback for email via IMAP/SMTP where available.
6. `watchers` — optional for long-running polling/monitoring tasks.

## Preferred browser stack

Default local stack for protected/fragile websites:

- Camofox/Camoufox running as a local browser service.
- Headful mode under Xvfb when no physical display is available.
- Persistent session state enabled.
- Long browser inactivity/session timeouts for Telegram/gateway workflows.
- Timezone, geolocation, locale, and network location kept consistent.
- One stable browser profile per user/task identity.

Recommended environment shape for a Linux VPS or always-on workstation:

```bash
cd ~/camofox-browser
DISPLAY=:99 \
CAMOFOX_FORCE_HEADFUL=1 \
CAMOFOX_DISABLE_VIRTUAL_DISPLAY=1 \
CAMOFOX_DEFAULT_TIMEZONE=Europe/Amsterdam \
CAMOFOX_DEFAULT_LAT=52.3740 \
CAMOFOX_DEFAULT_LON=4.8897 \
CAMOFOX_DEFAULT_LOCALE=ru-RU \
CAMOFOX_PORT=9377 \
BROWSER_IDLE_TIMEOUT_MS=900000 \
SESSION_TIMEOUT_MS=1800000 \
TAB_INACTIVITY_MS=900000 \
./node_modules/.bin/camofox-browser
```

Notes for Linux/Xvfb hosts:

- A working Xvfb may already exist on `:99` and may be owned by another user. Do not delete `/tmp/.X99-lock` or kill another user's Xvfb if permissions fail.
- Check state before restarting:

```bash
ps -eo pid,user,comm,args | grep -E 'Xvfb|camofox-browser|firefox|camoufox' | grep -v grep || true
python3 - <<'PY'
import socket
s=socket.socket(); s.settimeout(1)
try:
    s.connect(('127.0.0.1',9377)); print('port 9377 open')
except Exception as e: print('port 9377 closed:', e)
finally: s.close()
PY
```

## Binary version check and oscpu fix

**Problem:** Old Camoufox binary (v150, shipped with `@askjo/camofox-browser`) leaks `navigator.oscpu=Linux armv81` while `navigator.platform=Linux x86_64`, creating a trivially detectable fingerprint mismatch.

**Fix procedure (verified 2026-06-11):**

```bash
# 1. Stop current camofox-browser
pkill -f 'camofox-browser' || true

# 2. Install fresh Camoufox binary (puts camoufox-bin at ~/.cache/camoufox/)
python3 -m venv /tmp/cf-fix && source /tmp/cf-fix/bin/activate
pip install camoufox -q
python3 -c "import camoufox; print(camoufox.__version__)"
~/.cache/camoufox/camoufox-bin --version
deactivate && rm -rf /tmp/cf-fix

# 3. Start camofox-browser with same env vars
cd ~/camofox-browser && \
DISPLAY=:99 CAMOFOX_FORCE_HEADFUL=1 CAMOFOX_DISABLE_VIRTUAL_DISPLAY=1 \
CAMOFOX_DEFAULT_TIMEZONE=Europe/Amsterdam CAMOFOX_DEFAULT_LAT=52.3740 \
CAMOFOX_DEFAULT_LON=4.8897 CAMOFOX_DEFAULT_LOCALE=ru-RU CAMOFOX_PORT=9377 \
BROWSER_IDLE_TIMEOUT_MS=900000 SESSION_TIMEOUT_MS=1800000 TAB_INACTIVITY_MS=900000 \
./node_modules/.bin/camofox-browser

# 4. Verify oscpu is fixed
#   - navigate to example.com
#   - browser_console(expression="navigator.oscpu")
#   - expect "Linux x86_64", NOT "Linux armv81"
```

**Verification command** (from Hermes browser tool):
```
browser_navigate(url="https://example.com/")
browser_console(expression="navigator.oscpu")
→ should return "Linux x86_64"
```

## Observed behavior on the reference Hermes host

Validated with Camofox/Camoufox on 2026-06-11:

- SannySoft: `navigator.webdriver` missing/passed, WebDriver Advanced passed, WebGL enabled with Intel renderer.
- BrowserScan bot detection: overall `Normal`; WebDriver, Selenium, CDP, Headless Chrome all `Normal`.
- Pixelscan: `No automated behavior detected`, timezone/location Amsterdam, but still reports `Proxy detected`, `Masking detected`, and `Browser Fingerprint is inconsistent`.
- CreepJS: not flagged as Chromium/headless; WebGL/timezone look coherent, but `Navigator` exposes a mixed platform detail: `Linux armv81` together with `Linux x86_64`. This likely contributes to fingerprint inconsistency.
- `browser_console()` currently reports that console log capture is not available with the Camofox backend. JS expression evaluation (`browser_console(expression="...")`) still works. For console logs, rely on snapshots/vision and page text.
- **`oscpu=Linux armv81` pitfall (resolved):** Old Camoufox binary v150 used by `@askjo/camofox-browser` leaks `navigator.oscpu=Linux armv81` while `navigator.platform=Linux x86_64`, creating a trivially detectable mismatch on Pixelscan/CreepJS/BrowserScan. **Fix:** replace the binary with Camoufox v135+ (e.g. via `pip install camoufox` which drops `camoufox-bin` at `~/.cache/camoufox/camoufox-bin`, then restart camofox-browser). Verified 2026-06-11: direct Python Camoufox v135.0.1-beta.24 reports `oscpu=Linux x86_64` coherently; BrowserForge fingerprint injection also applies correctly on v135 (oscpu/platform/UA all match requested values).
- Some submit clicks may return a Camofox API timeout while the browser action still succeeds. After any timeout, immediately call `browser_snapshot()` before retrying; do not double-submit blindly.
- Text masking like `+799****0000` can be normalized by browser typing into plain digits. Use clearly fake test values when testing forms, and avoid entering sensitive real data unless explicitly requested.

## Operating workflow

### 1. Preflight

Before using the browser for a sensitive or fragile flow:

1. Confirm Camofox server is alive.
2. Confirm Hermes browser backend points to Camofox (`CAMOFOX_URL` or browser config).
3. Confirm the browser profile/session identity is the intended one.
4. If the task depends on a logged-in session, inspect current page/session first rather than assuming auth state.
5. If the site is high-friction (Google, Meta, banks, ticketing, crypto, government), warn the user that SMS/CAPTCHA/2FA may require him.

### 2. Navigation and interaction loop

For each step:

1. `browser_navigate` or continue from current page.
2. Take a fresh `browser_snapshot`.
3. If the DOM is unclear, use `browser_vision(annotate=true)`.
4. Click/type only into refs from the current fresh snapshot.
5. After each submit/next/navigation, take another fresh snapshot.
6. Check `browser_console()` after important page loads/interactions.
7. Give the user terse status updates on long flows: `открыл`, `ввожу`, `перешёл дальше`, `нужен код`.

### 3. Forms and registrations

Follow `browser-form-workflows`:

- Ask only for fields currently visible.
- Enter low-risk data when provided: name, date of birth, username, public profile fields.
- Passwords: ask the user to type directly, or generate/type a temporary password only if he explicitly asks.
- Never invent phone numbers, recovery emails, verification codes, CAPTCHA answers, identity data, or payment details.
- For account creation / terms acceptance, explain the action and get confirmation before clicking a final irreversible submit if needed.

### 4. Evidence and QA

Follow `dogfood` when testing or debugging websites:

- Check console after navigation and important actions.
- Capture screenshots for visual issues.
- Test empty/invalid form submissions where appropriate.
- Record exact URL, steps, expected vs actual behavior.
- Use `MEDIA:<screenshot_path>` when sending screenshots back to the user.

### 5. Prefer APIs after authentication

For services with stable APIs/MCP integrations:

- Use browser only for login, consent, or one-time setup.
- After access exists, switch to API/MCP/CLI when possible.

Examples:

- Google → `google-workspace` tools for Gmail/Drive/Calendar/Docs/Sheets.
- Email IMAP/SMTP → `himalaya` where configured.
- GitHub → GitHub MCP/gh skills instead of UI.
- Notion/Airtable/etc. → dedicated skills/APIs.

## Fingerprint management notes

Relevant components discovered from Camoufox docs:

- Camoufox has **Fingerprint Injection** and can spoof navigator, screen, WebGL, geolocation/Intl, headers, WebRTC, media/audio, voices, addons, and other surfaces.
- Camoufox uses **BrowserForge** to generate realistic Firefox fingerprints based on OS/screen constraints.
- Prefer coherent constraints (`os`, screen, locale, timezone, proxy/geo) over manually overriding many individual properties.
- Camoufox docs list `navigator.oscpu`, `navigator.platform`, and `navigator.hardwareConcurrency` as spoofable, but GitHub issue `daijro/camoufox#516` reports that in some builds these overrides are passed to the binary yet ignored/leak real values. This matches the observed `Linux armv81` + `Linux x86_64` inconsistency on this host.
- Current local versions checked on 2026-06-11: `@askjo/camofox-browser@1.11.2`, `camoufox-js@0.11.0`; npm showed these as latest at that moment.
- The local `@askjo/camofox-browser` server launches with `launchOptions({ os: hostOS, humanize: true, enable_cache: true, ... })`. It does not expose a simple high-level env var for full custom BrowserForge fingerprint injection through the server API.
- **Direct Python Camoufox (outside the server) DOES support BrowserForge fingerprints correctly on v135+.** The server's limitation is at the `@askjo/camofox-browser` JS layer, not the Camoufox binary itself. If full fingerprint control is needed, use direct Python Camoufox or patch the `@askjo/camofox-browser` server to accept fingerprint config.
- **Reproducible oscpu check:** run `scripts/check-camoufox-oscpu.py` (requires `pip install camoufox` in a venv) to verify whether the current Camoufox binary has coherent oscpu/platform or is affected by the v150 bug.

Use fingerprint tools for legitimate reliability, privacy testing, and QA. Do not promise invisibility or use them to defeat a site's access controls.

## Fingerprint and trust hygiene

Allowed/recommended reliability measures:

- Keep timezone, geolocation, locale, and proxy/IP geography consistent.
- Use persistent sessions instead of constantly creating fresh profiles.
- Avoid rapid repeated signup attempts after provider rejection.
- Use human-in-the-loop for challenges and confirmations.
- Use a real user-owned browser via CDP when the user explicitly consents and the site is too sensitive for cloud/local automation.
- Use Browserbase Verified / signed-agent / human-backed identity where available and legitimate.

Do **not**:

- Promise that automation is undetectable.
- Provide instructions whose purpose is to defeat anti-bot systems or evade detection.
- Automate CAPTCHA solving unless it is through a legitimate provider explicitly designed for authorized agent access and allowed by the site/provider.
- Create or operate accounts in violation of a service's terms.
- Loop many account-creation attempts after anti-abuse rejection.

## Escalation ladder

If Camofox fails or gets blocked:

1. Retry once if the failure may be stale DOM, bad input format, or transient network.
2. If provider anti-abuse blocks the flow, stop and report the exact state.
3. For legitimate user-owned access, you may *recommend* CDP into the user's real Chrome/Brave/Edge on his Mac mini, but **do not connect, inspect, or use the remote computer** unless the user explicitly authorizes Mac access for this specific browser task in the current conversation. Consent from an earlier or different task (for example Hermes gateway diagnostics) never carries over.
4. If VPS/Camofox is blocked and the user has not explicitly authorized Mac use for this task, stop and report the concrete blocker with screenshots/evidence; do not silently escalate to Mac, SSH, Mac network inspection, VPN inspection, or Mac browser-harness.
5. For cloud autonomy, recommend Browserbase with `BROWSERBASE_API_KEY`, `BROWSERBASE_PROJECT_ID`, proxies, and where available verified/signed-agent features.
6. If the site has an API, switch away from browser UI.

## Communication style

Use the user's language by default. For COMANDOS club users, Russian is usually the right default. Be direct and short.

Good status messages:

- `Открыл сайт, смотрю форму.`
- `Заполнил первый шаг, перехожу дальше.`
- `Здесь нужен SMS/2FA — введи сам и скажи «дальше».`
- `Сайт отклонил автоматизированный flow; дальше лучше через твой реальный Chrome/CDP.`

Avoid long generic support language.

## Hard boundary: no implicit Mac escalation

For browser tasks, the default execution environment is the configured Hermes browser stack. Any remote personal computer is a separate user-owned machine and requires fresh, task-specific consent before any access.

Do not treat prior permission to access another user-owned machine as reusable. Permission for one diagnostic task does **not** authorize marketplace browsing, VPN/network checks, Chrome/CDP/browser-harness use, screenshots, or any other machine-side action.

If a site blocks the VPS browser, report the block and ask what to do next. Never inspect or modify the remote computer's VPN/network/browser state unless the user explicitly says to use the remote computer for this task.

## Verification checklist before final reply

- Current browser state is known from a fresh snapshot/vision check.
- Every typed field matches the user's provided data.
- Sensitive steps were not automated without explicit user direction.
- Console/errors were checked when debugging or QA was requested.
- If blocked, the blocker is stated concretely with the exact current screen/error.
- If account/action completed, the result is verified by the page state or API output.
