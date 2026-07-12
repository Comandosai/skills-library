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

| Навык | Категория | Что делает | Под какой агент |
|-------|-----------|------------|-----------------|
| [brainstorming](./brainstorming) | AI и нейросети | Превращает сырую идею в готовый план через диалог | Все |
| [claude-code-guide](./claude-code-guide) | AI и нейросети | Как выжать максимум из Claude Code: конфиги, режимы, отладка | Claude Code |
| [prompt-engineering](./prompt-engineering) | AI и нейросети | Пишет и чинит промпты за тебя — стабильный результат | Все |
| [parallel-agents](./parallel-agents) | AI и нейросети | Разбивает большую задачу на под-агентов и гонит параллельно | Все (где есть сабагенты) |
| [dispatching-parallel-agents](./dispatching-parallel-agents) | AI и нейросети | Раздаёт независимые задачи рою агентов и сводит результат | Все (где есть сабагенты) |
| [subagent-driven-development](./subagent-driven-development) | Разработка | Исполняет план задачами: свежий субагент + ревью по ТЗ и качеству | Все (где есть сабагенты) |
| [mcp-builder](./mcp-builder) | Разработка | Строит MCP-серверы — мостики ИИ к твоим API и сервисам | Все (MCP-клиенты) |
| [rag-implementation](./rag-implementation) | AI и нейросети | Собирает бота/поиск, который отвечает по твоим данным | Все |
| [systematic-debugging](./systematic-debugging) | Разработка | Находит настоящую причину бага, а не лепит фиксы наугад | Все |
| [copywriting](./copywriting) | Маркетинг | Продающий текст лендингов, прайсингов, CTA по брифу | Все |
| [marketing-ideas](./marketing-ideas) | Маркетинг | Конкретные growth-ходы из базы ~140 идей, по приоритету | Все |
| [workflow-automation](./workflow-automation) | Автоматизация | Надёжная автоматизация процессов (n8n/Temporal/Inngest) | Все |
| [camofox-browser-operator](./camofox-browser-operator) | Автоматизация | Даёт Hermes полноценную работу в браузере через Camofox/Camoufox | Hermes Agent |
| [browser-form-workflows](./browser-form-workflows) | Автоматизация | Ведёт агента по многошаговым web-формам и sensitive-шагам | Hermes Agent |
| [content-creator](./content-creator) | Контент | SEO-контент в едином tone of voice: блог, соцсети, план | Все |
| [landing-page-design](./landing-page-design) | Дизайн | Собрать конвертящий лендинг: структура, секции, копи-каркас | Все |
| [ui-ux-pro-max](./ui-ux-pro-max) | Дизайн | UI/UX-интеллект: стили, палитры, компоненты, доступность | Все |
| [launch-strategy](./launch-strategy) | Маркетинг | Пошаговый план запуска продукта: фазы, каналы, тайминг | Все |
| [pricing-strategy](./pricing-strategy) | Маркетинг | Ценообразование и упаковка тарифов | Все |
| [email-sequence](./email-sequence) | Маркетинг | Цепочки писем: онбординг, прогрев, реактивация | Все |
| [analytics-tracking](./analytics-tracking) | Аналитика | Настроить аналитику и события — что и как мерить | Все |
| [seo-audit](./seo-audit) | Маркетинг | SEO-аудит сайта: приоритизированный список фиксов | Все |
| [ai-agents-architect](./ai-agents-architect) | AI и нейросети | Спроектировать архитектуру AI-агентов и мультиагентных систем | Все |
| [voice-agents](./voice-agents) | AI и нейросети | Голосовые ассистенты/боты: STT, TTS, диалог | Все |
| [telegram-bot-builder](./telegram-bot-builder) | Разработка | Сделать Telegram-бота: команды, меню, вебхуки, интеграции | Все |
| [claude-video](./claude-video) | Контент | Claude «смотрит» видео: конспект, тайм-коды, кадры из любого ролика | Все |
| [llm-cost-optimizer](./llm-cost-optimizer) | AI и нейросети | Срезать расходы на LLM-API: маршрутизация, кэширование, аудит токенов | Все |
| [llm-council](./llm-council) | AI и нейросети | Совет из 3-4 AI-советников: независимые мнения, ревью, синтез решения | Все |

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
