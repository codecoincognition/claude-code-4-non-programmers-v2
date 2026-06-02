# personal-data

A tiny custom MCP server that exposes three years of past campaign briefs
(stored as a CSV) to Claude as three callable tools. Built in Chapter 13 as
the first MCP you author yourself — the sixth connector alongside the five
installed in Chapter 5. Chapter 15's newsroom installs it as its research
tool so the researcher agent can pull any past campaign by name without you
pasting anything into the conversation.

## Tools

| Tool | Input | Returns |
|---|---|---|
| `list_records` | none | All rows from the campaigns CSV (JSON) |
| `find_record` | `name` (string, case-insensitive) | The one matching campaign row, or "No campaign found." |
| `summarize_records` | none | Count, date range, and a one-line shipped/cut stat |

## Data

Reads `~/work/data/campaigns.csv`. The path is resolved with
`os.homedir()` inside the handler (see `src/index.ts`) — a literal `~` is
NOT passed to `fs.readFile`, because Node does not expand the tilde the way
your shell does. A 47-row sample CSV ships in this repo at
`work/data/campaigns.csv`.

## Install

```bash
# from inside this folder, build then register with Claude Code
npm install
npm run build
claude mcp add personal-data ~/work/mcp-servers/personal-data
claude mcp list          # confirm personal-data shows up
```

No authentication required — it's a local server reading local data.

## Usage example

> "Use the personal-data MCP to summarize my campaigns CSV."

Claude routes through `summarize_records` and returns, e.g.:
`47 campaigns from 2023-02-14 to 2026-04-21. 38 shipped, 9 cut.`

## Built by

Maya / you — Chapter 13 of *Claude Code for Non-Programmers (2nd Edition)*.
