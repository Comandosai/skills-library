#!/usr/bin/env bash
set -euo pipefail

PORT="${CAMOFOX_PORT:-9377}"
BASE="http://127.0.0.1:${PORT}"
WORKDIR="${CAMOFOX_WORKDIR:-$HOME/camofox-browser}"
DISPLAY_NUM="${CAMOFOX_DISPLAY:-:99}"

echo "==> Checking Camofox server: $BASE"
if ! curl -fsS "$BASE/health"; then
  echo
  echo "ERROR: Camofox server is not healthy on $BASE" >&2
  echo "Start it with: ${WORKDIR}/run-camofox-browser.sh" >&2
  exit 1
fi

echo
echo "==> Checking browser process"
ps -eo pid,comm,args | grep -E 'camofox-browser|camoufox|firefox|Xvfb' | grep -v grep || true

if [ -f "skills/productivity/camofox-browser-operator/scripts/check-camoufox-oscpu.py" ] && [ -x "$WORKDIR/.venv-camoufox-check/bin/python" ]; then
  echo
  echo "==> Running optional Camoufox oscpu fingerprint smoke test"
  DISPLAY="$DISPLAY_NUM" "$WORKDIR/.venv-camoufox-check/bin/python" \
    skills/productivity/camofox-browser-operator/scripts/check-camoufox-oscpu.py || true
else
  echo
  echo "WARN: optional oscpu smoke test skipped. Run from repo root after install script if needed."
fi

cat <<EOF

==> Basic verification done.

Hermes env should include:
  CAMOFOX_URL=$BASE

Try:
  hermes chat -s camofox-browser-operator,browser-form-workflows -q "Открой example.com и скажи заголовок страницы" --toolsets browser,terminal,file,skills
EOF
