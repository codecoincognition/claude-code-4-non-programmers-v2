# Chapter 1 — Read the folder you've been ignoring

In Chapter 1 you point Claude at a folder you've been avoiding (Maya uses her
eleven-months-of-chaos `~/Downloads/`) and, in one pass, get back a categorized
report written to disk, a structured table of forgotten subscription "leaks," and
a byte-hash list of true duplicates. Then two short follow-on prompts move the
duplicates (with a plan you approve first) and read three contracts that share a
name but turn out to be three different vendors. The whole thing is the book's
core pattern in miniature: **point Claude at a folder, ask for structured
analysis, get a file written to disk** — and always run a *describe pass before a
move pass*.

## Files in this folder

| Path | Purpose |
|---|---|
| `work/.claude/settings.local.json` | The deny/allow list Maya already has saved before the chapter starts — keeps writes inside `~/work/`, blocks secrets, blocks `rm`/`sudo`. Copy into your `~/work/.claude/`. |
| `work/finance/subscription-leaks-draft.md` | The exact 4-column / 7-row subscription table Claude writes in Step 1. **Load-bearing through Chapter 20** — don't rename the columns. Chapter 2 reads it, Chapter 20 acts on it. |
| `Downloads/to-act-on.md` | The categorized describe-pass report Claude writes in Step 1, with the contracts / invoices / subscriptions / duplicates / junk sections. |
| `prompts.md` | Every prompt from the chapter, verbatim and in order: Steps 1–3, the "when it goes wrong" recovery prompt, the five make-it-yours prompts, and the 60-second self-test. |
| `fixtures/README.md` | What Chapter 1 actually reads (your own Downloads) and why we don't fabricate it — plus how to dry-run against a safe synthetic folder. |
| `fixtures/sample-downloads/` | Four harmless stand-in files (two subscription confirmations, one invoice, and a byte-identical copy of it) so you can dry-run the Step 1 prompt before aiming at real data. |

## How to use

1. Copy `work/` into your home directory so it lands as `~/work/` — this gives you
   `~/work/.claude/settings.local.json` (the safety fences) and
   `~/work/finance/subscription-leaks-draft.md` (the seed file Chapter 2 reads).
2. The `Downloads/to-act-on.md` here is a *reference* of what your own report will
   look like. When you run the chapter, Claude writes a fresh one against your real
   `~/Downloads/`.
3. To try the prompts without touching private data, copy
   `fixtures/sample-downloads/` somewhere and point the Step 1 prompt (in
   `prompts.md`) at that path instead of `~/Downloads/`.
4. Open `prompts.md`, run the prompts in order: Step 1 (read + report + leaks),
   Step 2 (describe-then-move the duplicates), Step 3 (read the three contracts).

The book is self-contained — these files are ready-to-clone copies of what
Chapter 1 walks you through building.
