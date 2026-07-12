<div align="center">

# 🎬 claude-video

**Claude смотрит видео, извлекает кадры и пишет конспект с таймкодами — по одной команде /watch**

[![Telegram](https://img.shields.io/badge/Telegram-@ai__comandos-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/ai_comandos)
[![Открыть на comandos.ai](https://img.shields.io/badge/Открыть_на_comandos.ai-→-A3E635?style=for-the-badge&logoColor=black)](https://comandos.ai/hub/skills/claude-video)

</div>

Запусти `/watch <URL>` — Claude посмотрит видео (YouTube, Vimeo, TikTok, X, Twitch, Loom) напрямую. yt-dlp вытягивает субтитры без скачивания, ffmpeg нарезает ключевые кадры, Whisper опционально транскрибирует если субов нет. На выходе: структурированный конспект с таймкодами, список ключевых кадров и цитаты.

Идеален для конспектирования чужих вебинаров, разбора конкурентов и анализа собственного черновика перед публикацией. Видео остаются в Claude, никуда не отправляются. Зависит только от ffmpeg и yt-dlp (brew install), Python 3 stdlib — без pip. 7500+ звёзд на GitHub.

- **`SKILL.md`** — сам навык (англ. оригинал, ставится агенту).
- **`MARKETPLACE.md`** — подробно по-русски.
- **`manifest.yaml`** — метаданные карточки.

## Установка

Скопируй папку в `~/.claude/skills/claude-video/` — или возьми готовый промпт установки на
**[странице навыка](https://comandos.ai/hub/skills/claude-video)**.

---

<div align="center">

📲 Больше навыков и разборов нейросетей по-русски — **[t.me/ai_comandos](https://t.me/ai_comandos)**

<sub>Курировано и локализовано командой <a href="https://comandos.ai">COMANDOS</a> · оригинал: Brad Automates (claude-video)</sub>

</div>
