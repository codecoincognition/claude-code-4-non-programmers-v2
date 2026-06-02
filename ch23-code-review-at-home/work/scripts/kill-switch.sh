#!/usr/bin/env bash
#
# kill-switch.sh — extends the watchdog mesh (Ch 17).
#
# On invocation: generate a 4-digit confirmation code, prompt the
# operator to re-enter it, and (on match) escalate — write to the
# escalation log and post to Slack.
#
# This is the POST-SANDBOX version. The two /sandbox findings from
# Ch 23 are applied:
#   - Test 2 (WARN): input length validation before comparison.
#   - Test 3 (FAIL): osascript dependency check + portable fallback.
#
set -euo pipefail

LOG="${HOME}/work/watchdog/escalations.log"
SLACK_WEBHOOK="${SLACK_WEBHOOK_URL:-}"

# --- Test 3 fix: notify portably, never crash on missing osascript ---
notify() {
  local msg="$1"
  if command -v osascript >/dev/null 2>&1; then
    osascript -e "display notification \"${msg}\" with title \"Kill-switch\""
  elif command -v notify-send >/dev/null 2>&1; then
    notify-send "Kill-switch" "${msg}"
  else
    printf 'Kill-switch: %s\n' "${msg}"
  fi
}

# --- Generate a 4-digit confirmation code ---
CODE="$(printf '%04d' $(( RANDOM % 10000 )))"
echo "Confirmation code: ${CODE}"
echo "Re-enter the code to confirm escalation:"
read -r ENTERED

# --- Test 2 fix: validate input length before comparing ---
if [[ -z "${ENTERED}" ]] || [[ "${#ENTERED}" -ne 4 ]]; then
  echo "error: confirmation code must be exactly 4 digits" >&2
  exit 1
fi

if [[ "${ENTERED}" != "${CODE}" ]]; then
  echo "Code mismatch — escalation aborted."
  exit 1
fi

# --- Escalate: log + Slack + notify ---
mkdir -p "$(dirname "${LOG}")"
printf '%s ESCALATION confirmed code=%s\n' "$(date -u +%FT%TZ)" "${CODE}" >> "${LOG}"

if [[ -n "${SLACK_WEBHOOK}" ]]; then
  curl -fsS -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"Kill-switch escalation confirmed at $(date -u +%FT%TZ)\"}" \
    "${SLACK_WEBHOOK}" >/dev/null
fi

notify "Escalation confirmed."
echo "Escalation complete. Logged to ${LOG}."
exit 0
