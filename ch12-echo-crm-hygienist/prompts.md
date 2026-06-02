# Prompts — Chapter 12, Echo the CRM hygienist

Every prompt from the chapter, verbatim and in order.

## Step 1 — Author the Echo agent

> I want to hire a fourth staff member named Echo. His job: read my outbound Gmail (Sent folder, last 7 days) and Calendar (meetings I ran, last 7 days), cross-reference against my Notion CRM database, and propose the missing or stale CRM entries. He NEVER writes to Notion. He only writes proposals to ~/work/echo/proposed-{date}.md. Author his agent file at ~/work/.claude/agents/echo.md. Tools: mcp__gmail__search (with from:me filter), mcp__gmail__read_thread, mcp__calendar__list_events, mcp__notion__query_database (read), mcp__notion__retrieve_page (read), Read, Edit on ~/work/echo/. Explicitly NOT in his allowlist: any Notion create, update, or delete tool against the CRM database.

## Step 2 — Lock the asymmetry at the settings level

> Add the Notion CRM write tools to the deny list in ~/work/.claude/settings.json, scoped to the CRM database ID — defense in depth, the same way we did for Gmail send in chapter 9. Iris and other agents that legitimately write to OTHER Notion databases (the Tasks DB, the Project Notes DB) should stay unaffected.

## Step 3 — Run Echo's first reconciliation pass

> Have Echo run his first reconciliation pass right now. Read my last 7 days of Sent + last 7 days of Calendar, check each against the Notion CRM, and produce the proposal queue. Don't write to Notion. Show me what he found.

## Step 4 — Walk through deduplication on a tricky case

> For two of the missing-entry proposals (Aria Velez, David Kim), Echo sees the same counterparty across multiple threads in the same week. Tell me how Echo handles that — does he propose one CRM entry or two?

## Step 5 — Schedule Echo and surface the queue in the morning brief

> Schedule Echo to run every weekday at 7 AM, right after Iris's morning pass. He writes his proposal queue directly to ~/work/echo/proposed-{date}.md (he already has Write access scoped to that folder). Then update show-brief.sh from chapter 7 — the morning brief should include a fifth section, "Echo's proposals," that reads from the same queue file.

## Step 6 — Approve, edit, discard

> Walk me through the proposal queue. For each proposal, I'll say approve, edit, or discard. When I approve, who writes to the Notion CRM — me, or Claude?

## Step 7 — What Echo remembers between runs

> Show me Echo's memory file at ~/work/.claude/memory/echo/. What does he remember between runs so he doesn't propose the same thing twice?

## Step 8 — Swap the CRM

> Show me what would change in echo.md if I used HubSpot instead of Notion as my CRM. Then show me Pipedrive. Then Salesforce. Walk me through the substitutions in each case.

## When it goes wrong — the day Sarah Chen became a prospect (recovery prompt)

> Echo proposed Sarah Chen as a prospect — she's actually my accountant. I approved by mistake. Three things: (1) update Echo's system prompt to require an inline "why this looks like a prospect" justification for every missing-entry proposal — at minimum, the thread content has to mention pricing, demos, contracts, or product features, not just be back-and-forth correspondence. (2) Add a non-prospects.md entry for Sarah so Echo never re-proposes her. (3) Walk me through removing her from the Notion CRM — Claude does the write; I confirm.

## Make it yours

**1. Calendar hygienist variant.**

> Author a second agent — `echo-calendar` — same shape, but he watches inbox and Slack for meetings I committed to but never put on my calendar. Proposes Calendar entries; never writes.

**2. Stage-drift specialization.**

> Tighten Echo's stale-stage rule. For each stage in my Notion CRM, define the criteria that should trigger a transition. Negotiation requires at least one quoted price; Closed Won requires a signed contract reference; Lost requires no outbound for 60+ days plus an explicit no.

**3. Quarterly hygiene report.**

> Once a quarter, Echo reads three months of proposal queues and writes a meta-report: how many proposals did I approve, how many discarded, what categories of proposal were wrong most often, what patterns should his system prompt learn?

**4. Confidence scoring.**

> Have Echo score each proposal on a 1-5 confidence scale. 'Clear-cut sales conversation with pricing and demos' = 5; 'might be sales might not be' = 3. Anything below 4 gets a 'low confidence — review carefully' tag.

**5. CRM swap.**

> Convert Echo from my Notion CRM to HubSpot — show me every line that changes in the agent file and the deny list.

**6. Raw-lead-never-promoted, the fourth mismatch.**

> Add a fourth mismatch category to Echo. The Notion Leads database (the one the launch landing page from Chapter 19 writes to) collects raw form submissions. Some of those leads get promoted into the CRM as prospects; some don't, and that's fine — wrong fit, missed-the-window, the form was a tire-kicker. But sometimes a real lead falls through the crack. Echo should propose any lead in the Leads DB that is more than 7 days old and has no matching CRM contact (match on email) and no 'Lost' or 'Dead' status set on the lead row itself. Add `mcp__notion__query_database` against the Leads DB ID to his allowlist (read only — no write tools added). The proposal lands in the daily queue under a new section: 'Raw lead, never promoted.'

## Test yourself in 60 seconds (chapter-end)

1. > Show me today's Echo proposals from ~/work/echo/. For each, tell me what evidence supports it.
2. > Explain in one sentence why Echo has no CRM write tools — and why my main Claude session does.
3. > Read ~/work/.claude/memory/echo/discarded.md and tell me which proposals I've rejected — confirm Echo won't re-propose them.

Stuck?

> audit my Chapter 12 setup against the chapter spec
