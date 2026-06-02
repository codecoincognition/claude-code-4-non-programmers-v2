# Chapter 5 — every prompt, in order

Copy-paste these in sequence to reproduce the chapter. You type English; Claude
generates the `claude mcp ...` commands, hands you the OAuth URL or token prompt,
and confirms the result. You never edit a config file by hand.

> Start each session from your work folder: `cd ~/work && claude`

---

## Step 1 — Confirm the registry is empty

> List the MCPs I have installed.

## Step 2 — Install Gmail (the slow, careful one)

> Add the Gmail MCP for me. I'll authenticate in the browser when you tell me to.

If the OAuth consent screen asks for more than read-and-draft:

> The Gmail OAuth screen is asking for send-without-confirmation. I want read-and-draft only. Re-request with narrower scopes.

Confirm:

> Show me the MCP list now.

### Recovery — Gmail authed against the wrong inbox

Symptom check:

> Show me my last 5 unread emails.

Diagnose:

> The Gmail MCP isn't finding my unread mail, but I know there's a stack of it. Run the diagnostics: list the MCP, tail its logs, and tell me what you see.

Fix:

> Re-authenticate the Gmail MCP against my work account: maya@workdomain.com.

(Substitute your own work address.)

## Step 3 — Install Calendar

> Add the Google Calendar MCP the same way.

## Step 4 — Install Notion (token, not OAuth)

> Add the Notion MCP — I'll paste the integration token when you ask.

If the "..." → Connections menu has moved:

> My Notion's "..." menu doesn't have a Connections option in the place the docs say. Here's what it looks like — what should I click?

(Paste a screenshot. Debugging install-time UI is one of the two times in the book you paste a screenshot.)

## Step 5 — The cross-system synthesis (the magic moment)

> Read my unread Gmail from the last 12 hours, my Calendar for today, and my Notion mentions in the last 24 hours. Synthesize the three into a one-page priorities brief at ~/work/inbox/2026-Q4-priorities.md. Cite each item by source.

If it comes back wrong, empty, or partial — debug each MCP individually first:

> The cross-system synthesis came back wrong (or empty, or partial). Don't debug the synthesis prompt. Run claude mcp list, then run one tiny prove-it prompt against each of gmail, calendar, and notion separately, and tell me which one returned no data.

## Step 6 — Install Slack and Buffer (parked until later)

> Add the Slack MCP and the Buffer MCP. We won't use them today, but Chapter 9 needs Slack and Chapter 16 needs Buffer. Install both, OAuth me through them, and confirm both show up in the list.

## Step 7 — List everything with one-line glosses

> List all MCPs I have installed and tell me in one line what each is for.

---

## A week later — Notion page not shared with the integration

Symptom:

> Read me the "Q3 launch — working doc" Notion page Linda updated last night.

Fix:

> The page exists in Notion but isn't shared with the Claude Code integration. Walk me through sharing it from Notion's UI, then re-run the read prompt.

---

## Make it yours — five follow-ups

1. Add a sixth MCP and prove it works:
   > Add the GitHub MCP and prove it works by listing my last 5 pull requests, with title and review status.

2. Inventory one MCP's tools:
   > Show me everything the Calendar MCP can do — list its tools and one example prompt for each.

3. Diagnose a slow MCP:
   > My Notion MCP is timing out on large pages. Tail the logs, find the issue, and fix the config.

4. The quarterly audit:
   > Audit my MCPs: for each one, tell me what permissions it has and whether I should narrow them. Write the audit to ~/work/notes/mcp-audit-{date}.md.

5. Disconnect for the weekend:
   > Disconnect the Slack MCP for the weekend, and reconnect it Monday morning.

---

## Test yourself in 60 seconds

1. > Run claude mcp list and tell me which of the five MCPs (gmail, calendar, notion, slack, buffer) are connected and authenticated.
2. > What's on my calendar tomorrow and which unread Gmail thread mentions it? One synthesized answer.
3. > Open ~/work/inbox/2026-Q4-priorities.md and tell me the one-page synthesis from this chapter.

Stuck? > audit my Chapter 5 setup against the chapter spec

---

## Dry-run without real accounts (uses fixtures/)

> Treat the three files in fixtures/ as if they were my Gmail unread, my Calendar today, and my Notion mentions. Synthesize them into a one-page priorities brief, cite each item by its source file, and show me the result.

Compare what Claude produces to `work/inbox/2026-Q4-priorities.md`.

---

## The prompt grammar (so you can install / synthesize anything)

Install:
> Add the {tool} MCP for me. I'll {paste the token | authenticate in the browser} when you tell me.

Synthesize across systems:
> Read my {source A}, my {source B}, my {source C}. Synthesize into {file path}. Cite each item by source.

Remove:
> Remove the {tool} MCP, I switched to {other tool}.
