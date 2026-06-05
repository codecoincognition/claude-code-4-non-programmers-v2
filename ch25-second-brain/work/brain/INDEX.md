# INDEX — brain at a glance

> *Auto-maintained. Claude updates this file every time an entry is added,
> renamed, or retired. The human reads it; the human does not edit it.*
>
> Last refreshed: 2026-04-18

A one-page index of everything in `~/work/brain/`. Open this file when you want
to know *what's in your second brain right now* without clicking through folders.

For the folder convention and the three rules Claude follows when writing here,
see [SCAFFOLD.md](./SCAFFOLD.md) and [README.md](./README.md).

---

## Projects

Active work folders. Each has a `README.md`, `decisions/`, `runbooks/`, and a
`debug-log.md`.

| Project | What it is | Status | Folder |
|---|---|---|---|
| dashboard | The Ch 21 self-refreshing stakeholder dashboard | Live, refreshes nightly at 3 AM | [`projects/dashboard/`](./projects/dashboard/) |

*(More projects appear here as you log decisions and runbooks against them.
Iris, Atlas, Reuben, Echo, the newsroom, the launch crew, the watchdog mesh —
each becomes a `projects/{name}/` folder the first time you ask Claude to log
something against it.)*

---

## Recent decisions

The last ten ADRs written, newest first. Each links to the dated file under
`projects/{name}/decisions/`.

| Date | Project | Decision | File |
|---|---|---|---|
| 2026-04-18 | dashboard | Chart.js over D3 — small bundle, first-prompt write, non-technical viewer | [`2026-04-18-chartjs-over-d3`](./projects/dashboard/decisions/2026-04-18-chartjs-over-d3.md) |

*(Each new ADR Claude writes appears at the top of this list. Older entries fall
off after ten; the full history stays in the per-project `decisions/` folder.)*

---

## Runbooks

Operating procedures, one per file. The "how to do this thing the same way every
time" half of each project.

| Project | Procedure | File |
|---|---|---|
| dashboard | Daily refresh — what runs at 3 AM, what to check if it fails | [`daily-refresh`](./projects/dashboard/runbooks/daily-refresh.md) |

---

## Concepts

Domain glossary — one file per term whose meaning you want to lock down so it
means the same thing across every project.

*(Empty. Seed by asking Claude: "Add `relative-strength` to `brain/concepts/` —
what it means, how I measure it, two links to where I've used it.")*

---

## Patterns

Reusable plays — one file per pattern that's worked more than once across
projects.

*(Empty. The first pattern you reach for twice is the first pattern worth
naming. Ask Claude: "Save this as a pattern in `brain/patterns/`. Name it,
state when to use it, link to the projects where you've seen it work.")*

---

## Orphans to fix

Files with no incoming or outgoing `[[wikilinks]]`. Run the orphan scan from
Ch 25 once a month to identify and fix these:

> *Read every file in ~/work/brain/. For each orphan, suggest 2-3 relevant
> entries it should link to.*

*(None today. Re-scan next month.)*

---

## How this index stays current

Claude updates this file as part of every write into `brain/`. If you ever
suspect drift, run:

> *Walk ~/work/brain/ and rebuild INDEX.md from what's actually on disk.
> Preserve the section structure; replace the contents.*

A full rebuild takes Claude under a minute and re-establishes ground truth.
