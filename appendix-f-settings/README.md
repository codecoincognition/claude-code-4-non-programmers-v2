# Appendix F — Reference `settings.json`

This folder holds the canonical, working `~/.claude/settings.json` from Appendix F of
*Claude Code for Non-Programmers* — the file built up across the book's chapters, every
key earned through a real regret or insight.

## Files

- **`settings.json`** — the full file, comment-free and valid strict JSON. This is the
  version with the book's inline `//` annotations removed so it parses and loads cleanly.
  (Strict JSON does not allow comments. The book shows the same file with `//` notes for
  reading only.)

## How to use it

**Do not copy this file wholesale.** It references one specific operator's paths
(`~/work/...`), client-scoped database IDs (`db_crm_8f3a`), and a set of MCP servers and
hook scripts that belong to that setup. Dropping it on top of your own `settings.json`
will break things.

The value of this file is as a *diff target*. Read the annotations in Appendix F to
understand why each key is there, then compare your own file against the patterns —
not the literal values.

### The closing prompt (from the appendix)

Paste this into a fresh `claude` session:

```
Read ~/.claude/settings.json. Compare it against the patterns described in
Appendix F of "Claude Code for Non-Programmers" — permissions deny/ask/allow
shape, hook coverage (SessionStart, PreToolUse audit, Stop, SessionEnd),
apiKeyHelper + env guardrails, mcpServers pinning, statusLine as a command
object. For each pattern from Appendix F that I'm missing, propose the
addition and one sentence on why it's worth having. Don't apply anything yet
— show me the diff first.
```

The two most interesting recent changes in this reference file are worth
calling out on the diff:

- **`statusLine` is an object, not a string template.** The documented shape is
  `{ "type": "command", "command": "~/.claude/statusline.sh" }` — Claude Code
  runs the script and prints whatever stdout it produces. Templating happens
  inside your script (model + agent + tokens counter, your choice), not in
  `settings.json`. An earlier draft of this file carried a string template;
  that wasn't a real key shape and has been corrected.
- **`apiKeyHelper` is the documented secret-store mechanism.** Top-level key,
  points at a script that prints the key on stdout. The actual key lives in
  macOS Keychain (Linux: Secret Service; Windows: Credential Manager). The
  script is a one-liner. The secret never sits in plain text in a config file.
  An earlier draft used an invented `env.ANTHROPIC_API_KEY_REF`; the real key
  is `apiKeyHelper` and lives at the top level.

You read the diff, decide what to take, and green-light. Most readers find two or three
patterns worth adopting. Some find none — that is a real answer too.

## What to change before adapting any of it

- **Paths** — `~/work/**`, the script paths under `~/work/scripts/`, and the
  `~/work/mcp-servers/personal-data/server.js` path are this operator's. Swap in yours.
- **The CRM lock** — `db_crm_8f3a` is a placeholder database ID. Replace with your own
  Notion (or other) database ID, or drop those three deny rules entirely.
- **MCP server package names** — names evolve. Check the current canonical names with
  `/mcp marketplace`. The `@pinned` tag stands in for the exact npm version you actually
  installed and reviewed (replace it with a real version number).
- **The `apiKeyHelper` script** — `~/work/scripts/keychain-claude-code.sh` reads from
  macOS Keychain (a one-liner: `security find-generic-password -s claude-code -w`).
  On Linux use Secret Service (`secret-tool`); on Windows use Credential Manager. The
  script prints the key on stdout; Claude Code reads it from there. Never inline a
  literal key in `settings.json`.
- **Subagent and skill discovery paths are not configurable.** Subagents auto-discover
  from `~/.claude/agents/` and `.claude/agents/` (project-local, recursive); skills the
  same. There is no `agents.searchPaths` or `skills.searchPaths` key — an earlier draft
  of this file carried both, and they were silently ignored. If you want a private subset,
  gitignore individual files inside the canonical folders, or symlink in from a private
  path.
- **Theme is set via the `/theme` slash command, not in `settings.json`.** No top-level
  `theme` key exists. An earlier draft carried one; it has been removed.

## What this file deliberately does NOT set

- No "auto-approve everything." Ever.
- No global override to the most expensive model — defaults stay at `sonnet`, with
  per-agent overrides where the upgrade matters.
- No telemetry disable.

See the appendix for the reasoning behind each omission.

## Canonical schema

Anthropic publishes the authoritative schema for every `settings.json` key. That is the
reference for *what each key does*. This file is the reference for *keys that have a
story behind them*. The two are complementary.
