# Camofox Browser Operator

Навык для Hermes Agent, который превращает браузерные задачи в нормальный рабочий процесс: открыть сайт, кликать, заполнять формы, проверять страницу, делать скриншоты и передавать человеку CAPTCHA/SMS/2FA/оплату.

## Установка в Hermes

```bash
hermes skills install Comandosai/skills-library/camofox-browser-operator --category productivity --yes
hermes skills install Comandosai/skills-library/browser-form-workflows --category productivity --yes
```

## Установка browser service

```bash
git clone https://github.com/Comandosai/skills-library.git /tmp/skills-library
cd /tmp/skills-library
bash browser-operator-pack/scripts/install-camofox-browser.sh
bash browser-operator-pack/scripts/verify-camofox-browser.sh
```

Добавь в файл окружения Hermes:

```bash
CAMOFOX_URL=http://127.0.0.1:9377
```

Перезапусти Hermes gateway или CLI-сессию.

## Проверка

```bash
hermes chat -s camofox-browser-operator,browser-form-workflows -q "Открой example.com и скажи заголовок страницы" --toolsets browser,terminal,file,skills
```

## Важная граница

Навык не предназначен для обхода CAPTCHA/anti-bot/2FA. На sensitive-шагах агент должен остановиться и передать действие человеку.
