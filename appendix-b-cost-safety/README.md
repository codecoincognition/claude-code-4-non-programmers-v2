# Appendix B — Cost & Safety (companion artifacts)

Reusable operator recipes from **Appendix B — Cost & safety**. Everything here
is read-only diagnostics: nothing in this folder writes, deletes, sends, or
spends. The appendix itself is mostly reference prose (token-budget shapes,
rate-limit symptom tables); the clone-ready part is the observability layer in
Section 3, which is what you'll find here.

> Reminder from the appendix: every number in the book is **shape, not number**.
> The Anthropic pricing page is canonical for per-token rates, vendor pages for
> their rate limits, and Anthropic's observability reference for current log
> paths. These scripts encode the *conventions*, not the guarantees.

## Files

| File | What it does |
|---|---|
| `grep-recipes.sh` | The three grep/tail diagnostics from Section 3, packaged as runnable shell functions, plus the "tail-while-it-happens" follow pattern. |

## Log path conventions

The recipes assume the layout the book recommends. Set these env vars to
override if your paths differ:

| What | Default | Env var |
|---|---|---|
| Hook logs | `~/.claude/logs/hooks/<hookname>.log` | `HOOK_LOG_DIR` |
| Scheduled-job logs | `~/.claude/logs/jobs/<jobname>.log` | `JOB_LOG_DIR` |
| Self-built MCP server logs | `~/.claude/logs/mcp/<name>.log` | `MCP_LOG_DIR` |

A server you built yourself logs wherever you make it log (the book's example
is `~/.claude/logs/mcp/personal-data.log`). For a connector, open `/mcp` in a
session instead: it shows the connector's status, account, and tools.

The single most important habit: when you let Claude author a hook or job,
**tell it to set the log path explicitly.** A freshly authored hook drops its
output into the void by default.

## Usage

```bash
chmod +x grep-recipes.sh

# "Did my SessionStart hook fire this morning?"
./grep-recipes.sh did-hook-fire sessionstart

# "Why did Reuben exit with code 1?"
./grep-recipes.sh why-exit reuben

# "Why did my custom MCP return an empty payload at 8:42?"
./grep-recipes.sh which-mcp 08:42 personal-data

# Follow a log in real time while you trigger the agent in another pane
./grep-recipes.sh watch ~/.claude/logs/hooks/sessionstart.log
```

## The weekly habit

Run job 25 from Appendix A (the cost-trend check) every Sunday against the
previous 30 days. Bills bend before they break — and the agents you worried
about least are usually the ones that cost most.
