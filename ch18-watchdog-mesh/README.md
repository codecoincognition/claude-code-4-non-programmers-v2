# Chapter 18 — The watchdog mesh

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
ch18-watchdog-mesh/
├── README.md                         this file
├── prompts.md                        every chapter prompt, verbatim, in order
├── worktree-setup.md                 git-worktree create/verify/remove + boundary gotcha
├── schedule.md                       Step 5 — cron expression + cost note
├── work/
│   ├── .claude/settings.json         SessionStart + PreToolUse kill-switch hook block
│   ├── .claude/agents/watchdog/      fuller versions of the same four agent files
│   ├── scripts/
│   │   ├── kill-switch.sh             macOS — per-interception 4-digit code typed into a dialog, 50s timeout
│   │   ├── kill-switch-linux.sh       Linux variant (zenity dialog)
│   │   └── kill-switch-windows.ps1    Windows variant (PowerShell dialog)
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
    └── vercel-sample.txt              synthetic `vercel ls` output
```

## How to use

1. Create the worktree (see `worktree-setup.md`), then copy
   `work/worktrees/watchdog-mesh/.claude/agents/watchdog/` into it.
2. Copy `work/.claude/settings.json` and `work/scripts/kill-switch.sh`
   into your real `~/work/`. `chmod +x ~/work/scripts/kill-switch.sh`.
   On Linux or Windows, swap in the matching `kill-switch-*` script and
   point the hook command at it.
3. Create `~/work/watchdog/escalations.log` (an empty file is fine).
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
Chapter 18 walks you through building.

## How the kill-switch here differs from the printed listing

The printed `kill-switch.sh` asks for the code with `read` at a terminal
prompt. A hook has no terminal, and its input is the JSON payload the script
has already read, so that `read` returns at once and every escalation is
denied without anyone being asked. The scripts here ask in a dialog instead
(osascript on macOS, zenity on Linux, a small Windows Forms dialog on
Windows). Three other changes make the gate hold:

- The alert text reaches the macOS dialog as an argument, never pasted into
  the AppleScript, so quotes in an alert cannot run commands.
- Only exit code 2 blocks a tool call; a crash, another exit code, or a hook
  that runs past its timeout lets the call through. So the escalation check
  reads the raw payload (no `jq` needed to spot it), and after that every
  failure exits 2. The dialog gives up after 50 seconds, which counts as a
  denial.
- The Windows script matched the tag with `-like`, which treats
  `[WATCHDOG:ESCALATE]` as a set of single characters; it now checks for the
  literal text.

The macOS and Linux scripts were tested against every path (approve, wrong
code, no answer, no `jq`, no zenity). The Windows script was written to the
same rules but has not been run on Windows.
