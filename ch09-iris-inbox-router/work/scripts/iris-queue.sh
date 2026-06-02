#!/usr/bin/env bash
# iris-queue.sh — Stop-hook aggregator (Ch 9).
# Fires when the `iris` agent session ends. Reads what Iris created
# this session (Notion task URLs, project-note appends, Gmail draft
# IDs), grabs the recipient + subject + first 30 words for each draft,
# asks Iris for the one-line "why I routed it this way" reason, and
# writes the lot into ~/work/queue/{date}.md.
#
# In the book, Claude generates this from plain English. The Notion /
# Gmail reads happen through Iris's session; this script is the thin
# shell that assembles the markdown queue file. Below is the shape —
# the session-introspection lines are stubbed so the file is runnable
# and the numeric-flagging logic (the load-bearing part) is exact.

set -euo pipefail
TODAY=$(date +%Y-%m-%d)
queue_dir=~/work/queue
queue_file="$queue_dir/$TODAY.md"
mkdir -p "$queue_dir"

# Iris's session writes her routing summary to this scratch file as she
# works; the hook reads it back and turns each line into a queue entry.
session_summary=~/work/queue/.iris-session-$TODAY.md

{
  echo "# Iris's queue — $(date '+%a %b %d, %Y')"
  echo
  if [[ -f "$session_summary" ]]; then
    cat "$session_summary"
  else
    echo "_(Iris produced no routing summary this session.)_"
  fi
} > "$queue_file"

# Flag drafts / tasks with numeric figures (Ch 9 — defense
# against skim-approve). Appends a [verify-numbers] marker to any
# queue entry that contains a dollar figure, percentage, or bare number.
while IFS= read -r queue_entry; do
  if grep -E '\$[0-9]|[0-9]+%|\b[0-9]+\b' <<< "$queue_entry" > /dev/null; then
    echo "  [verify-numbers]" >> "$queue_file"
  fi
done < "$queue_file"

echo "Wrote $queue_file"
