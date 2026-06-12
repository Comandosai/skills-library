# Camofox Browser Operator — навык для COMANDOS

Карточка и детальная страница навыка для маркетплейса comandos.ai. Источник правды — этот файл + `manifest.yaml`.

## 📄 ДЕТАЛЬНАЯ СТРАНИЦА

# Camofox Browser Operator

> Даёт Hermes полноценную работу в браузере: открыть сайт, кликать, заполнять формы, делать скриншоты и останавливаться на sensitive-шагах.

Создано командой COMANDOS для Hermes Agent.

## 😩 Знакомая боль?

- **«Агент говорит, что надо сделать руками»** — вместо того чтобы открыть сайт и попробовать сам.
- **«Браузер отваливается на длинной задаче»** — сессия протухла, refs устарели, вкладка заснула.
- **«Нужно заполнить форму, но агент путается»** — кликнул не туда, потерял шаг, не сделал свежий snapshot.
- **«Хочу browser automation без хака антибота»** — агент должен работать как ассистент, а не обещать невидимость.

## 🎯 Что делает этот навык

Навык задаёт Hermes Agent рабочий протокол browser-оператора:

- открывать сайты и читать текущее состояние страницы;
- кликать, вводить данные, переходить по шагам;
- делать screenshot/snapshot и проверять console/network-симптомы;
- держать persistent browser-сессию и длинные таймауты;
- проверять согласованность timezone/geolocation/locale/fingerprint;
- останавливаться на CAPTCHA, SMS, 2FA, оплате и юридических подтверждениях.

## ⚙️ Установка

```bash
hermes skills install Comandosai/skills-library/camofox-browser-operator --category productivity
hermes skills install Comandosai/skills-library/browser-form-workflows --category productivity

git clone https://github.com/Comandosai/skills-library.git /tmp/skills-library
cd /tmp/skills-library
bash browser-operator-pack/scripts/install-camofox-browser.sh
bash browser-operator-pack/scripts/verify-camofox-browser.sh
```

## ✅ Проверка

```bash
hermes chat -s camofox-browser-operator,browser-form-workflows -q "Открой example.com и скажи заголовок страницы" --toolsets browser,terminal,file,skills
```

## 🎴 КАРТОЧКА

Навык для Hermes Agent, который превращает браузерные задачи в нормальный рабочий процесс: открыть сайт, кликать, заполнять формы, тестировать web UI, делать скриншоты и передавать человеку только sensitive-шаги вроде CAPTCHA/SMS/2FA/оплаты. Работает с Camofox/Camoufox, persistent sessions и headful/Xvfb режимом.
