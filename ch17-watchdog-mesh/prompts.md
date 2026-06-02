# Chapter 17 — prompts, verbatim and in order

Every prompt the chapter has you type, in sequence.

## Step 1 — Recap the prerequisites

> Before we build, recap for me: which hooks from Ch 7 and Ch 8, which subagent vocabulary from Ch 6, and which MCPs from Ch 5 are we about to depend on? One paragraph each.

## Step 2 — Set up a worktree for the mesh

> Set up a git worktree at ~/work/worktrees/watchdog-mesh/ from the current branch. The watchdog mesh will run inside it so its activity doesn't pollute my main ~/work/ session.

## Step 3 — Author the orchestrator and three monitors

> Inside the worktree, author the watchdog mesh under .claude/agents/watchdog/: one orchestrator and three monitors — inbox-monitor, calendar-monitor, deploys-monitor. The deploys-monitor watches three signal sources: the Vercel or Netlify deploy log for my website (Ch 19), the nightly build log for my dashboard (Ch 21), and the Buffer queue for my launch posts (Ch 16). Each monitor returns one of four tiers — all_clear, log_only, notify, or escalate. The orchestrator dispatches all three in parallel every 15 minutes (we'll schedule that in step 5), composes responses, and if any monitor returns escalate, pings me on Slack. Show me the orchestrator file in full and the three monitor files summarized.

## Step 4 — Install the kill-switch hook

> Add a PreToolUse hook to ~/work/.claude/settings.json that intercepts any tool call from the watchdog orchestrator at tier escalate (or any irreversible side-effect call from any monitor) and requires my explicit confirmation before proceeding. Hook should log every interception to ~/work/watchdog/escalations.log regardless of decision.

## Step 5 — Schedule the orchestrator

> Schedule the orchestrator to run every 15 minutes during weekdays from 7 AM to 11 PM Eastern. Outside those hours, it should be silent.

## Step 6 — Force one canonical escalation cycle

> Force an escalation right now — synthesize a fake "Vercel deploy failed" signal so the deploys-monitor returns escalate. I want to see the whole flow: monitor returns escalate, orchestrator composes, kill-switch intercepts, I approve, Slack ping fires.

## Step 7 — Diagnostic — review the four-tier rubric per monitor

> Show me, for each monitor, the four-tier rubric. For deploys-monitor, break it out per signal source — Vercel, dashboard, Buffer. This is the part I should review every quarter.

## Step 8 — Read the night forward

> It's bedtime. Tell me what I should expect when I wake up tomorrow morning if a quiet night happens — and what I should expect if something breaks at 2 AM.

## When it goes wrong — postmortem

> Eleven false-positive escalations overnight from deploys-monitor — queued Vercel builds and queued Buffer posts were both treated as failed. Two fixes I want, in order: (1) read deploys-monitor.md and tighten the rubric per source: a Vercel build is failed only if it transitioned to error or sat in building past 10 minutes; a Buffer post is failed only if its scheduled time has passed and Buffer reports a non-200 response; a dashboard build is failed only if the cron job exited non-zero. Any queued state before the relevant deadline is all_clear. (2) Update the kill-switch hook so HIGH-tier confirmations require something stronger than auto-passthrough — at minimum a tap-to-confirm on my phone, ideally a typed code. Show me both diffs.

## Make it yours — five variations

**1. Add a bookkeeper monitor.**

> Add a fourth monitor: bookkeeper-monitor. Watches Reuben's monthly P&L cycle (from Ch 11). Escalates if the cycle hasn't fired by the 3rd of the month.

**2. Quiet hours override.**

> Build a 'quiet hours' override — between 11 PM and 6 AM, the orchestrator only escalates at tier escalate; all notify events get downgraded to log_only so I sleep through them.

**3. Tighten the inbox rubric.**

> My escalation log is full of log_only lines from inbox-monitor that I never read. Tighten the inbox-monitor rubric so log_only only fires for things worth a weekly skim.

**4. Add a daily self-test.**

> Add a 'self-test' to the orchestrator — once a day, force a fake escalate from each monitor in turn so I know the kill-switch chain is still working. Don't actually send the Slack ping; just simulate it and log.

**5. Convert to a daily quota.**

> Convert the kill-switch from a per-action confirmation to a daily quota — max 3 escalations per 24 hours; anything past that gets queued for morning review unless flagged as critical.

## Test yourself in 60 seconds

1. > Read this week of ~/work/watchdog/escalations.log. Group by monitor. Tell me how many were escalate, notify, log_only.
2. > Force a test escalation through deploys-monitor. Confirm the kill-switch hook fires before any irreversible action.
3. > Show me the worktree at ~/work/worktrees/watchdog-mesh/ and explain in one sentence why the mesh runs in its own worktree.

## Stuck?

> audit my Chapter 17 setup against the chapter spec
