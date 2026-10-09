#!/usr/bin/env bash
# Kill-switch hook for the watchdog mesh — Linux variant.
# Same logic as kill-switch.sh: reads the PreToolUse JSON payload on stdin,
# gates only on the "[WATCHDOG:ESCALATE]" prefix, and blocks with exit 2.
# The difference is the dialog: zenity (GNOME's standard dialog tool) instead
# of osascript. Install it with your package manager if `zenity --version`
# fails; without it, every escalation is denied.
#
# Hooks have no terminal and only exit 2 blocks a tool call, so once a
# message is known to be an escalation, every failure path exits 2.

set -uo pipefail

LOG=~/work/watchdog/escalations.log
mkdir -p "$(dirname "$LOG")"

PAYLOAD=$(cat)

if [[ "$PAYLOAD" != *"[WATCHDOG:ESCALATE]"* ]]; then
  exit 0
fi

trap 'echo "Kill-switch error; blocking to be safe" >&2; exit 2' ERR

TOOL_NAME=$(printf '%s' "$PAYLOAD" | jq -r '.tool_name // "unknown"' 2>/dev/null) || TOOL_NAME="unknown"
MESSAGE=$(printf '%s' "$PAYLOAD" | jq -r '.tool_input.text // .tool_input.message // ""' 2>/dev/null) || MESSAGE="[WATCHDOG:ESCALATE] (message could not be read)"

PROPOSED_ACTION="$TOOL_NAME: ${MESSAGE:0:80}"
CODE=$(printf "%04d" $((RANDOM % 10000)))

echo "[$(date -Iseconds)] INTERCEPT: $PROPOSED_ACTION" >> "$LOG"

# zenity reads its text as Pango markup, so escape &, <, > first.
SAFE=${PROPOSED_ACTION//&/&amp;}
SAFE=${SAFE//</&lt;}
SAFE=${SAFE//>/&gt;}

if command -v zenity > /dev/null 2>&1; then
  ENTERED=$(zenity --entry --title="Kill-switch" \
    --text="Watchdog wants to: $SAFE

Type code $CODE to approve." --timeout=50 2>/dev/null) || ENTERED=""
else
  echo "zenity is not installed, so the code cannot be asked for" >&2
  ENTERED=""
fi

if [[ -z "$ENTERED" ]]; then
  echo "[$(date -Iseconds)] DENIED (no answer): $PROPOSED_ACTION" >> "$LOG"
  echo "Kill-switch denied: no code entered" >&2
  exit 2
elif [[ "$ENTERED" == "$CODE" ]]; then
  echo "[$(date -Iseconds)] APPROVED: $PROPOSED_ACTION" >> "$LOG"
  exit 0
else
  echo "[$(date -Iseconds)] DENIED (wrong code): $PROPOSED_ACTION" >> "$LOG"
  echo "Kill-switch denied: wrong code" >&2
  exit 2
fi
