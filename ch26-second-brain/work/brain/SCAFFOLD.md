# SCAFFOLD — read me before writing anything into brain/

> *Claude reads this file first when adding to the brain. It teaches the folder
> shape and the three rules. If you (the human) are reading it, you can skim —
> the rules are also in [README.md](./README.md).*

This brain is a plain-Markdown knowledge base. The human writes in English by
prompting Claude. **Claude writes the files.** Obsidian renders them.

If you are a Claude session opening this folder for the first time, follow the
three rules below before creating any file. They were taught once and now live
here so future sessions don't have to re-derive them.

---

## The folder shape

```
brain/
├── INDEX.md                 ← auto-maintained one-page index of everything below
├── README.md                ← the human-facing intro
├── SCAFFOLD.md              ← this file
├── projects/
│   └── {project-name}/
│       ├── README.md        ← one paragraph: what this project is
│       ├── decisions/       ← ADRs, one file per call: {YYYY-MM-DD}-{slug}.md
│       ├── runbooks/        ← how to operate this project, one file per procedure
│       └── debug-log.md     ← single file; dated entries appended on each break
├── concepts/                ← domain glossary, one file per term
└── patterns/                ← reusable plays, one file per play that worked >1×
```

**One artifact type per folder.** A decision goes in `decisions/`. A runbook
goes in `runbooks/`. A glossary entry goes in `concepts/`. Do not mix types
inside a folder. If a new artifact type emerges (research notes, client folders,
interview transcripts), propose a new top-level folder and ask the human before
creating it. Folder sprawl is the enemy of legibility.

**Filename conventions:**

- Decisions: `{YYYY-MM-DD}-{short-slug}.md` (e.g. `2026-04-18-chartjs-over-d3.md`)
- Runbooks: `{verb}-{noun}.md` (e.g. `daily-refresh.md`, `onboard-acme-client.md`)
- Concepts: `{term}.md` (e.g. `relative-strength.md`)
- Patterns: `{pattern-name}.md` (e.g. `static-dashboards-over-spas.md`)
- Project READMEs: always literally `README.md` inside the project folder
- Debug log: always literally `debug-log.md` (one per project, append-only)

---

## The three rules (taught once, applied everywhere)

### Rule 1 — Use the folder shape above

One artifact type per folder. Don't drop a runbook into `decisions/` because it
"sort of feels like a decision." If the artifact doesn't fit any folder, ask the
human before inventing a new shape. The shape is the contract that makes the
brain searchable years from now.

### Rule 2 — Add `[[wikilinks]]` to related entries on every write

Every file you create must include `[[wikilinks]]` to other entries you know
about — decisions link to the project README, runbooks link to the decisions
that authored them, patterns link to the projects that used them, concepts link
to anywhere the term gets applied. Obsidian renders the graph view from these
edges; without them the graph is a constellation of isolated dots and the brain
becomes a flat folder of disconnected notes.

Forward references are fine. If you mention `[[../../../patterns/static-dashboards-over-spas]]`
and that file doesn't exist yet, Obsidian renders it as a dashed node the human
can fill in later. Don't withhold a link just because the target hasn't been
written.

Use relative paths for the wikilink targets (`[[../README]]`, `[[../runbooks/daily-refresh]]`)
so the graph still resolves when folders are renamed or moved.

### Rule 3 — Don't guess at file paths

If the human's prompt names a project, use that project folder. If it doesn't
— or if the project folder doesn't exist — **ask before creating anything**.
Do not infer the project name from context and silently create
`projects/{your-guess}/decisions/{file}.md`. Wrong-folder entries are the hardest
class of brain bug to recover from because the wikilinks point at the wrong place
and the graph misrepresents the work.

The acceptable replies when the path is ambiguous:
- *"Which project does this belong to? I see `dashboard`, `iris`, and `reuben` under projects/. Or is this a new project?"*
- *"This sounds like a `pattern` rather than a project-scoped decision. Save to `patterns/{slug}.md`?"*
- *"The folder you named doesn't exist yet. Create `projects/{name}/` with the standard sub-shape (decisions/, runbooks/, debug-log.md, README.md), then save the entry?"*

---

## After every write

Update `INDEX.md`. Append the new entry to the relevant section so the one-page
index stays current. The index is the human's table of contents — if it drifts
the brain effectively shrinks. Treat the index update as part of the write, not
as a follow-up step.

---

## What you do NOT do

- **Do not edit Markdown in Obsidian.** Two sources of truth, drift, sadness.
  The human prompts; Claude writes; Obsidian renders. That's the rule.
- **Do not sync this folder to a cloud service** without the human's explicit
  decision. Brain content is personal — client names, decision rationale,
  debug histories. Privacy is local by default.
- **Do not delete entries silently.** If an entry is obsolete, move it to
  `brain/.archive/` (create if missing) with a one-line reason at the top and
  ask the human before doing it.
- **Do not add YAML frontmatter** unless the human asks. The brain stays as plain
  Markdown so the artifact reads in any editor for the next decade.
