#!/usr/bin/env bash
# prove-it.sh — exercise the Echo reconciliation logic against fixture
# data and assert that the right proposals fire. No MCP connection
# needed; reads fixtures/*.json and work/.claude/memory/echo/.
#
# This is a logic-level smoke test of the read-vs-write asymmetry
# pattern: given outbound mail, calendar, a CRM snapshot, and the
# non-prospects memory file, the four expected categories should fire
# and Sarah Chen should NOT.
#
# Requires: jq.

set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIX="$HERE/fixtures"
MEM="$HERE/work/.claude/memory/echo"

command -v jq >/dev/null 2>&1 || { echo "FAIL: jq not installed"; exit 1; }

PASS=0
FAIL=0
check() {  # check "label" "expected" "actual"
  if [[ "$2" == "$3" ]]; then
    echo "  PASS  $1"
    PASS=$((PASS + 1))
  else
    echo "  FAIL  $1 (expected '$2', got '$3')"
    FAIL=$((FAIL + 1))
  fi
}

echo "Echo prove-it — reconciling fixtures against CRM snapshot"
echo

# Load the non-prospects list (emails Echo must skip).
NONPROSPECTS="$(grep -oE '[a-z0-9._-]+@[a-z0-9.-]+' "$MEM/non-prospects.md" || true)"

is_nonprospect() {  # email
  echo "$NONPROSPECTS" | grep -qix "$1"
}

# Prospect-evidence keywords.
EVIDENCE='pric|demo|tier|contract|redline|proposal|evaluat|seats|sso|audit log'

# --- Test 1: Beacon Health is a MISSING ENTRY with evidence ---
beacon_in_crm=$(jq -r '[.[] | select(.email=="aria@beaconhealth.example")] | length' "$FIX/crm.json")
beacon_evidence=$(jq -r '[.[] | select(.counterparty=="aria@beaconhealth.example")] | .[].body_excerpt' "$FIX/sent-mail.json" | grep -ciE "$EVIDENCE")
if [[ "$beacon_in_crm" == "0" && "$beacon_evidence" -gt 0 ]]; then RES="propose"; else RES="skip"; fi
check "Beacon Health -> missing-entry proposal" "propose" "$RES"

# --- Test 2: Acme Robotics is a STALE STAGE (Discovery + contract redline) ---
acme_stage=$(jq -r '.[] | select(.company=="Acme Robotics") | .stage' "$FIX/crm.json")
acme_redline=$(jq -r '[.[] | select(.company=="Acme Robotics")] | .[].body_excerpt' "$FIX/sent-mail.json" | grep -ciE 'redline|contract|terms')
if [[ "$acme_stage" == "Discovery" && "$acme_redline" -gt 0 ]]; then RES="stale"; else RES="ok"; fi
check "Acme Robotics -> stale-stage proposal" "stale" "$RES"

# --- Test 3: Sigma Logistics is COLD WITHOUT STATUS (>30 days, no status) ---
sigma_status=$(jq -r '.[] | select(.company=="Sigma Logistics") | .status' "$FIX/crm.json")
sigma_last=$(jq -r '.[] | select(.company=="Sigma Logistics") | .last_contact' "$FIX/crm.json")
# Treat the run date as 2026-05-07 (matches the chapter's first pass).
days=$(( ( $(date -j -f "%Y-%m-%d" "2026-05-07" "+%s" 2>/dev/null || date -d "2026-05-07" "+%s") \
           - $(date -j -f "%Y-%m-%d" "$sigma_last" "+%s" 2>/dev/null || date -d "$sigma_last" "+%s") ) / 86400 ))
if [[ "$sigma_status" == "null" && "$days" -gt 30 ]]; then RES="cold"; else RES="ok"; fi
check "Sigma Logistics -> cold-without-status proposal ($days days)" "cold" "$RES"

# --- Test 4: Sarah Chen is NOT proposed (non-prospect + no evidence) ---
sarah_evidence=$(jq -r '[.[] | select(.counterparty=="sarah@chen-consulting.example")] | .[].body_excerpt' "$FIX/sent-mail.json" | grep -ciE "$EVIDENCE")
if is_nonprospect "sarah@chen-consulting.example" || [[ "$sarah_evidence" == "0" ]]; then RES="skip"; else RES="propose"; fi
check "Sarah Chen -> NOT proposed (non-prospect, no evidence)" "skip" "$RES"

echo
echo "Result: $PASS passed, $FAIL failed."
[[ "$FAIL" == "0" ]] && exit 0 || exit 1
