# READING-LIST — small MCP servers worth reading before you write one

The chapter's core move is **read one before you write one**. The right
reference is small enough that you "can see the bottom of every file in one
screen" — under ten minutes to walk through with Claude. The filesystem MCP
is the canonical one. Here are a few more in the same size class, for when
you author your second and third servers.

| Server | Why it's a good read | Roughly |
|---|---|---|
| `@modelcontextprotocol/server-filesystem` | The canonical small example. Six files, two load-bearing. Read this first. | tiny |
| `@modelcontextprotocol/server-sqlite` | Shows a query-backed handler — the "CSV → SQLite" variation in *Make it yours*. | small |
| GitHub-issues MCP (server-github, issues subset) | Shows tools that hit a remote API + auth token handling. Read the issues handlers only, skip the rest. | medium-small |
| `server-memory` | Shows resources (read-only browsable data) alongside tools. | small |
| `server-fetch` | One tool, one job (fetch a URL). Smallest possible "real" server. | tiny |

## How to use this list

Pick one. Ask Claude:

> "Open the source for `<server>`. Show me the directory structure first —
> just the file tree, nothing else."

Then walk the manifest and one handler, exactly like Chapter 13's read step.
Save the annotation to `~/work/notes/<server>-annotated.md`. Date it. Move on.

## Vetting reminder

Reading an MCP before installing it is also how you **vet** it. Never
`claude mcp add` a server from a stranger without reading its `package.json`
and its handlers first. The read-walk-through habit is the audit habit.
Appendix D's cookbook covers "how to audit an MCP before installing it."
