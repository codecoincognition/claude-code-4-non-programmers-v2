# Three-layer architecture

| Layer | Where it runs | Who invokes | When to use |
|---|---|---|---|
| Slash commands | Your terminal session | You type | One-off; reusable verb you run yourself |
| Subagents | Inside a Claude session | Claude or a slash command | Recurring jobs; dispatched within a session |
| Agent SDK | Anywhere — CI, VPS, server, cowork | Programmatic trigger | Scheduled; server-side; no human at terminal |

## Devon's eight, mapped

1. /triage (Ch 4)              — slash command. You type it.
2. /reconcile (Ch 4)           — slash command.
3. /review-mine (Ch 23)        — slash command.
4. Iris (Ch 9)                 — subagent (dispatched within session).
5. Reuben (Ch 11)              — subagent + SessionEnd hook.
6. Watchdog mesh (Ch 17)       — subagents on a schedule + kill-switch hook.
7. Meta-judge (Ch 24)          — subagent on a schedule.
8. Dashboard CI (Ch 24)        — Agent SDK in GitHub Actions.

## What changed today

Items 7 and 8 are new. Item 8 is the first thing on Devon's stack
that lives at the SDK layer. That's the "I have CI/CD now" moment.

## The discipline

Name the layer before you author. If you're authoring a slash
command for a job that should run unattended, you're at the wrong
layer. If you're authoring an SDK script for a job you'll run by
hand twice and then never again, you're also at the wrong layer.
