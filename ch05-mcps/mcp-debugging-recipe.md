# MCP reference card — debugging recipe + trust rubric

Pull this out whenever an MCP misbehaves or before you install a new one. You don't
have to memorize the commands — describe the problem in English and Claude runs them.

## The debugging recipe (list → logs → re-auth, in that order)

When an MCP misbehaves (wrong account, missing data, weird timeouts), the first three
moves are always:

1. **`claude mcp list`** — is the thing even installed and authed, and to *which account*?
   This catches the most common failure: the MCP authenticated against the wrong
   Google account / Slack workspace / Notion workspace.
2. **`claude mcp logs <name>`** — tail what the server is really doing. If `list` looks
   fine but you're not getting the data you expect, the log shows the actual query and
   the actual mailbox/workspace it ran against.
3. **"Re-authenticate the {name} MCP"** — redo the OAuth or token flow from scratch.
   Reach for this when the logs show an auth error or a wrong-account symptom. On
   re-auth, pick the correct account *explicitly* ("Use another account" on Google).

Raw log files (scroll further back than `logs` shows, or share with someone):
- macOS: `~/Library/Logs/Claude/mcp-server-{name}.log`
- Linux: `~/.config/Claude/logs/`

### Cross-system prompt failing?

Don't debug the synthesis prompt. Prove each MCP works in isolation first:

> *"Run `claude mcp list`, then run one tiny prove-it prompt against each of gmail,
> calendar, and notion separately, and tell me which one returned no data."*

Fix the one that comes back empty with the recipe above, then re-run the synthesis.

## The four-question trust rubric (before installing any MCP)

1. **Is it in the official catalog?** Anthropic publishes a vetted catalog. Catalog
   entries have signed binaries, scoped OAuth, sane defaults handled for you.
   Off-catalog MCPs aren't forbidden — they're strangers; treat them as such.
2. **What does its OAuth scope ask for?** Read-only beats read-write. Read-and-draft
   (Gmail) beats send-without-confirmation. If the consent screen asks for more than
   the MCP's published capabilities, cancel and ask Claude to re-request narrower scopes.
3. **Where does the traffic go?** Local-only MCPs keep data on your machine (your laptop
   → the service's API, no third party). Cloud-relayed MCPs route through a vendor's
   servers. Both valid; the answer changes who's in your trust circle.
4. **Who maintains it?** Anthropic-published (safest baseline), vendor-published (the
   company that owns the system; usually safe), or community-published (usually fine,
   but read the repo first).

## The prompt grammar (so you can install / synthesize anything)

Install:
> *"Add the {tool} MCP for me. I'll {paste the token | authenticate in the browser} when you tell me."*

Synthesize across systems:
> *"Read my {source A}, my {source B}, my {source C}. Synthesize into {file path}. Cite each item by source."*

Remove:
> *"Remove the {tool} MCP, I switched to {other tool}."*

Quarterly audit (cleanliness is a security control):
> *"Audit my MCPs: for each one, tell me what permissions it has and whether I should narrow them. Write the audit to ~/work/notes/mcp-audit-{date}.md."*
