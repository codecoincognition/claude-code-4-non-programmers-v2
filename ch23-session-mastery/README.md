# Chapter 23 — Session mastery and the latest surface

Chapter 23 teaches the **session command surface**: eleven commands and one
keyword, organized into four families — navigation (`/rewind`, `/fork`,
`/branch`, `--resume`, `Ctrl+G`), mid-task (`/btw`, `/compact`), situational awareness
(`/cost`, `/context`), and model & effort (`/model`, `/effort`, `ultrathink`,
plan mode). Unlike most chapters, the "artifacts" here are mostly built-in
commands the reader types, not files. The portfolio entry is a printable
cheatsheet plus the small personalized slash commands that accumulate session
reflexes — chiefly `/before-compact`, born from the chapter's lossy-compact
failure beat. This folder ships those clone-ready, scoped to `~/work` the way
the chapter scopes them.

## Files

```
ch23-session-mastery/
├── README.md                                  this file
├── prompts.md                                 every prompt + command, verbatim, in order
└── work/
    ├── .claude/
    │   ├── cheatsheet.md                       one-page session-command reference (print it)
    │   ├── settings.json                       default /effort + /model (Make-it-yours prompt 2)
    │   ├── commands/
    │   │   ├── before-compact.md               pin decisions to a dated decisions.md before /compact
    │   │   ├── triage-session.md               end-of-session hygiene: /cost + /context + ask to /compact
    │   │   └── safe-branch.md                  pair /cost with /branch before switching into a copy
    │   └── decisions/
    │       └── 2026-05-05.md                   sample pinned-decisions file /before-compact writes
    └── watchdog/
        └── fixtures/
            └── README.md                       input shape + why the synthetic log is seeded as it is
```

## How to use

1. Copy `work/.claude/cheatsheet.md` next to your laptop and glance at it for
   two weeks. The commands become reflex; then you stop needing it.
2. Drop the three files in `work/.claude/commands/` into your own
   `~/work/.claude/commands/` (or `~/.claude/commands/` to make them global).
   Then `/before-compact`, `/triage-session`, and `/safe-branch` are live.
   - **`/before-compact`** — run it before `/compact` on any long session. It
     writes a dated decisions file to `~/work/.claude/decisions/` capturing the
     *why* behind each fix, so the lossy compactor can't discard load-bearing
     reasoning. This is the chapter's central save.
   - **`/triage-session`** — end-of-session hygiene in one keystroke.
   - **`/safe-branch`** — see the parent thread's spend before you switch into a copy
     with `/branch`.
3. `work/.claude/settings.json` shows the Make-it-yours prompt-2 defaults
   (`effort: high`, latest Sonnet model). The chapter places this at your real
   `~/.claude/settings.json`; the model name is illustrative since that surface
   evolves quarterly — use the alias your install reports.
4. The "When it goes wrong" recovery prompt reads `~/work/dashboard/dashboard-deploy.log`
   (the Ch 22 deploy log, which holds the LinkedIn OAuth redirect-loop error
   trace). The `/btw` and `ultrathink` scenes use `~/work/watchdog/escalations.log`
   from Ch 18. Neither log ships in this folder (the repo ignores `*.log` files);
   `work/watchdog/fixtures/README.md` documents the escalations.log line shape.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 23 walks you through building.
