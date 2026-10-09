#!/usr/bin/env bash
# show-brief.sh — the morning brief.
#
# First introduced in Chapter 7 (Today's priorities). Extended in
# Chapter 9 (Iris's queue), Chapter 10 (Atlas's signals), Chapter 11
# (Reuben's filing), and Chapter 12 (Echo's proposals — section 5).
#
# Invoked by the SessionStart hook. Reads from disk only —
# the agents write their queues; this script just displays them.

set -uo pipefail

# 1. Today's priorities.
echo "── Today's priorities ──"
PRIORITIES_FILE="${HOME}/work/priorities.md"
if [[ -f "$PRIORITIES_FILE" ]]; then
  COMMITMENTS=$(grep -cE '^- ' "$PRIORITIES_FILE" 2>/dev/null; true)
  echo "  $COMMITMENTS commitments due this week."
else
  echo "  (no priorities file yet)"
fi

# 2. Iris's queue.
echo
echo "── Iris's queue ──"
# Iris writes ~/work/queue/{date}.md; section headers carry the counts,
# e.g. "## Notion tasks created (7)" and "## Drafts ready (4)".
IRIS_FILE="$(ls -1t "${HOME}/work/queue/"[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].md 2>/dev/null | head -n 1)"
if [[ -n "${IRIS_FILE:-}" ]]; then
  ACTIONS=$(grep -oE '^## Notion tasks created \([0-9]+\)' "$IRIS_FILE" | grep -oE '[0-9]+' | head -n 1)
  DRAFTS=$(grep -oE '^## Drafts ready \([0-9]+\)' "$IRIS_FILE" | grep -oE '[0-9]+' | head -n 1)
  echo "  ${ACTIONS:-0} actions routed to Notion Tasks."
  echo "  ${DRAFTS:-0} drafts ready for review."
else
  echo "  (no Iris queue yet)"
fi

# 3. Atlas's signals.
echo
echo "── Atlas's signals ──"
ATLAS_FILE="$(ls -1t "${HOME}/work/atlas/signals-"*.md 2>/dev/null | head -n 1)"
if [[ -n "${ATLAS_FILE:-}" ]]; then
  SIGNALS=$(grep -cE '^- \*\*' "$ATLAS_FILE" 2>/dev/null; true)
  if [[ "$SIGNALS" == "0" ]]; then
    echo "  all quiet."
  else
    echo "  $SIGNALS signals — see $ATLAS_FILE"
  fi
else
  echo "  all quiet."
fi

# 4. Reuben's filing.
echo
echo "── Reuben's filing ──"
# Reuben appends one line per filing to ~/work/books/filing-log.md (Chapter 11).
REUBEN_FILE="${HOME}/work/books/filing-log.md"
if [[ -f "$REUBEN_FILE" ]] && grep -q . "$REUBEN_FILE"; then
  echo "  $(grep . "$REUBEN_FILE" | tail -n 1)"
else
  echo "  (no filing status yet)"
fi

# 5. Echo's proposals — fifth section.
ECHO_FILE="$(ls -1t "${HOME}/work/echo/proposed-"*.md 2>/dev/null | head -n 1)"
echo
echo "── Echo's proposals ──"
if [[ -z "${ECHO_FILE:-}" ]]; then
  echo "  (no Echo proposal queue yet — first run pending)"
else
  MISSING=$(grep -cE '^[0-9]+\.' "$ECHO_FILE" 2>/dev/null; true)
  if [[ "$MISSING" == "0" ]]; then
    echo "  CRM is clean."
  else
    echo "  $MISSING proposals — see $ECHO_FILE"
  fi
fi
