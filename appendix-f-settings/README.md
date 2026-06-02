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
shape, hook coverage (SessionStart, PreToolUse audit, Stop, SessionEnd), env
guardrails, mcpServers pinning, search-path separation. For each pattern from
Appendix F that I'm missing, propose the addition and one sentence on why it's
worth having. Don't apply anything yet — show me the diff first.
```

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
- **The API key reference** — `keychain:claude-code` reads from macOS Keychain. On Linux
  use Secret Service (`secret-tool`); on Windows use Credential Manager. Never inline a
  literal key.

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
