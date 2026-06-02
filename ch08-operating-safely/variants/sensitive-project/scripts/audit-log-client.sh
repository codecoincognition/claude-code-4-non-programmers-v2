#!/usr/bin/env bash
# Make it yours #1 (companion script) — like audit-log.sh, but tags every
# line with the client name taken from the current directory path
# (.../clients/{client}/...). Never blocks (always exits 0).

set -u
LOG="${HOME}/work/.claude/audit.log"
mkdir -p "$(dirname "$LOG")"

# Pull {client} out of the working directory, if present.
CLIENT="$(pwd | sed -n 's#.*/clients/\([^/]*\).*#\1#p')"
[ -z "$CLIENT" ] && CLIENT="-"

PAYLOAD="$(cat)"
TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
TOOL="$(printf '%s' "$PAYLOAD" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_name",""))' 2>/dev/null || printf 'unknown')"
ARGS="$(printf '%s' "$PAYLOAD" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(json.dumps(d.get("tool_input",{}))[:200])' 2>/dev/null || printf '{}')"

printf '%s\t[client:%s]\t%s\t%s\n' "$TS" "$CLIENT" "$TOOL" "$ARGS" >> "$LOG"
exit 0
