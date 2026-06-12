#!/usr/bin/env bash
set -euo pipefail

WORKDIR="${CAMOFOX_WORKDIR:-$HOME/camofox-browser}"
PORT="${CAMOFOX_PORT:-9377}"
DISPLAY_NUM="${CAMOFOX_DISPLAY:-:99}"
TIMEZONE="${CAMOFOX_DEFAULT_TIMEZONE:-Europe/Moscow}"
LAT="${CAMOFOX_DEFAULT_LAT:-55.7558}"
LON="${CAMOFOX_DEFAULT_LON:-37.6173}"
LOCALE="${CAMOFOX_DEFAULT_LOCALE:-ru-RU}"

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

echo "==> Installing Camofox browser service"
echo "workdir: $WORKDIR"
echo "port:    $PORT"
echo "display: $DISPLAY_NUM"

if ! need_cmd node; then
  echo "ERROR: node is not installed. Install Node.js 20+ first." >&2
  exit 1
fi
if ! need_cmd npm; then
  echo "ERROR: npm is not installed. Install npm first." >&2
  exit 1
fi

mkdir -p "$WORKDIR"
cd "$WORKDIR"

if [ ! -f package.json ]; then
  npm init -y >/dev/null
fi

npm install @askjo/camofox-browser@latest

# Optional but recommended for the standalone Python fingerprint check script.
if need_cmd python3; then
  python3 -m venv "$WORKDIR/.venv-camoufox-check" || true
  if [ -x "$WORKDIR/.venv-camoufox-check/bin/pip" ]; then
    "$WORKDIR/.venv-camoufox-check/bin/pip" install -q -U pip camoufox || true
  fi
fi

if ! pgrep -f "Xvfb ${DISPLAY_NUM}" >/dev/null 2>&1; then
  if need_cmd Xvfb; then
    echo "==> Starting Xvfb on $DISPLAY_NUM"
    nohup Xvfb "${DISPLAY_NUM}" -screen 0 1920x1080x24 >/tmp/camofox-xvfb.log 2>&1 &
    sleep 1
  else
    echo "WARN: Xvfb not found. Install it or run on a machine with a real display." >&2
  fi
else
  echo "==> Xvfb already running on $DISPLAY_NUM"
fi

cat > "$WORKDIR/run-camofox-browser.sh" <<EOF
#!/usr/bin/env bash
set -euo pipefail
cd "$WORKDIR"
DISPLAY="$DISPLAY_NUM" \\
CAMOFOX_FORCE_HEADFUL=1 \\
CAMOFOX_DISABLE_VIRTUAL_DISPLAY=1 \\
CAMOFOX_DEFAULT_TIMEZONE="$TIMEZONE" \\
CAMOFOX_DEFAULT_LAT="$LAT" \\
CAMOFOX_DEFAULT_LON="$LON" \\
CAMOFOX_DEFAULT_LOCALE="$LOCALE" \\
CAMOFOX_PORT="$PORT" \\
BROWSER_IDLE_TIMEOUT_MS=900000 \\
SESSION_TIMEOUT_MS=1800000 \\
TAB_INACTIVITY_MS=900000 \\
./node_modules/.bin/camofox-browser
EOF
chmod +x "$WORKDIR/run-camofox-browser.sh"

cat > "$WORKDIR/camofox-browser.env" <<EOF
CAMOFOX_URL=http://127.0.0.1:$PORT
CAMOFOX_WORKDIR=$WORKDIR
CAMOFOX_PORT=$PORT
CAMOFOX_DISPLAY=$DISPLAY_NUM
CAMOFOX_DEFAULT_TIMEZONE=$TIMEZONE
CAMOFOX_DEFAULT_LAT=$LAT
CAMOFOX_DEFAULT_LON=$LON
CAMOFOX_DEFAULT_LOCALE=$LOCALE
EOF

cat <<EOF

==> Installed.

Start service manually:
  $WORKDIR/run-camofox-browser.sh

Add to ~/.hermes/.env:
  CAMOFOX_URL=http://127.0.0.1:$PORT

Then restart Hermes gateway or start a new Hermes CLI session:
  hermes gateway restart

EOF
