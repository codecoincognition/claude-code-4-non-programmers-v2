# Chapter 5 — every prompt, in order

Copy-paste these in sequence to reproduce the chapter. You type English; Claude
points you at the right directory connector (or, for Buffer, registers it by
URL), walks you through the sign-in, and confirms the result in `/mcp`. You
never edit a config file by hand.

> Start each session from your work folder: `cd ~/work && claude`

---

## Cold open — before any connectors

> draft me the campaign brief for next Thursday

(Without MCPs, Claude can only ask you to paste the content. That is the problem
this chapter fixes.)

## Step 1 — Confirm the registry is empty

> Show me my connected tools.

## Step 2 — Install Gmail (the slow, careful one)

> I want to connect my Gmail so you can read it and draft replies. Walk me through adding it.

If the OAuth consent screen asks for more than read-and-draft:

> The Gmail OAuth screen is asking for send-without-confirmation. I want read-and-draft only. Re-request with narrower scopes.

Confirm:

> Are my connected tools showing now? Check.

### Recovery — Gmail authed against the wrong inbox

Symptom check:

> Show me my last 5 unread emails.

Diagnose:

> Gmail isn't finding my unread mail, but I know there's a stack of it. Something's off — check the Gmail connection and tell me what you find.

Fix:

> Gmail is connected to the wrong Google account. Walk me through reconnecting it with my work account, maya@workdomain.com.

(Substitute your own work address.)

## Step 3 — Install Calendar

> Add the Google Calendar MCP the same way.

## Step 4 — Connect Notion (same directory, same sign-in)

> Connect my Notion next.

If the "…" → Connections menu has moved:

> My Notion's "…" menu doesn't have a Connections option in the place the docs say. Here's what it looks like — what should I click?

(Paste a screenshot. Debugging install-time UI is one of the two times in the book you paste a screenshot.)

## Step 5 — The cross-system synthesis (the magic moment)

> Read my unread Gmail from the last 12 hours, my Calendar for today, and my Notion mentions in the last 24 hours. Synthesize the three into a one-page priorities brief at ~/work/inbox/2026-Q4-priorities.md. Cite each item by source.

If it comes back wrong, empty, or partial — debug each MCP individually first:

> The cross-system synthesis came back wrong (or empty, or partial). Don't debug the synthesis prompt. Check /mcp to confirm gmail, calendar, and notion are each connected, then run one tiny prove-it prompt against each separately and tell me which one returned no data.

## Step 6 — Install Slack and Buffer (parked until later)

> Add Slack and Buffer too. We won't use them today, but Chapter 9 needs Slack and Chapter 17 needs Buffer. Walk me through both.

## Step 7 — List everything with one-line glosses

> Show me all my connected tools and tell me in one line what each is for.

---

## A week later — Notion page not shared with the integration

Symptom:

> Read me the "Q3 launch — working doc" Notion page Linda updated last night.

Fix:

> The page exists in Notion but isn't shared with the Claude Code integration. Walk me through sharing it from Notion's UI, then re-run the read prompt.

---

## The prompt grammar (so you can install / synthesize anything)

Install:
> "Connect my {tool}." — and, when it isn't a one-click directory connector, "… here's its URL" or "…I'll paste the API key."

Synthesize across systems:
> Read my {source A}, my {source B}, my {source C}. Synthesize into {file path}. Cite each item by source.

Remove:
> Disconnect Slack, I switched to Discord.

Quarterly trust-drift check:
> List my MCPs and remind me which ones I haven't used in 60 days, so I can remove the ones I no longer need.

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

1. > Check /mcp and tell me which of the five connectors (gmail, calendar, notion, slack, buffer) are connected and authenticated.
2. > What's on my calendar tomorrow and which unread Gmail thread mentions it? One synthesized answer.
3. > Open ~/work/inbox/2026-Q4-priorities.md and tell me the one-page synthesis from this chapter.

Stuck? > audit my Chapter 5 setup against the chapter spec
