# Chapter 7 — the prompts, in order

Every artifact in this folder was produced by prompting Claude in plain
English. You do not write the shell scripts or the JSON by hand. You describe
the situation; Claude writes the deterministic shell and edits the hook block.
These are the exact prompts the chapter uses, copy-paste ready.

## Step 1 — Open Claude in your work folder

```
cd ~/work && claude
```

## Step 2 — Describe the morning-brief job

> Set this up to run on its own every weekday at 6:30 AM and leave me a
> "morning brief" in ~/work/briefs/ — one for each day. Each brief should pull
> my unread Gmail from the last 12 hours, today's calendar events, and any
> Notion mentions or tasks assigned to me, then put a short synthesis at the
> top — "Three things that matter today, in priority order, one sentence
> each." Use my MCPs. And if it ever runs twice, don't give me two copies —
> just refresh that day's brief.

Then read it at a skim level and check three things:
- Does it call the MCPs you connected? (look for `gmail`, `calendar`, `notion`)
- Does it write to the path you specified? (look for `~/work/briefs/`)
- Is there anything that looks scary? (network calls outside your MCPs, file
  ops outside `~/work`, servers you don't recognize)

If a line worries you, ask before saving:

> This line on row 23, is it safe?

## Step 3 — Run it once, by hand

> Run the morning brief now and show me what it produced.

## Step 4 — Schedule it for 6:30 AM weekdays

> Schedule morning-brief.sh to run every weekday at 6:30 AM.

(Claude converts "every weekday at 6:30 AM" to the cron expression
`30 6 * * 1-5` and registers it. To see what it used:)

> Show me the cron expression you used.

## Step 5 — Make the brief greet you at every new session

> Every time I start a new Claude session in this folder, read today's brief
> from ~/work/briefs/{today}.md and show it to me first. If today's brief
> doesn't exist, say "no brief yet today" and don't crash.

Claude picks the right event under the hood (it's a `SessionStart` hook in
`settings.json`) — you described the moment in plain English, Claude wired the
event.

## Step 6 — Test it with a fresh session

```
/exit
claude
```

The brief should be the first thing on screen.

## When it goes wrong — the "paste the error" rule

When you open your laptop before the 6:30 job has run, the hook crashes. Paste
the entire error back with one sentence of context:

> show-brief.sh: line 4: ~/work/briefs/2026-05-06.md: No such file or directory
> — the brief script ran before the scheduled job had run today. Fix
> show-brief.sh to handle the case where today's brief doesn't exist yet — show
> me yesterday's brief with a note that today's hasn't been generated.

## The hook menu — what else can fire

You never type the event name. You describe the situation; Claude picks the
event. Example prompts for each one:

- **`SessionStart`** — *"Show me yesterday's brief at the top of every session."*
- **`UserPromptSubmit`** — *"Log every prompt I type to ~/work/prompts.log."*
- **`PreToolUse`** — *"Stop Claude before it deletes any file outside ~/work and ask me first."*
- **`PostToolUse`** — *"Ping me on Slack when Claude edits anything inside ~/work/important/."*
- **`Stop`** — *"Play a sound when Claude finishes a long task."*
- **`Notification`** — *"Send me a desktop notification when Claude is waiting on a yes/no."*
- **`SessionEnd`** — *"Save a one-paragraph summary of every session to ~/work/sessions/{date}.md."*

## Make it yours — the five variations

**1. Evening shutdown brief** (→ `work/scripts/eod-brief.sh`, cron `0 18 * * 1-5`)

> Every weekday at 6 PM, run a script that reads my last 8 hours of Slack DMs,
> my Gmail outbox, and my Notion edits, and writes a one-paragraph end-of-day
> note titled "What I touched today and what I owe people tomorrow." Save it to
> ~/work/briefs/eod-{date}.md. Add to my SessionStart hook so it shows on
> Saturday morning, when I'm planning the week ahead.

**2. Pre-meeting brief** (→ `work/scripts/pre-meeting-brief.sh`, cron `*/15 * * * 1-5`)

> Add a calendar-poll script that runs every 15 minutes during weekdays. If a
> meeting is starting in the next 20 minutes, generate a brief about it: who's
> attending, the meeting agenda from the calendar invite, the last three Slack
> threads with each attendee, and any Notion docs they've recently edited. Pop
> the brief up the moment whatever I'm working on wraps.

**3. PR review reminder** (→ `work/scripts/pr-review-reminder.sh`, cron `0 9 * * 1-5`)

> At 9 AM weekdays, check my GitHub for any open pull requests that have been
> waiting for my review for more than 24 hours. Write a one-paragraph nudge to
> ~/work/briefs/prs-pending-{date}.md, and post it as the first thing I see
> when I start a new Claude session. If there are zero, say nothing.

**4. Friday week-in-review** (→ `work/scripts/week-in-review.sh`, cron `0 17 * * 5`)

> Friday at 5 PM, run a script that reads all of this week's brief files in
> ~/work/briefs/, plus my Slack DMs from the week, and writes a 200-word
> reflection — what got done, what's still open, what surprised me, what I want
> to think about over the weekend. Save to ~/work/briefs/week-{YYYY-WW}.md.
> Show it to me when I start my first Claude session on Sunday evening, when
> I'm planning Monday. Keep the tone honest. If I missed something I said I'd
> do, name it. If a thing I worried about turned out to be nothing, name that
> too. Don't make me sound more productive than I was.

**5. Stock-watcher hook** (→ `work/scripts/stock-watcher.sh`, cron `30 16 * * 1-5`)

> Daily at 4:30 PM Eastern, fetch closing prices for tickers in
> ~/work/watchlist.txt, compare to last week's close, and write a one-line note
> about anything that moved more than 3%. Show it to me first thing when I
> open my next Claude session in the morning.

## Test yourself in 60 seconds

1. *"Quit and restart claude. Tell me what shows on screen first — confirm
   today's morning brief is the first thing I see."*
2. *"Show me what's scheduled and tell me which job produces the morning brief."*
3. *"Read ~/work/briefs/ and tell me when today's brief was generated. If it's
   stale, explain why in one sentence."*

Stuck? *"Audit my Chapter 7 setup against the chapter spec."*
