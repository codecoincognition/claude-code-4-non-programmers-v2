#!/usr/bin/env bash
# Appends one line per tool call to ~/work/.claude/audit.log.
# Reads the hook payload from stdin as JSON. Never blocks (always exits 0).

set -u
LOG="${HOME}/work/.claude/audit.log"
mkdir -p "$(dirname "$LOG")"

PAYLOAD="$(cat)"
TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
TOOL="$(printf '%s' "$PAYLOAD" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_name",""))' 2>/dev/null || printf 'unknown')"
ARGS="$(printf '%s' "$PAYLOAD" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(json.dumps(d.get("tool_input",{}))[:200])' 2>/dev/null || printf '{}')"

printf '%s\t%s\t%s\n' "$TS" "$TOOL" "$ARGS" >> "$LOG"
exit 0
