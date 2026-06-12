# Browser Form Workflows

Поддерживающий навык для Hermes Agent: регистрация, onboarding, анкеты, profile setup, checkout-like формы и другие многошаговые browser workflows.

## Установка

```bash
hermes skills install Comandosai/skills-library/browser-form-workflows --category productivity --yes
```

Лучше ставить вместе с основным browser-operator навыком:

```bash
hermes skills install Comandosai/skills-library/camofox-browser-operator --category productivity --yes
hermes skills install Comandosai/skills-library/browser-form-workflows --category productivity --yes
```

## Что делает

- просит только те поля, которые реально видит на экране;
- обновляет snapshot после каждого шага;
- не кликает по stale DOM refs;
- останавливается на CAPTCHA/SMS/2FA/оплате/юридическом согласии;
- честно сообщает, где flow заблокирован.
