# COMANDOS Skills Library

Открытая библиотека Claude Code-навыков для резидентов [comandos.ai](https://comandos.ai).

Лучшие навыки из открытых источников (Antigravity Awesome Skills, VoltAgent, и др.),
отобранные и **локализованные на русский** командой COMANDOS. Каждый навык — папка:

```
<slug>/
  SKILL.md         # оригинал навыка (англ.) — НЕ меняется, триггеры/пути целы
  manifest.yaml    # русская витрина + метаданные (comandos-skill-manifest/v1)
  MARKETPLACE.md   # русская детальная страница «как пользоваться»
```

Из `manifest.yaml` + `MARKETPLACE.md` сайт генерит карточку маркетплейса
(`/hub/skills`) скриптом `sync-skill-from-repo.mjs`. Источник правды — этот репозиторий.

## Атрибуция

Оригиналы навыков принадлежат их авторам (см. поле `source:` в каждом `manifest.yaml`),
распространяются по их лицензиям. COMANDOS добавляет кураторский отбор и русскую локализацию.

## Навыки

| Навык | Категория | Источник |
|-------|-----------|----------|
| [brainstorming](./brainstorming) | AI и нейросети | Antigravity Awesome Skills |
