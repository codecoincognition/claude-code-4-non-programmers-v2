# Chapter 25 — Your second brain (Obsidian as the visualizer, Claude as the writer)

This chapter builds an **llm-wiki**: a plain-Markdown knowledge base under
`~/work/brain/` that Claude writes into and Obsidian renders. Five folders, one
free app (Obsidian), and three rules Claude follows when it writes. The artifact
is dated `.md` files on your disk — the format that outlives every tool. This
folder is a ready-to-clone version of the brain the chapter walks you through
scaffolding (the Chapter 21 dashboard seeded as the first project), plus the
richer variants the chapter's make-it-yours section describes.

## File-by-file

### `work/brain/` — the day-one brain (the chapter's Step 1 output)

- `work/brain/README.md` — explains the system: five folders, three rules, the
  "Claude writes; Obsidian renders" workflow, and the privacy note.
- `work/brain/projects/dashboard/README.md` — one-paragraph summary of the Ch 21
  dashboard (what it shows, data source, refresh cadence).
- `work/brain/projects/dashboard/decisions/2026-04-18-chartjs-over-d3.md` — the
  seeded ADR (Chart.js over D3), the exact entry the chapter prints in full.
- `work/brain/projects/dashboard/runbooks/daily-refresh.md` — how the nightly
  refresh runs and what to check when it fails.
- `work/brain/projects/dashboard/debug-log.md` — dated entry for a real
  build-time glitch (blank charts on first deploy).
- `work/brain/concepts/.gitkeep` — folder starts empty; keeper survives clone.
- `work/brain/patterns/.gitkeep` — folder starts empty; keeper survives clone.

### `variations/` — the make-it-yours extras the repo pointer promises

- `variations/sunday-review-hook/settings.json` — Variation 3: a `SessionStart`
  hook that fires only on Sundays and asks Claude to surface the week's
  most-linked entries plus one orphan. Plus its own README.
- `variations/publish-public-skill/.claude/skills/publish-public/SKILL.md` —
  Variation 5: the skill that copies a sanitized, `public-ok`-tagged entry into
  the Chapter 19 website's `posts/`. Never auto-publishes.
- `variations/multi-project-sample/` — sample ADRs and runbooks across multiple
  projects (Iris from Ch 9, Reuben from Ch 11) with a filled-in pattern entry,
  so you can see a populated Obsidian graph before your own brain fills up.

### Root

- `prompts.md` — every prompt from the chapter, verbatim and in order.

## How to use

1. Copy `work/brain/` to `~/work/brain/` (or clone and work in place).
2. Download Obsidian from [obsidian.md](https://obsidian.md) — free, local, no
   account. Choose *Open folder as vault* and point it at `brain/`.
3. Click the seeded ADR; the `[[wikilinks]]` are clickable. Open the graph view
   (constellation icon) to see the nodes — solid for entries that exist, dashed
   for forward-referenced entries you'll fill in later.
4. To log your own entries, use the prompts in `prompts.md`. You never type into
   Obsidian; you prompt Claude, Claude writes the Markdown, Obsidian renders it.
5. To try the variations, merge the Sunday hook into your real
   `~/work/.claude/settings.json`, drop the `publish-public` skill into your
   `.claude/skills/`, or copy the multi-project sample folders into `brain/`.

**Privacy:** the brain is local. It holds client names, decision rationale, and
debug stories — keep it local. The only sanctioned way for an entry to leave is
the `publish-public` skill, and only after you tag it `public-ok`.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 25 walks you through building.
