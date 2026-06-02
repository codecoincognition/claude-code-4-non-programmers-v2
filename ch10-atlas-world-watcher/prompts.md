# Chapter 10 — prompts, verbatim and in order

Every prompt the chapter has you type, in the order it appears.

## Step 1 — Author the Atlas agent

> I want a second staff member named Atlas. His job: every weeknight, read a watchlist of competitor pricing pages, GitHub release feeds, and RSS feeds; save snapshots; diff against last week; write a signal file with anything that moved. Read-only on the public web; writes only to ~/work/atlas/. Slack DM to me on big moves. Author his agent file at ~/work/.claude/agents/atlas.md. Tools: WebFetch, browser MCP for sites that need it, mcp__github__list_releases, Read, Edit on ~/work/atlas/, mcp__slack__send_message for escalations only.

## Step 2 — Set up the watchlist

> Set up Atlas's watchlist. Create ~/work/atlas/sources.md with sections for each source type. Pre-fill with placeholders I can edit: 3 competitor pricing URLs, 3 GitHub repo names, 3 RSS feed URLs. Also create ~/work/atlas/snapshots/ as an empty folder.

## Step 3 — Run Atlas's first nightly pass

> Run Atlas now against my watchlist. Take snapshots, write them to ~/work/atlas/snapshots/{today}/, and produce the first signal file at ~/work/atlas/signals-{today}.md. Since this is the first run, there's nothing to diff against — Atlas should write a baseline signal file noting what he saw and that he'll start diffing on the next run.

## Step 4 — Schedule Atlas to run nightly

> Schedule Atlas to run every weeknight at 11 PM. Different schedule from Iris's morning cron — she runs at 7 AM weekdays, Atlas runs at 11 PM weekdays.

## Step 5 — Simulate a week passing — Atlas's first real diff

> Simulate one week passing. Run Atlas again, but with one snapshot manually edited to look like Acme cut their Pro tier from $99 to $87 — a 12% cut. Show me how Atlas diffs and what he writes to the signal file.

## Step 6 — Surface Atlas's signals in the morning brief

> Extend ~/work/scripts/show-brief.sh from chapter 7 / 9 to include a fourth section — "Atlas's signals." Pull the latest ~/work/atlas/signals-{date}.md. If empty or saying "no signals," collapse to a single line: "all quiet." Don't crash if the file is missing.

## Step 7 — See Atlas on a quiet day

> Show me what Atlas does on a quiet day. Run him with no changes in any source. What does the signal file look like? What goes into the morning brief?

## Step 8 — Walk through the escalation rules

> What does Atlas do when something is genuinely big — like a competitor's pricing page returning a 404? Walk me through the escalation rules in his system prompt.

## When it goes wrong — the recovery prompt

> Atlas reported a phantom pricing change on Acme last night because his fetch returned a captcha page instead of the real pricing. Update Atlas's system prompt so (a) before he trusts a fetched page, he checks: extract length must be at least 500 characters AND the page must contain a recognizable pricing keyword like "$" or "month" or "plan"; (b) if the fetch is suspicious — short, captcha-like, login-walled — Atlas writes a "fetch failed — possible bot block" signal instead of a confident-but-wrong one; (c) in those cases he does NOT overwrite the snapshot for that source, so the diff stays clean for the next real fetch; (d) escalate only after two consecutive successful, real fetches. Show me both the system prompt diff and how Atlas now handles a fake captcha snapshot.

## Make it yours — five follow-up prompts

**1. Brand-mention watcher.**

> Add a fourth source type to Atlas — brand mentions. Watch X, Reddit, and Hacker News for any mention of my company name. Diff weekly. Escalate any negative-sentiment mention.

**2. Funding-news watcher.**

> Watch Crunchbase for any new funding round in my industry over $5M. Daily check, weekly summary. Escalate any round above $20M.

**3. Hiring-pulse watcher.**

> Watch the Careers pages of my three nearest competitors. Signal when any new role is posted. Roles tell me where they're investing.

**4. Quarterly extraction-validation.**

> Once a quarter, Atlas runs a self-check: he fetches a page he knows has changed and verifies the diff still works. If extraction broke silently, he flags it and asks me to re-prompt the extraction logic.

**5. Friday signal-review session.**

> Every Friday at 4 PM, Atlas reads the last week of signal files and writes a 200-word summary — what moved, what it might mean, what to watch next. Surface that in Friday's morning brief.

## Test yourself in 60 seconds

1. Add a new source to ~/work/atlas/sources.md (use any competitor pricing page) and confirm Atlas will pick it up tonight without further prompting.
2. Read tonight's signal file in ~/work/atlas/. Tell me whether it's a quiet night or whether anything escalated, and link the snapshot.
3. Show me what's scheduled and confirm Atlas runs at 11 PM weekdays.

Stuck? Run "audit my Chapter 10 setup against the chapter spec" — Claude reads your files and tells you what's missing.
