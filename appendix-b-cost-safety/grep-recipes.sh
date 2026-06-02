#!/usr/bin/env bash
#
# grep-recipes.sh — observability recipes from Appendix B, Section 3.
#
# These are the three grep/tail patterns the book uses most for diagnosing
# agents, hooks, and scheduled jobs. Each is a small function you can copy
# into your shell or run directly. They assume the log conventions in the
# README: hooks under ~/.claude/logs/hooks/, jobs under ~/.claude/logs/jobs/,
# MCP server logs under ~/Library/Logs/Claude/ (macOS).
#
# Usage:
#   ./grep-recipes.sh did-hook-fire   sessionstart
#   ./grep-recipes.sh why-exit        reuben
#   ./grep-recipes.sh which-mcp       08:42
#   ./grep-recipes.sh watch           ~/.claude/logs/hooks/sessionstart.log
#
# Nothing here writes or deletes. All recipes are read-only.

set -euo pipefail

HOOK_LOG_DIR="${HOOK_LOG_DIR:-$HOME/.claude/logs/hooks}"
JOB_LOG_DIR="${JOB_LOG_DIR:-$HOME/.claude/logs/jobs}"
MCP_LOG_DIR="${MCP_LOG_DIR:-$HOME/Library/Logs/Claude}"   # Linux: ~/.config/Claude/logs

# "Did my hook fire this morning?"
# Show today's lines from a named hook log.
did_hook_fire() {
  local hook="${1:?usage: did-hook-fire <hookname>}"
  tail -100 "$HOOK_LOG_DIR/$hook.log" | grep "$(date +%Y-%m-%d)" || {
    echo "No lines for $(date +%Y-%m-%d) in $HOOK_LOG_DIR/$hook.log"
  }
}

# "Why did <job> exit with code 1?"
# Show the 5 lines of context before each non-zero exit, last 50 lines worth.
why_exit() {
  local job="${1:?usage: why-exit <jobname>}"
  grep -B 5 "exit 1" "$JOB_LOG_DIR/$job.log" | tail -50 || {
    echo "No 'exit 1' found in $JOB_LOG_DIR/$job.log"
  }
}

# "Which MCP returned the empty payload at <time>?"
# Show 10 lines after a timestamp across all MCP server logs.
which_mcp() {
  local stamp="${1:?usage: which-mcp <HH:MM>}"
  grep -A 10 "$stamp" "$MCP_LOG_DIR"/mcp-server-*.log 2>/dev/null || {
    echo "No match for '$stamp' in $MCP_LOG_DIR/mcp-server-*.log"
  }
}

# "Tail-while-it-happens" — follow a log in real time while you trigger an agent.
# Run this in a second terminal pane, then trigger the agent in the first.
watch_log() {
  local path="${1:?usage: watch <logfile>}"
  tail -F "$path"
}

cmd="${1:-help}"
shift || true
case "$cmd" in
  did-hook-fire) did_hook_fire "$@" ;;
  why-exit)      why_exit "$@" ;;
  which-mcp)     which_mcp "$@" ;;
  watch)         watch_log "$@" ;;
  *)
    grep -E '^#( |!)' "$0" | sed 's/^#! .*//; s/^# \{0,1\}//'
    echo
    echo "Commands: did-hook-fire | why-exit | which-mcp | watch"
    ;;
esac
