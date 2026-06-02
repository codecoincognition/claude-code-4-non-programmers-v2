#!/usr/bin/env bash
# Morning brief assembler. Now with two sections:
# (1) Today's priorities (from Ch 7)
# (2) Iris's queue       (added Ch 9)
set -euo pipefail
TODAY=$(date +%Y-%m-%d)

echo "# Today's brief — $TODAY"
echo

# Section 1 — priorities (from Ch 7)
if [[ -f ~/work/briefs/inbox-$TODAY.md ]]; then
  cat ~/work/briefs/inbox-$TODAY.md
else
  echo "_(no priorities brief yet)_"
fi

echo
echo "---"
echo

# Section 2 — Iris's queue (new in Ch 9)
if [[ -f ~/work/queue/$TODAY.md ]]; then
  cat ~/work/queue/$TODAY.md
else
  echo "_(Iris hasn't run yet today — she's scheduled at 6:25 AM)_"
fi
