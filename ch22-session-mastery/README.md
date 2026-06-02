# Chapter 22 — Session mastery and the latest surface

Chapter 22 teaches the **session command surface**: eleven commands and one
keyword, organized into four families — navigation (`/rewind`, `/fork`,
`--resume`, `Ctrl+G`), mid-task (`/btw`, `/compact`), situational awareness
(`/cost`, `/context`), and model & effort (`/model`, `/effort`, `ultrathink`,
plan mode). Unlike most chapters, the "artifacts" here are mostly built-in
commands the reader types, not files. The portfolio entry is a printable
cheatsheet plus the small personalized slash commands that accumulate session
reflexes — chiefly `/before-compact`, born from the chapter's lossy-compact
failure beat. This folder ships those clone-ready, scoped to `~/work` the way
the chapter scopes them.

## Files

```
ch22-session-mastery/
├── README.md                                  this file
├── prompts.md                                 every prompt + command, verbatim, in order
└── work/
    ├── .claude/
    │   ├── cheatsheet.md                       one-page session-command reference (print it)
    │   ├── settings.json                       default /effort + /model (Make-it-yours prompt 2)
    │   ├── commands/
    │   │   ├── before-compact.md               pin decisions to a dated decisions.md before /compact
    │   │   ├── triage-session.md               end-of-session hygiene: /cost + /context + ask to /compact
    │   │   └── safe-fork.md                     pair /cost with /fork before branching
    │   └── decisions/
    │       └── 2026-05-05.md                   sample pinned-decisions file /before-compact writes
    ├── dashboard/
    │   └── dashboard-deploy.log                synthetic deploy log — the LinkedIn OAuth redirect-loop trace the recovery prompt reads
    └── watchdog/
        ├── escalations.log                     synthetic append-only log (used by /btw and ultrathink scenes)
        └── fixtures/
            └── README.md                       input shape + why the synthetic log is seeded as it is
```

## How to use

1. Copy `work/.claude/cheatsheet.md` next to your laptop and glance at it for
   two weeks. The commands become reflex; then you stop needing it.
2. Drop the three files in `work/.claude/commands/` into your own
   `~/work/.claude/commands/` (or `~/.claude/commands/` to make them global).
   Then `/before-compact`, `/triage-session`, and `/safe-fork` are live.
   - **`/before-compact`** — run it before `/compact` on any long session. It
     writes a dated decisions file to `~/work/.claude/decisions/` capturing the
     *why* behind each fix, so the lossy compactor can't discard load-bearing
     reasoning. This is the chapter's central save.
   - **`/triage-session`** — end-of-session hygiene in one keystroke.
   - **`/safe-fork`** — see the parent thread's spend before you branch.
3. `work/.claude/settings.json` shows the Make-it-yours prompt-2 defaults
   (`effort: high`, latest Sonnet model). The chapter places this at your real
   `~/.claude/settings.json`; the model name is illustrative since that surface
   evolves quarterly — use the alias your install reports.
4. `work/dashboard/dashboard-deploy.log` is the synthetic deploy log the
   "When it goes wrong" recovery prompt reads. It holds the LinkedIn OAuth
   redirect-loop error trace — the *why* the lossy `/compact` discarded — so the
   recovery scene is reconstructable in isolation. It's the source the sample
   `decisions/2026-05-05.md` was built from.
5. `work/watchdog/escalations.log` (with its `fixtures/README.md`) makes the
   `/btw` and `ultrathink` scenes runnable in isolation. The log is seeded with
   the duplicate-timestamp double-ping that the chapter's ultrathink prompt
   diagnoses as orchestrator double-dispatch.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 22 walks you through building.
