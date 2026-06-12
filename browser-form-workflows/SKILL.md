---
name: browser-form-workflows
description: "Assist users through browser-based form workflows: account signup, onboarding, checkout-style forms, and multi-step web forms."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [browser, forms, signup, onboarding, web-automation]
---

# Browser Form Workflows

Use this skill when helping a user complete a multi-step web form in the browser: account creation, onboarding, signup flows, profile setup, preference forms, or checkout-like forms.

## Core workflow

1. **Open the target page and inspect the current step** with the browser snapshot.
2. **Ask only for fields that are actually on screen.** Do not gather a full dossier upfront.
3. **Enter low-risk data for the user** when they provide it, then advance the form.
4. **Pause for sensitive steps**: passwords, SMS/email verification codes, recovery phone/email, payment details, CAPTCHA, government IDs, or consent/legal confirmations.
5. **After every submit/next click, take a fresh snapshot** before acting again. DOM refs are step-local and can become stale after navigation.
6. **Give short progress updates** on long or fragile flows: “ввожу данные”, “перешёл к следующему шагу”, “нужен код/подтверждение”.
7. **Finish with the concrete state reached**: account created, verification blocked, waiting for user input, or provider rejected the flow.

## Handling changing DOM refs and blank snapshots

Browser form pages often re-render between steps. If a `browser_type` or `browser_click` fails with an unknown ref, or a snapshot is unexpectedly empty:

- First call `browser_snapshot` again to refresh refs.
- If the page is visually blank, use `browser_vision` to distinguish a rendering issue from a real empty page.
- If the DOM is empty but vision shows the form, check `browser_console(expression="location.href")` before assuming state still exists; sometimes the active page is actually `about:blank` while the screenshot cache still shows the prior page.
- If the form state is lost, navigate back to the flow’s stable entry URL and replay only the non-sensitive fields the user already provided.
- Do not conclude that the browser is broken; treat it as a transient page/rendering issue and retry with fresh refs.

## Provider anti-abuse / automated signup rejection

High-friction account creation sites (especially Google/Gmail) may allow early form steps but reject the flow after password submission with a generic `Error` or trigger phone/CAPTCHA/device-trust checks. Handle this as provider anti-abuse, not as a reason to fabricate progress.

- One careful retry is reasonable if a password shape, stale DOM ref, or username collision could explain the failure.
- Do **not** loop repeated full signup attempts after the same generic provider error; that can worsen risk scoring and wastes the user's time.
- If the default Hermes browser gets a generic provider error, try one stronger backend before giving up when the user wants maximum autonomy: Browserbase with project/proxy credentials, Camofox/Camoufox if available, or CDP into a user-owned browser if the user consents.
- When a challenge changes from generic `Error` to QR/SMS/CAPTCHA/device verification, stop automation and hand that step to the user. Continue only after they confirm completion.
- State exactly how far the flow got, which address/username was selected, and what error or verification challenge appeared.
- Recommend completing the signup from the user's own normal browser/device/IP when provider anti-abuse blocks automated browser completion.
- See `references/gmail-account-signup-antiabuse.md` for the Gmail-specific pattern and the Camofox REST workflow observed in real sessions.

## Sensitive-data boundaries

The assistant may type user-provided public/profile data (name, date of birth, username choice) into the form. For secrets and identity checks:

- Ask the user to type passwords directly, or provide an explicit password if they choose.
- If the user explicitly asks for a temporary password, generate it locally, type it once, tell the user it is temporary, and do not save it to memory or skills.
- Never invent a recovery email, phone number, verification code, or CAPTCHA answer.
- Let the user complete CAPTCHA/anti-bot challenges manually.
- For legal/terms/privacy acceptance, summarize what the button does and ask for confirmation before clicking if the action creates an account or commits to terms.

## Username/address selection

When the site offers generated usernames or addresses:

- Present the exact choices as bullets.
- Ask the user which to choose, unless they already gave a clear preference.
- If “create your own” is available, include it as an option.

## Communication style

Keep form-flow updates terse and direct. For COMANDOS club users, Russian is usually the right default unless the user writes in English. Avoid explaining obvious UI details. Prefer:

- “Открыл регистрацию. Нужны имя и фамилия.”
- “Готово, перешёл к дате рождения.”
- “Здесь нужен код из SMS — введи сам и скажи «дальше».”

Avoid long caveats unless the next step is sensitive or irreversible.

## Verification checklist

Before final reply:

- Did every user-provided field get entered correctly?
- Is the current screen known from a fresh snapshot or visual check?
- Are we waiting for user input, blocked by verification/CAPTCHA, or actually finished?
- Did we avoid storing or inventing sensitive information?
