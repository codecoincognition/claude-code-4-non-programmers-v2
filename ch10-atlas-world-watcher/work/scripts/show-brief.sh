#!/usr/bin/env bash
#
# show-brief.sh — Maya's morning brief.
#
# Built up across the book:
#   Ch 7  — sections 1 (priorities) and 2 (Iris's queue).
#   Ch 9  — section 4 below was Drafts; Iris extended it.
#   Ch 10 — adds the "Atlas's signals" section (section 3 here).
#
# Each section degrades gracefully: missing files never crash the
# brief. The Atlas section collapses to "all quiet." on quiet days.
#
set -uo pipefail

WORK="${HOME}/work"

# 1. Today's priorities — first section.
echo "── Today's priorities ──"
if [[ -f "${WORK}/priorities.md" ]]; then
  grep -E '^- ' "${WORK}/priorities.md" | sed 's/^- /  /' | head -n 5
else
  echo "  (no priorities file yet)"
fi

# 2. Iris's queue — second section.
echo
echo "── Iris's queue ──"
IRIS_FILE="$(ls -1t "${WORK}/inbox/queue-"*.md 2>/dev/null | head -n 1)"
if [[ -z "${IRIS_FILE:-}" ]]; then
  echo "  (no Iris queue file yet)"
else
  grep -E '^- ' "$IRIS_FILE" | sed 's/^- /  /'
fi

# 3. Atlas's signals — third section. (Added in Chapter 10.)
ATLAS_FILE="$(ls -1t "${HOME}/work/atlas/signals-"*.md 2>/dev/null | head -n 1)"
echo
echo "── Atlas's signals ──"
if [[ -z "${ATLAS_FILE:-}" ]]; then
  echo "  (no Atlas signal file yet — first run pending)"
elif grep -qi 'no signals' "$ATLAS_FILE" \
     && ! grep -q '^- \*\*' "$ATLAS_FILE"; then
  echo "  all quiet."
else
  grep -E '^- \*\*' "$ATLAS_FILE" | sed 's/^/  /'
fi

# 4. Drafts — fourth section.
echo
echo "── Drafts ──"
DRAFT_DIR="${WORK}/inbox/drafts"
if [[ -d "$DRAFT_DIR" ]] && [[ -n "$(ls -A "$DRAFT_DIR" 2>/dev/null)" ]]; then
  echo "  (Iris drafts staged at ~/work/inbox/drafts/.)"
else
  echo "  (no drafts staged)"
fi
