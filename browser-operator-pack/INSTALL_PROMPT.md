# Готовый prompt для установки COMANDOS Browser Operator в Hermes

Скопируй текст ниже и вставь в Hermes Agent:

```text
Установи и настрой COMANDOS Browser Operator для автономной работы в браузере.

Репозиторий: https://github.com/Comandosai/skills-library

Что нужно сделать:
1. Установи оба навыка Hermes из GitHub:
   - Comandosai/skills-library/camofox-browser-operator
   - Comandosai/skills-library/browser-form-workflows
2. Клонируй репозиторий во временную директорию.
3. На Linux запусти:
   - bash browser-operator-pack/scripts/install-camofox-browser.sh
   - bash browser-operator-pack/scripts/verify-camofox-browser.sh
4. Добавь в конфиг или файл окружения Hermes переменную:
   - CAMOFOX_URL=http://127.0.0.1:9377
5. Если используется Hermes gateway — перезапусти gateway безопасным способом.
6. Проверь реальным браузерным действием: открой https://example.com и верни title страницы.
7. Если браузерная задача требует CAPTCHA/SMS/2FA/оплаты/юридического согласия — остановись и попроси человека пройти этот шаг. Не пытайся обходить проверки.

Команды, которые можно использовать:

hermes skills install Comandosai/skills-library/camofox-browser-operator --category productivity
hermes skills install Comandosai/skills-library/browser-form-workflows --category productivity

git clone https://github.com/Comandosai/skills-library.git /tmp/skills-library
cd /tmp/skills-library
bash browser-operator-pack/scripts/install-camofox-browser.sh
bash browser-operator-pack/scripts/verify-camofox-browser.sh

После установки проверь:
hermes chat -s camofox-browser-operator,browser-form-workflows -q "Открой example.com и скажи заголовок страницы" --toolsets browser,terminal,file,skills

Цель: после выполнения Hermes должен уметь сам открывать сайты, кликать, заполнять формы, делать скриншоты, тестировать страницы и передавать человеку только sensitive-шаги вроде CAPTCHA/SMS/2FA/оплаты.
```
