# Chapter 18 — The deck your boss asked for

This chapter builds a **multi-source deck composer**: Claude reads
five input surfaces (a boss email via Gmail, a linked Notion page, a
`.pptx` template, Q3 finance CSVs, a strategy roadmap + all-hands
notes, and a weekly Atlas signal file), asks 3 to 5 clarifying
questions, files a canonical `brief.md`, produces a 12-slide outline
with source pointers and speaker notes *before* rendering anything,
and only then renders the `.pptx` against the company template. The
last move teaches the whole flow to a `/deck` slash command so the
next deck takes 30 minutes instead of 90. The patterns introduced —
**multi-source synthesis**, **clarification dialogue**, and
**template-bound generation** — recur in Ch 19, 21, and 25.

## Files in this folder

```
ch18-the-deck/
├── README.md                                  this file
├── prompts.md                                 every chapter prompt, verbatim, in order
├── fixtures/
│   ├── README.md                              shape of the Gmail + Notion inputs
│   ├── gmail-sample-thread.md                 synthetic stand-in for the boss email
│   └── notion-sample-page.md                  synthetic stand-in for the Notion bullets
└── work/                                      maps to ~/work/
    ├── .claude/commands/
    │   ├── deck.md                            the /deck command (Step 6 + the chart-convention fix)
    │   ├── qbr.md                             /qbr — customer QBR variant (variation 7)
    │   └── all-hands.md                       /all-hands — monthly all-hands variant (variation 7)
    ├── board-prep/2026-q3/
    │   ├── brief.md                           the canonical source of truth (Step 2)
    │   ├── outline.md                         12-slide outline, corrected (Steps 3 + 4)
    │   └── speaker-notes.md                   phone-readable notes (Step 5)
    ├── finance/2026-Q3/
    │   ├── bank-export.csv                    revenue / COGS / opex rows
    │   └── stripe-export.csv                  subscription events + fees
    ├── strategy/
    │   ├── q4-roadmap.md                      Q4 workstreams, big bets, risks, plan baseline
    │   └── all-hands-2026-05-02.md            the onboarding commitment (Priya, Dec 12)
    ├── atlas/
    │   └── signals-2026-05-08.md              7 signals; #4 has the Wednesday $40M→$55M update
    └── templates/
        └── README.md                          shape of the .pptx template (no binary shipped)
```

> Note on `deck.pptx`: the chapter renders a binary PowerPoint file
> at Step 5. We do not ship the binary — it is generated from your
> own brand template. Run the `/deck` command (or the Step 5 prompt)
> against your template to produce it.

## How to use

1. Copy `work/` into your `~/work/` (or point Claude at this folder).
   The `finance/`, `strategy/`, and `atlas/` files are real and ready
   to read; the `.pptx` template and the Gmail/Notion surfaces are
   described in the two `README.md` fixture files.
2. Open Claude in the work folder: `cd ~/work && claude`.
3. To dry-run without live Gmail/Notion, paste
   `fixtures/gmail-sample-thread.md` and `fixtures/notion-sample-page.md`
   when Claude reaches the read step.
4. Walk the prompts in `prompts.md` in order, or just invoke the
   pre-built command: ask Claude in plain English to
   "compose a board deck for tomorrow 9 AM" and it runs `/deck`.
5. The outline gate is mandatory — read `outline.md` line by line
   before you let Claude render the `.pptx`.

The book is self-contained — these files are ready-to-clone copies
of what Chapter 18 walks you through building.
