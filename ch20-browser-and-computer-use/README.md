# Chapter 20 — Browser and computer use

This chapter has Claude drive a real browser (Claude-in-Chrome MCP) and, when a
site blocks automation, the whole desktop (computer-use MCP) to close seven
subscription leaks in one evening. It teaches two new Claude Code surfaces and one
new prompting discipline: **terminal-state vs. path-of-action prompting** — when
you grant auto-approval over a multi-step flow, specify the end state you want
("subscription will not renew"), not just the action path ("cancel"). The capstone
artifact is a reusable `cancel-leak` slash command with the hard-won lessons
(final-confirmation guard, terminal-state clause, anti-automation fallback) baked in
as clauses.

## Files

```
ch20-browser-and-computer-use/
├── README.md                         this file
├── prompts.md                        every chapter prompt, verbatim and in order
└── work/
    ├── .claude/commands/
    │   └── cancel-leak.md            the capstone slash command (Step 8)
    ├── finance/
    │   ├── subscription-leaks.md     the Ch 2 input (4 cols, 7 rows) + [CANCELLED] markers
    │   └── cancellations/2026-05-08/
    │       ├── summary.md            per-flow dark-pattern transcript
    │       ├── total-saved.md        $84/mo, $1,008/yr ledger
    │       ├── permissions.log       every auto-approve decision (audit trail)
    │       └── fixtures-README.md    why the 7 confirmation PDFs aren't shipped
    ├── research/
    │   ├── competitors.csv           input for the Step 7 browser-as-data-source scrape
    │   ├── competitor-pricing/
    │   │   └── 2026-05-08.csv         sample scrape output
    │   └── regulators.md             make-it-yours #4 input (research scrape)
    ├── privacy/
    │   └── data-brokers.md           make-it-yours #2 input (privacy opt-outs)
    ├── calendar/
    │   └── events-this-month.md      make-it-yours #3 input (conference RSVP)
    └── crm/
        └── cold-list.md              make-it-yours #5 input (contact harvest)
```

The `.claude/commands/` here is scoped under `work/` because the chapter authors
the command at `~/work/.claude/commands/cancel-leak.md` (project-scoped, not global).

## How to use

1. Copy `work/.claude/commands/cancel-leak.md` to your own `~/work/.claude/commands/`.
2. Make sure you have the Claude-in-Chrome MCP and computer-use MCP installed
   (one-time, the same way every other MCP in this book installs — see Appendix C).
   Claude will prompt you the first time it tries to drive the browser.
3. Have a `subscription-leaks.md` from Chapter 2 (4 columns:
   `name | monthly_cost | last_charge_date | cancellation_url`). A synthetic sample
   ships at `work/finance/subscription-leaks.md`.
4. Run it: *"Run cancel-leak on ~/work/finance/subscription-leaks.md."*
   - The first cancellation runs in plan mode (you approve each click).
   - After the first success, Claude auto-approves with guards: it pauses before
     any final-confirmation modal, on any login/password prompt, and on any
     anti-automation page (falling back to computer use).
   - The only acceptable terminal state is "subscription will not renew" — any
     free-month / pause / discount / demoted-tier path is refused and escalated.
5. Claude files a confirmation PDF per cancellation, plus `summary.md`,
   `total-saved.md`, and `permissions.log`, into a dated folder.

The seven confirmation PDFs are NOT shipped: each is a live capture of your own
logged-in account on the day you run the audit (see
`work/finance/cancellations/2026-05-08/fixtures-README.md`). Claude produces them
for you. The `competitors.csv` and the make-it-yours inputs are small synthetic
samples — replace them with your own data.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 20 walks you through building.
