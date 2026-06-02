#!/usr/bin/env bash
# Iris's morning run. Resumes her named session, runs the routing,
# saves Notion rows + Gmail drafts, exits.

set -euo pipefail
TODAY=$(date +%Y-%m-%d)

cd ~/work
claude --resume iris \
  --agent iris \
  -p "Read the last 12 hours of Gmail and today's calendar.
      Route each thread per your file. Create Notion task rows
      and project notes. Save Gmail drafts. Do NOT send.
      Do not re-process threads you routed in earlier sessions
      unless they have new replies. When done, write the queue
      summary."
