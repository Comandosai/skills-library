# Browser Form Workflows — навык для COMANDOS

Карточка и детальная страница навыка для маркетплейса comandos.ai. Источник правды — этот файл + `manifest.yaml`.

## 📄 ДЕТАЛЬНАЯ СТРАНИЦА

# Browser Form Workflows

> Помогает агенту проходить многошаговые формы: signup, onboarding, профили, заявки и checkout-like сценарии.

Создано командой COMANDOS для Hermes Agent.

## 😩 Знакомая боль?

- **«Агент заранее просит всё подряд»** — хотя на экране сейчас только имя и email.
- **«После next refs устарели»** — агент пытается кликнуть по старому DOM и ломает flow.
- **«Форма перерендерилась, а агент решил, что сайт сломан»** — вместо свежего snapshot и retry.
- **«Signup упёрся в антиабуз»** — агент не должен бесконечно повторять попытки.

## 🎯 Что делает этот навык

- ведёт форму шаг за шагом;
- просит только поля, которые реально нужны сейчас;
- после каждого submit/next делает новый snapshot;
- останавливается на пароле, SMS/email-коде, CAPTCHA, оплате и юридическом согласии;
- честно сообщает состояние: создано, ждёт код, заблокировано провайдером, нужен человек.

## ⚙️ Установка

```bash
hermes skills install Comandosai/skills-library/browser-form-workflows --category productivity --yes
```

Рекомендуется вместе с:

```bash
hermes skills install Comandosai/skills-library/camofox-browser-operator --category productivity --yes
```

## 🎴 КАРТОЧКА

Поддерживающий навык для browser-задач Hermes: регистрация, onboarding, анкеты, profile setup и другие многошаговые формы. Учит агента обновлять browser snapshot, не кликать stale refs, не собирать лишние данные заранее и передавать sensitive-шаги человеку.
