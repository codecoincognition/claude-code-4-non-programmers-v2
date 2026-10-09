# MCP reference card — debugging recipe + trust rubric

Pull this out whenever an MCP misbehaves or before you install a new one. You don't
have to memorize the commands — describe the problem in English and Claude runs them.

## The debugging recipe (check `/mcp`, then reconnect)

When a connector misbehaves (wrong account, missing data, weird timeouts), the move
is always the same:

1. **`/mcp`** (inside a session) — read the connector's status line: is it connected,
   and to the *right account*? It shows every connector, its status, the account it's
   using, its tools — plus a Reconnect / Authenticate action. This catches the most
   common failure: the connector signed in to the wrong Google account / Slack
   workspace / Notion workspace.
2. **"Reconnect the {name} connector"** — re-runs the sign-in (or re-applies the key)
   from scratch. Reach for this when the status shows disconnected, an auth error, or
   the wrong account. On reconnect, pick the correct account *explicitly* ("Use
   another account" on Google).

Nine times out of ten the fix is to reconnect or re-authenticate from `/mcp`.

From the shell, without opening a session: `claude mcp list` / `claude mcp get <name>`
show the same connection status for connectors you added by URL or built yourself.

### Cross-system prompt failing?

Don't debug the synthesis prompt. Prove each MCP works in isolation first:

> *"The cross-system synthesis came back wrong (or empty, or partial). Don't debug the
> synthesis prompt. Check /mcp to confirm gmail, calendar, and notion are each connected,
> then run one tiny prove-it prompt against each separately and tell me which one
> returned no data."*

Fix the one that comes back empty with the recipe above, then re-run the synthesis.

## The four-question trust rubric (before installing any MCP)

1. **Is it in the official catalog?** Anthropic publishes a vetted catalog. Catalog
   entries have signed binaries, scoped OAuth, sane defaults handled for you.
   Off-catalog MCPs aren't forbidden — they're strangers; treat them as such.
2. **What does its OAuth scope ask for?** Read-only beats read-write. Read-and-draft
   (Gmail) beats send-without-confirmation. If the consent screen asks for more than
   the MCP's published capabilities, cancel and ask Claude to re-request narrower scopes.
3. **Where does the traffic go?** Local MCPs run on your machine and keep data there
   (the custom one you'll build in Chapter 14 is local). Cloud connectors like Gmail and
   Notion route through the connector service to reach the app. Both valid; the answer
   changes who's in your trust circle.
4. **Who maintains it?** Anthropic-published (safest baseline), vendor-published (the
   company that owns the system; usually safe), or community-published (usually fine,
   but read the repo first).

## The prompt grammar (so you can install / synthesize anything)

Install:
> *"Connect my {tool}." — and, when it isn't a one-click directory connector, "… here's its URL" or "…I'll paste the API key."*

Synthesize across systems:
> *"Read my {source A}, my {source B}, my {source C}. Synthesize into {file path}. Cite each item by source."*

Remove:
> *"Disconnect Slack, I switched to Discord."*

Quarterly audit (cleanliness is a security control):
> *"Audit my MCPs: for each one, tell me what permissions it has and whether I should narrow them. Write the audit to ~/work/notes/mcp-audit-{date}.md."*
