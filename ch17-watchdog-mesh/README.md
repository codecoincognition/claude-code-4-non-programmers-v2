# Chapter 17 — The watchdog mesh

This chapter builds a **reactive orchestrator** that runs on a schedule
while you sleep. One orchestrator dispatches three monitors in parallel
every 15 minutes; each monitor classifies what it sees into one of four
tiers (`all_clear`, `log_only`, `notify`, `escalate`); the orchestrator
acts on the highest tier returned. A `PreToolUse` **kill-switch** hook
intercepts any escalate-tier action and requires a typed-code
confirmation before anything irreversible happens. The whole mesh lives
in its own **git worktree** so its background activity doesn't fight your
interactive `~/work/` session. Default state: silent. Default outcome: a
log line nobody reads.

## File-by-file

```
ch17-watchdog-mesh/
├── README.md                         this file
├── prompts.md                        every chapter prompt, verbatim, in order
├── worktree-setup.md                 git-worktree create/verify/remove + boundary gotcha
├── schedule.md                       Step 5 — cron expression + cost note
├── work/
│   ├── .claude/settings.json         SessionStart + PreToolUse kill-switch hook block
│   ├── scripts/
│   │   ├── kill-switch.sh             macOS — per-interception 4-digit code, 60s timeout
│   │   ├── kill-switch-linux.sh       Linux variant (notify-send)
│   │   └── kill-switch-windows.ps1    Windows variant (PowerShell toast)
│   ├── watchdog/
│   │   └── escalations.log            append-only review trail (canonical Step 6 entries)
│   ├── launches/
│   │   └── last-fire.log              launch-fired timestamp (funnel-anomaly source input)
│   └── worktrees/watchdog-mesh/
│       └── .claude/agents/watchdog/
│           ├── orchestrator.md        ~37 lines — parallel dispatch, tier aggregation
│           ├── inbox-monitor.md       Gmail rhythm anomalies (Ch 9)
│           ├── calendar-monitor.md    missed-meeting risk
│           └── deploys-monitor.md     3 signal sources + optional funnel source
├── variants/
│   ├── bookkeeper-monitor.md          Make-it-yours #1 — fourth monitor
│   └── quiet-hours-override.md        Make-it-yours #2 — 24/7 watch, no night pings
└── fixtures/
    ├── README.md                      input shapes for each monitor's data source
    ├── vercel-sample.txt              synthetic `vercel ls` output
    └── dashboard-cron-sample.log      synthetic nightly cron build log
```

## How to use

1. Create the worktree (see `worktree-setup.md`), then copy
   `work/worktrees/watchdog-mesh/.claude/agents/watchdog/` into it.
2. Copy `work/.claude/settings.json` and `work/scripts/kill-switch.sh`
   into your real `~/work/`. `chmod +x ~/work/scripts/kill-switch.sh`.
   On Linux or Windows, swap in the matching `kill-switch-*` script and
   point the hook command at it.
3. Create `~/work/watchdog/escalations.log` (an empty file is fine; the
   one here shows the canonical entry shape).
4. Schedule the orchestrator with the prompt in `schedule.md`
   (`*/15 7-23 * * 1-5`).
5. Force one canonical escalation (Step 6 prompt in `prompts.md`) and
   watch the kill-switch intercept before you trust the mesh.
6. Re-read the per-monitor tier rubric in `deploys-monitor.md` quarterly —
   that calibration table is the chapter's most reviewable artifact.

Inboxes, calendars, Buffer queues, and Notion DBs are your own connected
apps — `fixtures/README.md` documents the input shape each monitor reads;
no private data is fabricated here.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 17 walks you through building.
