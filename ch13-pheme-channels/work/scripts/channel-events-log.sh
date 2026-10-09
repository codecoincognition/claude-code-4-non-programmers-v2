#!/usr/bin/env bash
# PreToolUse hook: log every message Pheme sends back through a channel
# to ~/work/.claude/audit/channel-events.log, one line per reply:
#   timestamp <tab> channel <tab> chat_id <tab> first 80 characters
# It never blocks a reply: it always exits 0, even if logging fails.

LOG="$HOME/work/.claude/audit/channel-events.log"
mkdir -p "$(dirname "$LOG")" 2>/dev/null || exit 0

input="$(cat)"
ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

if command -v jq > /dev/null 2>&1; then
  line="$(printf '%s' "$input" | jq -r '
    [ (.tool_name | sub("^mcp__(plugin_[^_]+_)?"; "") | sub("__.*$"; "")),
      (.tool_input.chat_id // "-" | tostring),
      ((.tool_input.text // "") | gsub("[\r\n\t]"; " ") | .[0:80]) ]
    | @tsv' 2>/dev/null)"
else
  # No jq: keep the raw event, flattened and trimmed.
  line="$(printf '%s' "$input" | tr '\n\t' '  ' | cut -c1-300)"
fi

printf '%s\t%s\n' "$ts" "${line:-unparsed}" >> "$LOG" 2>/dev/null
exit 0
