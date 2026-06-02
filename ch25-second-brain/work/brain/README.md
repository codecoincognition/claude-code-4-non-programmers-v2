# brain/ — your second brain

A plain-Markdown knowledge base. Claude writes into it; [Obsidian](https://obsidian.md)
renders it. The format is dated Markdown files on your disk, so the artifact
outlives every tool — Notion, Obsidian, even Claude itself may change shape; a
folder of `.md` files reads forever.

## The five folders (the floor)

```
brain/
├── projects/
│   └── {project-name}/
│       ├── README.md        ← what this project is
│       ├── decisions/       ← ADRs: dated calls, with reasoning
│       ├── runbooks/        ← how to operate this project
│       └── debug-log.md     ← things that broke and how you fixed them
├── concepts/                ← domain glossary (your work vocabulary)
└── patterns/                ← your playbooks (things you've done that worked)
```

You can add more later — `research/`, `clients/`, `interviews/`, `transcripts/`.
The five above are the floor. Resist folder sprawl for the first month.

## Three rules Claude follows

1. **Use this folder shape.** One artifact type per folder.
2. **Add `[[wikilinks]]`** to related entries on every write. Obsidian renders the
   graph view from them.
3. **Don't guess at file paths.** If unsure which project an entry belongs to, ask.

## The workflow

**Claude writes; Obsidian renders.** You never type into Obsidian and you never
write `[[wikilinks]]` by hand. You prompt Claude in English, Claude writes the
file, Obsidian renders the graph, backlinks, search, and tags — all for free.

## Open in Obsidian

1. Download Obsidian from [obsidian.md](https://obsidian.md) (free, local, no account).
2. *Open folder as vault* → select this `brain/` folder.
3. Click any entry; the `[[wikilinks]]` are clickable. Open the graph view
   (constellation icon) to see the constellation.

## Privacy

This folder is local. It accumulates client names, decision rationale, debug
stories. Keep it local — don't sync to a service unless you've thought about who
else can read it. The only sanctioned way for an entry to leave the folder is the
`publish-public` skill, and it requires an explicit `public-ok` tag.
