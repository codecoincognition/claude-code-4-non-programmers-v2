# Chapter 11 — Reuben, the bookkeeper

Chapter 11 hires Maya's third staff member, Reuben, and the lesson is *how the
third hire is different by design from the first two.* Iris and Atlas are
all-AI judgment workers. Reuben is **hybrid**: a tiny deterministic shell
script does the exact arithmetic (sums, monthly groupings, running balance —
no AI, same answer every time), and an AI agent reads that output plus the raw
CSV to categorize transactions, flag anomalies, and write the month's
narrative — *constrained by the deterministic numbers it may never recompute or
round.* A `SessionEnd` hook (the third hook the book promised, after
`SessionStart` in Ch 7 and `PreToolUse` in Ch 8) files the finished P&L when a
calendar month rolls over. This folder ships clone-ready copies of all of it.

## Files

| Path | What it is |
|------|------------|
| `scripts/reuben-deterministic.sh` | The deterministic core. Pure `awk`: reads the CSV, prints exact monthly inflow / outflow / net / running balance. The agent's "truth layer." (Uses gawk's `asorti` for month sorting, as printed in the book — install gawk, or run `verify-deterministic.sh` which is portable.) |
| `scripts/reuben-fileend.sh` | The `SessionEnd` hook script. Idempotent month-boundary checker — files the previous month's P&L once, the first time it runs in a new calendar month, and does nothing otherwise. |
| `scripts/verify-deterministic.sh` | The CI test the chapter's callouts describe. Runs the arithmetic against the fixed sample CSV with known totals; exits non-zero on any cent of drift. Portable (no `asorti`) so it runs on stock macOS or Linux. |
| `work/.claude/agents/reuben.md` | The Reuben agent — frontmatter + tool allowlist + the *Numerical-fidelity discipline* body that binds the AI to the script's numbers. |
| `work/.claude/agents/reuben-quarterly.md` | Make-it-yours #2: the quarterly-rollup variant. Same shape, larger window. |
| `work/.claude/settings.json` | All three hooks side by side: `SessionStart`, `PreToolUse`, and the new `SessionEnd` scoped to `agent:reuben`. |
| `work/books/pnl-2026-04.md` | The example April P&L the chapter shows Reuben write — every number ties to the script or a CSV row. |
| `work/books/filing-log.md` | The audit trail the hook appends to. |
| `data/transactions.csv.sample` | The synthetic transactions across Jan–Apr 2026. Ties **exactly** to the chapter's printed totals (TOTAL inflow 71920.00, outflow 48440.73, net 23479.27). |
| `data/ad-spend-2026-04.csv` | Synthetic ad-spend input for the Marketing-section extension. |
| `fixtures/README.md` | Input shapes for the Notion Leads DB (Marketing extension) — no private data, just the schema + a synthetic sample. |
| `prompts.md` | Every prompt from the chapter, verbatim and in order. |

## How to use

1. **Drop the artifacts into your workspace.** Copy `work/.claude/` to
   `~/work/.claude/`, `scripts/` to `~/work/scripts/`, and the sample CSV in:
   ```bash
   cp data/transactions.csv.sample ~/work/data/transactions.csv
   chmod +x ~/work/scripts/*.sh
   ```
2. **Run the deterministic core** to see the truth layer:
   ```bash
   # needs gawk (brew install gawk) for asorti month-sorting
   ~/work/scripts/reuben-deterministic.sh ~/work/data/transactions.csv
   ```
3. **Verify it ties** (portable, no gawk needed):
   ```bash
   ./scripts/verify-deterministic.sh
   ```
4. **Run the agent.** Open Claude in `~/work` and prompt:
   *"Run Reuben on April 2026. Show me the deterministic output first, then his
   narrative built on top of it."* Compare to `work/books/pnl-2026-04.md`.
5. **The hook fires on session end.** With `settings.json` in place, ending a
   Reuben session files the previous month's P&L into `filing-log.md` — once,
   on the month boundary. See it both ways with the Step 5 prompt in
   `prompts.md`.

The decision rule the chapter leaves you with: if the work has a *correct
answer* verifiable independent of the agent, use the Reuben (hybrid) pattern;
if it has a *good answer* in a wide acceptable range, use the Iris (all-AI)
pattern.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 11 walks you through building.
