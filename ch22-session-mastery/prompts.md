# Chapter 22 — every prompt, verbatim and in order

Chapter 22 is a *commands* chapter: most of what the reader types are the
built-in session commands themselves. They're listed first, in the order the
chapter introduces them, then the full English prompts.

## Session commands, in chapter order

### Maya's scene — /rewind
- `Esc Esc` (or `/rewind`) — open the rewind selector, pick the wrong-idea
  prompt ("change the cache key format..."), Enter to rewind.

### Devon Scenario 1 — Navigation
- `claude --resume`
- `/context`
- `/fork` (mentioned; used in Scenario 4)
- `Ctrl+G` (open external editor for a long prompt)

### Devon Scenario 2 — Mid-task
- `/cost`
- `/compact`
- `/btw also append every intercept to ~/work/watchdog/escalations.log — don't create a new log file`

### Devon Scenario 3 — Situational awareness
- `/cost`
- `/context`

### Devon Scenario 4 — Model and effort
- `/model opus`
- `/effort high`
- `ultrathink — read orchestrator.md, kill-switch.sh, and the last 200 lines of escalations.log. There's a double-ping bug. Either the orchestrator is double-dispatching deploys-monitor on rapid escalations, or the kill-switch matcher is failing to deduplicate. Pin which one. Show me the evidence and the proposed fix.`
- `/effort medium`
- `/model sonnet`
- `/plan` (or Shift+Tab) — enter plan mode for the risky production step

### Marketplaces
- `/skills marketplace`
- `/mcp marketplace`

---

## When it goes wrong — the recovery prompt

> You proposed extending the OAuth fix but you've lost the redirect-loop reasoning we worked out before the compact. Two fixes: (1) read ~/work/dashboard/dashboard-deploy.log for the actual error trace from yesterday's run — the loop is documented there; (2) when I run /compact next time, preserve any explicit "we figured out that..." lines from earlier prompts. Author a small slash command at ~/work/.claude/commands/before-compact.md that, when I run it, asks you to write a decisions.md summary I can pin before I /compact.

---

## Make it yours — the cheatsheet prompt

> Write me a one-page cheatsheet at ~/work/.claude/cheatsheet.md covering every command in Ch 22. Format: name, one-line description, one example, when it earns its place. I'm going to print it.

## Make it yours — five (six) follow-up prompts

1. > Author a personalized `/triage-session` slash command at `~/work/.claude/commands/triage-session.md` that runs `/cost`, `/context`, and asks me whether to `/compact`. One keystroke for end-of-session hygiene.

2. > Set my default `/effort` to `high` and my default `/model` to the latest Sonnet via `~/.claude/settings.json` so I don't have to set them at the start of every session.

3. > Author a `/safe-fork` slash command that pairs `/fork` with `/cost` so I see the parent thread's spend before I commit to a new fork.

4. > Look at my last 5 sessions in `--resume` history and propose 3 places where I should have used `/rewind` or `/fork` but didn't. Tell me what the cost was of not using them — extra prompts, lost work, restarts.

5. > Audit my `~/work/.claude/cheatsheet.md` quarterly — for each command, mark whether I've used it in the past 30 days. Flag any I haven't, so I either start using them or remove them from the sheet.

6. > Tuesday night before the Wednesday launch — the auto-rebuild Stop hook on my landing page (Ch 19) just redeployed a hero-headline change I'm second-guessing. Use `/rewind` to roll the conversation back to the state right before I asked Claude to rewrite the headline, then re-prompt the variant I actually want. The hook will redeploy the corrected version. No git revert needed — Claude's session is the source of truth here, not the deploy log.

---

## Chapter-end test prompts

1. > Run `/rewind` and pick a checkpoint from three prompts ago.
2. > Run `/cost` and `/context` back to back. Tell me what each one reports.
3. > Run `/before-compact` to pin this session's decisions, then run `/compact` and confirm the pinned decisions reload.

Stuck prompt:
> audit my Chapter 22 setup against the chapter spec
