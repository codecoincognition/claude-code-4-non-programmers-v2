#!/usr/bin/env bash
# SessionStart hook from Chapter 7 — shows today's morning brief when a
# new Claude session starts in ~/work/. Included here so this chapter's
# settings.json is complete and runnable on its own.
#
# Prints the most recent brief file under ~/work/briefs/ if one exists.
# Never blocks a session start (always exits 0).

set -u
BRIEFS_DIR="${HOME}/work/briefs"

if [ -d "$BRIEFS_DIR" ]; then
  LATEST="$(ls -t "$BRIEFS_DIR"/*.md 2>/dev/null | head -1 || true)"
  if [ -n "${LATEST:-}" ]; then
    echo "── Today's brief ($(basename "$LATEST")) ──"
    cat "$LATEST"
    echo "──────────────────────────────────────────"
  fi
fi

exit 0
