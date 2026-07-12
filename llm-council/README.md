<div align="center">

# 🏛 llm-council

**Собирает совет из 3-4 ролей-советников Claude, которые спорят и синтезируют вердикт.**

[![Telegram](https://img.shields.io/badge/Telegram-@ai__comandos-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ai_comandos)
[![Открыть на comandos.ai](https://img.shields.io/badge/Открыть_на_comandos.ai-→-A3E635?style=for-the-badge&logoColor=black)](https://comandos.ai/hub/skills/llm-council)

</div>

По мотивам [LLM Council](https://github.com/karpathy/llm-council) Андрея Карпати (MIT) —
не порт кода, а переосмысление идеи под Claude Code: вместо разных вендоров-моделей
навык запускает несколько сабагентов Claude с разными ролями-линзами. Каждый отвечает
независимо → анонимно ревьюет чужие аргументы → председатель синтезирует финал, честно
показывая и согласие, и разногласие.

- **`SKILL.md`** — сам навык (по-русски, ставится агенту).
- **`MARKETPLACE.md`** — подробно: боль, как работает, когда включать.
- **`manifest.yaml`** — метаданные карточки.

## Установка

Скопируй папку в `~/.claude/skills/llm-council/` — или возьми готовый промпт установки на
**[странице навыка](https://comandos.ai/hub/skills/llm-council)**. Триггеры: «собери совет»,
«нужно взвешенное решение», «проверь моё решение с разных сторон».

---

<div align="center">

📲 Больше навыков, кейсов и разборов нейросетей по-русски — **[t.me/ai_comandos](https://t.me/ai_comandos)**

<sub>Придумано и локализовано командой <a href="https://comandos.ai">COMANDOS</a> · вдохновлено LLM Council Андрея Карпати</sub>

</div>
