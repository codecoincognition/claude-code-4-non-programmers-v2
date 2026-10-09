#!/usr/bin/env bash
# Kill-switch hook for the watchdog mesh.
# Reads the PreToolUse JSON payload from stdin, decides whether the
# call belongs to the watchdog at escalate tier, and (if so) requires
# typed-code confirmation. Anything else passes through.
#
# Two facts about hooks shape this script:
#  - A hook has no terminal, and its stdin is the JSON payload, so the code
#    is typed into a macOS dialog, not at a prompt.
#  - Only exit code 2 blocks the tool call. A crash, any other exit code, or
#    a hook that runs past its timeout lets the call go through. So once a
#    message is known to be an escalation, every failure path exits 2.

set -uo pipefail

LOG=~/work/watchdog/escalations.log
mkdir -p "$(dirname "$LOG")"

PAYLOAD=$(cat)                                  # PreToolUse sends JSON on stdin

# Only gate watchdog-orchestrator escalate-tier sends. The orchestrator
# tags its escalate messages with a "[WATCHDOG:ESCALATE]" prefix; quiet
# notify-tier sends from the same agent don't carry the prefix and pass.
# Matched on the raw payload, so a missing or failing jq can't let one through.
if [[ "$PAYLOAD" != *"[WATCHDOG:ESCALATE]"* ]]; then
  exit 0                                        # pass through, no gate
fi

trap 'echo "Kill-switch error; blocking to be safe" >&2; exit 2' ERR

TOOL_NAME=$(printf '%s' "$PAYLOAD" | jq -r '.tool_name // "unknown"' 2>/dev/null) || TOOL_NAME="unknown"
MESSAGE=$(printf '%s' "$PAYLOAD" | jq -r '.tool_input.text // .tool_input.message // ""' 2>/dev/null) || MESSAGE="[WATCHDOG:ESCALATE] (message could not be read)"

PROPOSED_ACTION="$TOOL_NAME: ${MESSAGE:0:80}"
CODE=$(printf "%04d" $((RANDOM % 10000)))

echo "[$(date -Iseconds)] INTERCEPT: $PROPOSED_ACTION" >> "$LOG"

# Show the proposed action and the code in a native macOS dialog, and wait
# for the code to be typed back. (osascript is macOS's command-line scripting
# tool. On Linux use kill-switch-linux.sh; on Windows, kill-switch-windows.ps1.)
# The action text and the code are passed to AppleScript as arguments, never
# pasted into the script, so quotes in an alert cannot run commands. The
# dialog gives up after 50 seconds, which counts as a denial and is well
# inside the hook's default 600-second timeout.
ENTERED=$(osascript - "$PROPOSED_ACTION" "$CODE" 2>/dev/null <<'APPLESCRIPT'
on run argv
  set r to display dialog ("Watchdog wants to: " & item 1 of argv & return & return & "Type code " & item 2 of argv & " to approve.") default answer "" with title "Kill-switch" buttons {"Deny", "Approve"} default button "Approve" cancel button "Deny" giving up after 50
  if gave up of r then return ""
  return text returned of r
end run
APPLESCRIPT
) || ENTERED=""

# Exit 2 tells Claude Code to BLOCK the tool call and shows the stderr
# message to Claude. It is the only exit code that blocks.
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
