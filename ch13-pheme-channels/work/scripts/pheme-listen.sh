#!/usr/bin/env bash
# Run in a terminal tab you leave open. Pheme listens here.
set -euo pipefail

cd ~/work

CHANNELS=(
  plugin:telegram@claude-plugins-official
  plugin:imessage@claude-plugins-official
)

# A fixed session ID lets this script tell a first run from a later one.
# `claude --resume pheme` only works once a session named "pheme" exists,
# so the first run creates it and every later run resumes it.
PHEME_SESSION=4f7e2a9c-5b1d-4c3e-8a6f-2d9b7e1c0a53
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

if compgen -G "$CLAUDE_DIR/projects/*/$PHEME_SESSION.jsonl" > /dev/null; then
  exec claude --resume "$PHEME_SESSION" \
    --agent pheme \
    --channels "${CHANNELS[@]}"
else
  exec claude --session-id "$PHEME_SESSION" --name pheme \
    --agent pheme \
    --channels "${CHANNELS[@]}"
fi
