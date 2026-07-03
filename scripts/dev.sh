#!/usr/bin/env bash
set -euo pipefail

PORT=4173
URL="http://127.0.0.1:${PORT}/"

if command -v open >/dev/null 2>&1; then
  OPEN_CMD="open"
elif command -v xdg-open >/dev/null 2>&1; then
  OPEN_CMD="xdg-open"
else
  OPEN_CMD=""
fi

echo "Starting local site on ${URL}"
python3 -m http.server "${PORT}" --bind 0.0.0.0 &
SERVER_PID=$!

sleep 1
if [ -n "$OPEN_CMD" ]; then
  "$OPEN_CMD" "$URL"
fi

echo "Server PID: $SERVER_PID. Press Ctrl+C to stop."
wait "$SERVER_PID"
