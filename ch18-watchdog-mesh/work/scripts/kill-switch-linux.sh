#!/usr/bin/env bash
# Kill-switch hook for the watchdog mesh — Linux variant.
# Identical logic to kill-switch.sh: reads the PreToolUse JSON payload
# on stdin, gates only on the "[WATCHDOG:ESCALATE]" prefix, blocks with
# exit 2. The only difference is notify-send (libnotify) instead of
# osascript for the desktop notification.

set -euo pipefail

LOG=~/work/watchdog/escalations.log
mkdir -p "$(dirname "$LOG")"

PAYLOAD=$(cat)
TOOL_NAME=$(echo "$PAYLOAD" | jq -r '.tool_name // "unknown"')
MESSAGE=$(echo "$PAYLOAD" | jq -r '.tool_input.text // .tool_input.message // ""')

if [[ "$MESSAGE" != *"[WATCHDOG:ESCALATE]"* ]]; then
  exit 0
fi

PROPOSED_ACTION="$TOOL_NAME: ${MESSAGE:0:80}"
CODE=$(printf "%04d" $((RANDOM % 10000)))

echo "[$(date -Iseconds)] INTERCEPT: $PROPOSED_ACTION" >> "$LOG"

# notify-send is the standard Linux desktop notification tool (libnotify).
notify-send "Kill-switch" "Watchdog wants to: $PROPOSED_ACTION. Type code $CODE to approve."

read -r -t 60 -p "Enter 4-digit code to approve: " ENTERED || { echo "[$(date -Iseconds)] DENIED (timeout): $PROPOSED_ACTION" >> "$LOG"; echo "Kill-switch timed out" >&2; exit 2; }

if [[ "$ENTERED" == "$CODE" ]]; then
  echo "[$(date -Iseconds)] APPROVED: $PROPOSED_ACTION" >> "$LOG"
  exit 0
else
  echo "[$(date -Iseconds)] DENIED (wrong code): $PROPOSED_ACTION" >> "$LOG"
  echo "Kill-switch denied: wrong code" >&2
  exit 2
fi
