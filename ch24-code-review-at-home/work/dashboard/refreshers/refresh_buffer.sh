#!/usr/bin/env bash
#
# refresh_buffer.sh — sync the Buffer queue into the dashboard cache.
#
# POST-review version: set -euo pipefail + exit-code propagation
# (applied per file in Ch 24; six similar tweaks are below /batch's threshold).
#
set -euo pipefail

echo "Refreshing Buffer queue ..."
curl -fsS "https://api.bufferapp.com/queue?token=${BUFFER_TOKEN:?BUFFER_TOKEN not set}" \
  -o ~/work/dashboard/cache/buffer.json
RC=$?

if [[ "$RC" -ne 0 ]]; then
  echo "error: buffer refresh failed (rc=$RC)" >&2
  exit "$RC"
fi

echo "Buffer queue refreshed."
exit 0
