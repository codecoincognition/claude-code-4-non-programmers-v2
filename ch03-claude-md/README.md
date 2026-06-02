# Chapter 3 — Give Claude a memory it actually uses (`CLAUDE.md`)

This chapter builds the one file Claude reads at the top of every session in your work folder: a six-line `CLAUDE.md` — four borrowed behavioral lines (the universal "how to think" rules from the 60K-star `forrestchang/andrej-karpathy-skills` repo) plus two contextual lines only you can write (who you are, what's off-limits). It also tours the `.claude/` folder anatomy and creates the empty `commands/`, `agents/`, and `skills/` placeholders that later chapters fill. This folder holds ready-to-clone copies of all of that, plus the five reader variants and the recovery artifacts from the "when it goes wrong" section.

## Files

### `work/` — copy this into your `~/work/`
- `work/CLAUDE.md` — Maya's final six-line boot script (4 borrowed + 2 hers). The exact file from Step 5.
- `work/.claude/settings.local.json` — the deny list from Chapter 0.3 (already present at the start of Chapter 3; included so the starting position matches the book).
- `work/.claude/commands/.gitkeep` — empty placeholder, filled in Chapter 4.
- `work/.claude/agents/.gitkeep` — empty placeholder, filled in Chapters 6 / 9-12.
- `work/.claude/skills/.gitkeep` — empty placeholder, filled in Chapters 6 / 14.

### `variants/` — the five "Make it yours" templates
Same four behavioral lines, different two contextual lines. Pick the one closest to you, rename it to `CLAUDE.md`, and edit the contextual lines to fit your real folder and your real fences.
- `variants/CLAUDE.md.consultant` — the consultant (Maya's; identical to `work/CLAUDE.md` minus the headers).
- `variants/CLAUDE.md.phd-researcher` — PhD candidate with a read-only data folder.
- `variants/CLAUDE.md.startup-founder` — founder with a read-only `private/` folder.
- `variants/CLAUDE.md.recruiter` — in-house recruiter with GDPR-shaped fences (three contextual lines, not two — a real example of the file growing to fit a real situation).
- `variants/CLAUDE.md.content-creator` — YouTube + Substack creator with a voice and a no-publish fence.

### `reference/` — the alternate forms the chapter discusses
- `reference/CLAUDE.behavioral-only.md` — the four borrowed lines on their own (the universal half, before you add your two contextual lines). Includes the exact `curl` command the chapter uses to fetch them.
- `reference/CLAUDE.repaired-12-line.md` — the litmus-test-repaired file from "When it goes wrong" (47 lines cut back to 12: the original 6 plus 6 genuine additions). Two additions are named verbatim in the chapter; the rest are faithful litmus-passing examples.

## How to use
1. Copy `work/CLAUDE.md` to your `~/work/CLAUDE.md` (or pick a `variants/` file, rename it to `CLAUDE.md`, and edit the two contextual lines for your real folder and fences).
2. Copy the empty placeholders if you want the full anatomy on disk now: `cp -R work/.claude ~/work/.claude` (skip `settings.local.json` if you already set up your own deny list in Chapter 0.3).
3. Quit and restart Claude in `~/work/` — `CLAUDE.md` is read at session start, so a running session won't see a file you just created. Look for `Reading CLAUDE.md... loaded.` in the boot output.
4. Run the litmus test on every line: *"would removing this line cause you to make an actual mistake?"* Cut anything that fails.

The book is self-contained — these files are ready-to-clone copies of what Chapter 3 walks you through building.
