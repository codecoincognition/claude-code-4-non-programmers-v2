# Chapter 13 — Your first custom MCP server

This chapter has you cross the line from *installing* other people's MCPs to
*authoring* your own. In two halves: first you **read** a small existing MCP
(`@modelcontextprotocol/server-filesystem`) and have Claude annotate it line
by line; then you **write** `personal-data` — a tiny MCP that exposes three
tools (`list_records`, `find_record`, `summarize_records`) over a CSV of past
campaigns. You install it with `claude mcp add`, prove it works, hit and fix
the classic un-expanded-tilde path bug, and end with the connector showing up
as the sixth entry in `claude mcp list`. Chapter 15's newsroom installs it as
its research tool.

## Files in this folder

| Path | What it is |
|---|---|
| `work/mcp-servers/personal-data/package.json` | The manifest — name, version, `bin` field, dependencies |
| `work/mcp-servers/personal-data/src/index.ts` | The three tool handlers + `loadCsv` helper (FIXED, tilde-expanded `CSV_PATH`) |
| `work/mcp-servers/personal-data/tsconfig.json` | TypeScript build config |
| `work/mcp-servers/personal-data/README.md` | What the server does and its tools — Claude reads this to decide whether to route through it |
| `work/data/campaigns.csv` | 47-row sample campaigns CSV the MCP reads (38 shipped, 9 cut, 2023-02-14 → 2026-04-21) |
| `work/notes/filesystem-mcp-annotated.md` | The read-step learning trace — annotated manifest + one handler |
| `READING-LIST.md` | Small MCP servers worth reading before authoring your second/third |
| `prompts.md` | Every prompt from the chapter, verbatim and in order |

## How to use

1. Copy `work/mcp-servers/personal-data/` to `~/work/mcp-servers/personal-data/`
   and `work/data/campaigns.csv` to `~/work/data/campaigns.csv` (or point
   `CSV_PATH` in `src/index.ts` at your own CSV).
2. Build and register:
   ```bash
   cd ~/work/mcp-servers/personal-data
   npm install
   npm run build
   claude mcp add personal-data ~/work/mcp-servers/personal-data
   claude mcp list           # personal-data should appear
   ```
3. Try it: *"Use the personal-data MCP to summarize my campaigns CSV."*
   You should get back:
   `47 campaigns from 2023-02-14 to 2026-04-21. 38 shipped, 9 cut.`
4. To replay the read step on a different small server, see `READING-LIST.md`.

### Note on the path bug

The chapter walks you into the un-expanded-tilde bug on purpose: a literal
`"~/work/data/campaigns.csv"` passed to `fs.readFile` fails because Node does
not expand `~` the way the shell does. The `src/index.ts` shipped here is the
**fixed** version — `CSV_PATH` is built with `path.join(os.homedir(), ...)`.
If you want to reproduce the failure to see `claude mcp logs` in action,
temporarily replace `CSV_PATH` with the literal-tilde string.

## Bring your own data

`campaigns.csv` is synthetic sample data so you can run the MCP immediately.
Swap in your own export (any CSV with at least `name`, `launched_at`, and
`outcome` columns works with the three handlers as written).

---

The book is self-contained — these files are ready-to-clone copies of what
Chapter 13 walks you through building.
