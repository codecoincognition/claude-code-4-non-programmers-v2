# Multi-project sample brain

A richer brain than the day-one floor, showing the shape after a few weeks of
real use: three project folders (dashboard lives in the main `work/brain/`; Iris
and Reuben are seeded here), filled `patterns/`, and forward-referenced
`concepts/` you fill in as you go. Use it to see what a populated graph view looks
like in Obsidian before your own brain fills up.

## What's here

- `projects/iris/` — Chapter 9 inbox agent, with a real ADR (refund window)
- `projects/reuben/` — Chapter 11 bookkeeper, with a runbook (recurring P&L surprise)
- `patterns/log-approved-replies-as-decisions.md` — a filled-in pattern entry the
  ADRs link back to

## How to use

Drop these folders into your real `~/work/brain/` alongside the dashboard
project, then *Open folder as vault* in Obsidian. The graph will show three
project clusters linked through the shared pattern node. This is the
"sample ADRs across multiple projects" the chapter's repo pointer mentions.

## Note on dashed nodes

Some `[[wikilinks]]` here (e.g. `concepts/accrual-vs-cash-timing`) point at
entries that don't exist yet — Obsidian renders them as dashed nodes you fill in
later. That's intentional: Claude is allowed to forward-reference.
