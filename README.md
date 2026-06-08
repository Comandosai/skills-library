<div align="center">

# 🧰 COMANDOS Skills Library

**Лучшие Claude Code-навыки из открытых источников — отобранные и переведённые на русский.**

[![Telegram](https://img.shields.io/badge/Telegram-@ai__comandos-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ai_comandos)
[![Сайт](https://img.shields.io/badge/comandos.ai-Центр_AI_автоматизаций-A3E635?style=for-the-badge&logoColor=black)](https://comandos.ai)
[![Навыки](https://img.shields.io/badge/Маркетплейс_навыков-→-111827?style=for-the-badge)](https://comandos.ai/hub/skills)

</div>

---

> ### 👋 Случайно зашли?
> Этот репозиторий ведёт **[COMANDOS AI](https://comandos.ai)** — центр AI-бизнес-автоматизаций.
> Мы каждый день разбираем нейросети, агентов и автоматизацию по-русски и по делу.
>
> ### 📲 [**Подписывайтесь на Telegram → @ai_comandos**](https://t.me/ai_comandos)
> Свежие навыки, кейсы, разборы и инструменты для Claude Code, Codex и Antigravity — первыми там.

---

## Что это

Открытая библиотека готовых **навыков (skills)** для AI-агентов — Claude Code, OpenAI Codex,
Google Antigravity. Мы берём лучшее из открытых коллекций (Antigravity Awesome Skills, VoltAgent
и др.), **локализуем на русский** и объясняем по-человечески, как этим пользоваться.

Каждый навык — папка:

```
<slug>/
  SKILL.md         # оригинал навыка (англ.) — НЕ меняется, триггеры/пути целы
  manifest.yaml    # русская витрина + метаданные (comandos-skill-manifest/v1)
  MARKETPLACE.md   # русская детальная страница «как пользоваться»
```

Из `manifest.yaml` + `MARKETPLACE.md` сайт генерит карточку маркетплейса на
**[comandos.ai/hub/skills](https://comandos.ai/hub/skills)** — там удобный каталог, поиск,
корзина и готовый промпт установки.

## 📚 Навыки

| Навык | Категория | Что делает | Источник |
|-------|-----------|------------|----------|
| [brainstorming](./brainstorming) | AI и нейросети | Превращает сырую идею в готовый план через диалог | Antigravity Awesome Skills |

> Список пополняется. Чтобы не пропустить новые — **[подписывайтесь на @ai_comandos](https://t.me/ai_comandos)**.

## ⚡ Как поставить навык

1. Зайдите в папку навыка, скопируйте её в `~/.claude/skills/<slug>/` (глобально) или в `.claude/skills/` проекта.
2. Или возьмите готовый промпт установки на **[странице навыка](https://comandos.ai/hub/skills)** — он сам всё развернёт.
3. Перезапустите агента — навык подхватится по своим триггерам.

## 🏷️ Атрибуция

Оригиналы навыков принадлежат их авторам (см. поле `source:` в каждом `manifest.yaml`) и
распространяются по их лицензиям. COMANDOS добавляет кураторский отбор и русскую локализацию.

---

<div align="center">

### Нравится подход? Нас много где можно встретить 👇

[![Telegram](https://img.shields.io/badge/Telegram-@ai__comandos-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ai_comandos)
[![Сайт](https://img.shields.io/badge/comandos.ai-A3E635?style=for-the-badge&logoColor=black)](https://comandos.ai)

**[t.me/ai_comandos](https://t.me/ai_comandos)** · **[comandos.ai](https://comandos.ai)**

<sub>Сделано командой COMANDOS — центр AI бизнес-автоматизаций 🤖</sub>

</div>
