#!/usr/bin/env bash
# iris-launcher.sh — thin wrapper that resumes Iris's named long-running
# session and feeds her the morning routing prompt.
#
# Mirrors the shape used by ~/work/scripts/iris-morning.sh (which is
# what cron schedules). This launcher is the on-demand equivalent —
# run it from the terminal any time you want a fresh routing pass
# without waiting for the 6:25 AM cron.
#
# Uses `claude --resume iris` to pick up Iris's accumulated memory
# (she remembers which threads she already routed) and `--agent iris`
# to load her agent file's tools, hooks, and voice rules.

set -euo pipefail

cd "${HOME}/work"

claude --resume iris \
  --agent iris \
  -p "Read the last 12 hours of Gmail and today's calendar.
      Route each thread per your file. Create Notion task rows
      and project notes. Save Gmail drafts. Do NOT send.
      Do not re-process threads you routed in earlier sessions
      unless they have new replies. When done, write the queue
      summary."
