# Chapter 4 — Three verbs you'll run every day (slash commands)

Companion repo for Chapter 4. This is the only chapter in Part I where you
type slash commands yourself — authoring a command requires running it. After
this chapter the book-wide rule snaps back: you prompt in plain English and
Claude picks the slash.

The chapter takes three prompts you keep retyping and turns each into a named
`.md` file in `~/work/.claude/commands/`. The filename (minus `.md`) becomes
the command name. The file body is just the prompt — no JSON, no DSL.

## What's in this folder

```
ch04-three-verbs/
├── README.md                         ← you are here
├── prompts.md                        ← every prompt the chapter has you type, in order
├── work/                             ← clone of Maya's ~/work/ at the end of Ch 4
│   ├── CLAUDE.md                     the work "badge" from Ch 2 (read before every command)
│   ├── .claude/
│   │   └── commands/
│   │       ├── reconcile.md          /reconcile  — Step 2 (monthly bank-vs-Stripe)
│   │       ├── triage.md             /triage     — Step 4 (cross-system inbox sweep)
│   │       ├── renewals.md           /renewals   — Step 5 (takes $ARGUMENTS; whitespace-hardened per "When it goes wrong")
│   │       ├── reconcile-quarter.md  Make-it-yours #3 (quarterly roll-up)
│   │       └── renewals-all.md       Make-it-yours #4 (/renewals all — composition)
│   ├── finance/
│   │   ├── bank-2026-10.csv          input for /reconcile
│   │   ├── stripe-2026-10.csv        input for /reconcile
│   │   ├── subscription-leaks.md     /reconcile reads + updates this (Headspace cancels, Buffer added)
│   │   └── contracts/                vendor agreements — input for /renewals finance/contracts
│   │       ├── README.md
│   │       ├── vercel-pro-agreement.md
│   │       └── aws-savings-plan.md
│   └── legal/                        client contracts — input for /renewals legal
│       ├── README.md
│       ├── acme-msa.md
│       ├── northwind-sow.md
│       └── globex-msa.md
└── extras/
    └── commands-with-frontmatter/    Make-it-yours #2 — same commands with /help descriptions
        ├── reconcile.md
        ├── triage.md
        └── renewals.md
```

## How to use it

1. Copy `work/` to your home directory so it lands at `~/work/`, or just `cd`
   into this `work/` folder and run `claude` from there.
2. Quit and restart Claude so the commands in `.claude/commands/` are loaded at
   session start. The boot line should read
   `Loaded 5 slash commands: reconcile, triage, renewals, reconcile-quarter, renewals-all`.
3. Try the three core commands:
   - `/reconcile` — reads `bank-2026-10.csv` + `stripe-2026-10.csv`, matches the
     9 Stripe payouts, categorizes the rest into spend buckets, and updates
     `subscription-leaks.md` (Headspace marked cancelled, Buffer added).
   - `/renewals legal` — scans `work/legal/`, produces a renewals table with
     Acme (⚠ < 30 days) pinned to the top.
   - `/renewals finance/contracts` — scans the vendor-agreement folder.
   - `/triage` — has no MCPs connected here, so it asks you to paste a digest.
     That fallback is intentional; Chapter 5 wires in the real Gmail/Slack/Notion
     MCPs and the same `triage.md` runs without pasting.

## Notes on the sample data

- **Finance CSVs and contracts are synthetic.** They are tuned so the commands
  produce the exact output the chapter shows.
- **No real Gmail/Slack/Notion data ships here.** Those are your private apps.
  `/triage` is written to ask for a digest when no MCP is connected — that's the
  correct artifact until Chapter 5.
- **`acme-msa-renewal.pdf` is not shipped** (a real renewal notice is the
  vendor's own binary). Its key facts live in the `acme-msa.md` body. Drop any
  contract PDF named `acme-msa-renewal.pdf` into `work/legal/` to test PDF
  parsing.

## The rule, for the rest of the book

Outside this chapter, Part VII, and Appendix I, **you don't type slashes**. You
prompt Claude in plain English; Claude picks the underlying command and tells
you what it picked. Slash commands are the machinery; the prompt is the
conversation.
