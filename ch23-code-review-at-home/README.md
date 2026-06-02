# Chapter 23 — Code review at home

This chapter builds a personal code-review surface on top of Claude
Code's review commands. You learn four lenses — `/simplify` (quality,
deep on one file), `/security-review` (safety, broad audit), `/sandbox`
(behavior, run in isolation), `/batch` (sweep a known-good pattern across
many files) — and **auto mode**, the AI classifier that reads your prompt
and picks the right lens, model, and effort, telling you what it picked.
By the end you have a personalized `/review-mine` slash command, an
auto-mode hints file that trains the classifier from your overrides, and
a dated review-folder pattern (`~/work/reviews/{date}/`) that grows one
folder per review session.

## Files in this folder

```
ch23-code-review-at-home/
├── README.md                                  ← you are here
├── prompts.md                                 ← every chapter prompt, verbatim
├── fixtures/
│   └── README.md                              ← input shapes; secrets stay out of files
└── work/                                      ← maps to ~/work/
    ├── .claude/
    │   ├── commands/
    │   │   ├── review-mine.md                 ← personal review-posture slash command
    │   │   └── cancel-leak.md                 ← Ch 20 cancellation command (post-review)
    │   └── auto-mode-hints.md                 ← classifier override hints
    ├── dashboard/
    │   ├── build.sh                           ← /simplify target (3 fixes applied)
    │   └── refreshers/
    │       ├── refresh_stripe.py              ← /batch target (Python try/except)
    │       ├── refresh_linkedin.py            ← /batch target (Python try/except)
    │       ├── refresh_notion.sh              ← /batch target (set -euo pipefail)
    │       ├── refresh_bank.sh                ← /batch target (set -euo pipefail)
    │       ├── refresh_buffer.sh              ← /batch target (set -euo pipefail)
    │       └── refresh_dashboard.sh           ← /batch target (set -euo pipefail)
    ├── scripts/
    │   └── kill-switch.sh                      ← /sandbox target (2 fixes applied)
    └── reviews/
        ├── 2026-05-08/                         ← Maya's Friday review session
        │   ├── build.md
        │   ├── cancel-leak.md
        │   ├── kill-switch.md
        │   └── review-summary.md
        └── pr-284/                             ← Devon's Tuesday PR review
            └── review-summary.md
```

## How to use

1. Copy `work/.claude/commands/review-mine.md` and
   `work/.claude/auto-mode-hints.md` into your own `~/work/.claude/`.
   Auto mode reads the hints file at session start; `/review-mine`
   becomes available immediately.

2. Turn on auto mode (`/auto`) and review files in plain English:
   `Review the files I authored today. Output to ~/work/reviews/{date}/.`
   The classifier picks the lens per file and tells you its picks.

3. Override when the classifier is wrong
   (`/security-review on <file>`, `/sandbox on <script>`,
   `/batch the <pattern> across <folder>`), then add a rule to
   `auto-mode-hints.md` so the override becomes the default.

4. The sample `build.sh`, `cancel-leak.md`, `kill-switch.sh`, and the
   six `refreshers/` are the **post-review** versions — they show what
   the fixes from each lens look like once applied. The matching review
   reports under `reviews/2026-05-08/` show what each lens found.

The book is self-contained — these files are ready-to-clone copies of
what Chapter 23 walks you through building.
