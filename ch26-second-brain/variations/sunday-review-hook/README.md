# Variation 3 — The Sunday review (optional hook)

A `SessionStart` hook that fires only on Sundays. When you open Claude in
`~/work/` on a Sunday, it injects a reminder asking Claude to surface the brain
entries that gained the most `[[wikilinks]]` this week, plus one orphan entry to
either link or delete.

## Install

Merge the `hooks` block from `settings.json` here into your real
`~/work/.claude/settings.json`. If that file already has hooks, add the
`SessionStart` entry alongside the existing ones rather than overwriting.

## How it works

- `date +%u` returns the day of week, `7` = Sunday. The guard runs the message
  only then; every other day the hook is silent.
- The hook prints a JSON object with a `systemMessage`, which Claude Code surfaces
  at the start of the session. Claude then does the scan of `~/work/brain/` when
  you continue.

## The prompt it stands in for

> *"Add a SessionStart hook in `~/work/.claude/settings.json` that fires only on
> Sundays. When it fires, list three brain entries from this week that gained the
> most new `[[wikilinks]]`, and one entry that hasn't been linked to anything yet
> (so I can either link it or delete it)."*
