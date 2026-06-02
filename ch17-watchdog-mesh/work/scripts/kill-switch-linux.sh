#!/usr/bin/env bash
# Kill-switch hook for the watchdog mesh — Linux variant.
# Identical to kill-switch.sh except it uses notify-send for the desktop notification.

set -euo pipefail

LOG=~/work/watchdog/escalations.log
PROPOSED_ACTION="${1:-unspecified}"
CODE=$(printf "%04d" $((RANDOM % 10000)))

echo "[$(date -Iseconds)] INTERCEPT: $PROPOSED_ACTION" >> "$LOG"

# notify-send is the standard Linux desktop notification tool (libnotify).
notify-send "Kill-switch" "Watchdog wants to: $PROPOSED_ACTION. Type code $CODE to approve."

read -r -t 60 -p "Enter 4-digit code to approve: " ENTERED || { echo "[$(date -Iseconds)] DENIED (timeout): $PROPOSED_ACTION" >> "$LOG"; exit 1; }

if [[ "$ENTERED" == "$CODE" ]]; then
  echo "[$(date -Iseconds)] APPROVED: $PROPOSED_ACTION" >> "$LOG"
  exit 0
else
  echo "[$(date -Iseconds)] DENIED (wrong code): $PROPOSED_ACTION" >> "$LOG"
  exit 1
fi
