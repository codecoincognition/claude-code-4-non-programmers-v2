# Chapter 9 — every prompt, verbatim and in order

## Step 1 — Author Iris's agent file

> I want to hire a staff member named Iris. Her job: read my Gmail and Calendar every morning, route each thread to my Notion Tasks database (actionable) or my Notion Project Notes pages (FYI / commit), and draft replies for threads that need a response. She NEVER sends. She runs under the permission profile from Chapter 8. Write her agent file at ~/work/.claude/agents/iris.md. Tools: mcp__gmail__search, mcp__gmail__read_thread, mcp__gmail__create_draft, mcp__calendar__list_events, mcp__notion__create_page (for the Tasks DB), mcp__notion__append_block (for project notes). Explicitly NOT in her allowlist: mcp__gmail__send_message. Pull the Notion Tasks DB ID and Project Notes parent page ID from CLAUDE.md so the file stays portable.

> Show me ~/work/.claude/agents/iris.md.

## Step 2 — Lock the send tool a second time

> Add mcp__gmail__send_* to my deny list in ~/work/.claude/settings.local.json. Defense in depth — Iris's allowlist already excludes the send tool, but the deny list is the second lock that catches drift if anyone (including future-me) ever adds the send tool back into Iris's file. Wildcard send_* (not just send_message) so it covers any future Gmail send variants.

## Step 3 — Give Iris an output style for her queue voice

> Now give Iris an output style for her queue summary voice. Calm, dry, bullets over paragraphs, always names the reasoning behind each routing call ("archived because: …"), addresses me as Maya, signs nothing. Save to ~/work/.claude/output-styles/iris.md and reference it from her agent file.

## Step 4 — Run Iris once, in the foreground, on the last 12 hours

> Have Iris read the last 12 hours of my Gmail right now. Route each thread: Notion task row if it's an action I owe someone, Notion project note if it's project info to keep, draft reply if it needs a response, archive if it's noise. Show me the queue BEFORE she creates anything — I want to approve in bulk.

## Step 5 — Approve, write to Notion, save the drafts

> Looks right. Create the Notion task rows and the project notes. Save the drafts to Gmail Drafts. Don't send anything. Show me what you wrote.

## Step 6 — Set Iris up as a long-running session

> Set Iris up as a long-running session that resumes every morning at 6:25 AM. She picks up where she left off — remembers which threads she's already routed so she doesn't re-process them — runs against the last 12 hours of mail, and produces a fresh queue. Save the launcher to ~/work/scripts/iris-morning.sh and schedule it weekdays at 6:25 AM.

> Schedule iris-morning.sh to run every weekday at 6:25 AM.

## Step 7 — Extend the Stop hook to surface Iris's queue

> Extend the Stop hook from Chapter 7. When Iris finishes any morning pass, write a one-page queue summary to ~/work/queue/{date}.md listing every routing call (one line each: thread → destination → reason) and every draft (recipient + first 30 words + Iris's one-line reason). The morning brief should include an "Iris's queue" section pulling from this file.

## Step 8 — Review the queue: approve, edit, discard

> Show me the morning brief now with Iris's queue surfaced. Then walk me through approve / edit / discard for each draft — what's the prompt for each one?

> Show me draft 1 in full. If it looks right, I'll send it from Gmail myself. Otherwise tell me what to change.

> Rewrite draft 2 — too formal, drop the opener, keep it under 60 words. Save the new draft, discard the old one.

> Discard draft 3 — I'll handle Karen myself in person at lunch.

## When it goes wrong

> Iris created a Notion task with a number that came from the wrong source thread. Two things: (1) update Iris's system prompt to require source-thread links inline whenever a draft or task contains a specific number, date, or name. (2) Update the queue summary in the morning brief so any draft or task containing a numeric figure gets a "verify number against source" tag. Show me both diffs before saving.

## Make it yours

**1. Tighter scope on the first week.**
> For Iris's first week, only route threads from senders who emailed me in the last 30 days. Anyone else gets archived with the reason 'unknown sender'. Update her agent file.

**2. Slack drafts too.**
> Extend Iris to draft Slack DMs the same way — `mcp__slack__create_draft` (or equivalent); never `mcp__slack__send_message`. Drafts go into a 'Slack drafts' subsection of the queue.

**3. The voice score.**
> Have Iris score each draft on a 1-5 'sounds like Maya' scale based on how much it diverges from my last 20 sent emails. Anything below a 4 gets flagged for extra review.

**4. Audit the routing.**
> Read the last week of Iris's queue files vs. what I actually did with each item — which Notion tasks did I close as 'wrong call,' which drafts did I edit before sending, which I discarded. Update her system prompt to learn from those patterns.

**5. Asana instead of Notion.**
> Swap the Notion target for Asana. `mcp__notion__create_page` becomes `mcp__asana__create_task`; `mcp__notion__append_block` becomes `mcp__asana__add_to_project`. Routing taxonomy stays. Update CLAUDE.md to point at the Asana project IDs and re-issue Iris's file.

**6. Personalized follow-ups for the launch funnel.**
> Extend Iris to read new rows in the Notion Leads database (the one the launch landing page from Chapter 19 writes to). Each morning, for any lead row created in the last 24 hours that doesn't already have a follow-up draft, draft a personalized email in my voice using `your-tone.md` from Chapter 14, save it to Gmail Drafts with the subject 'Re: your registration', and add a 'Followup drafted' line to the Iris queue. Add `mcp__notion__query_database` to her allowlist, scoped to the Leads DB ID in CLAUDE.md. She still never sends.

## Test yourself in 60 seconds

> Open today's queue file in ~/work/queue/ and read me Iris's overnight routing — Notion task rows, project notes, Gmail drafts.

> Read ~/work/.claude/agents/iris.md and explain in one sentence what each section does.

> Tell me why mcp__gmail__send_message is on my deny list even though Iris's allowlist doesn't grant it. One sentence.

**Stuck?**
> audit my Chapter 9 setup against the chapter spec
