---
description: >
  Compose a slide deck from a one-line brief. Reads boss email,
  Notion, finance, strategy, Atlas, and the company template.
  Asks clarifying questions. Outline before render. Audits
  chart conventions before final render.
argument-hint: "<one-line brief>"
---

# /deck — multi-source deck composer

## Inputs to read

1. Gmail: most recent thread matching the brief subject.
2. Notion: any pages linked from that thread.
3. ~/work/finance/ — most recent quarter's CSVs.
4. ~/work/strategy/ — q*-roadmap.md and all-hands-*.md.
5. ~/work/atlas/ — most recent weekly signal file.
6. ~/work/templates/board-deck.pptx — slide masters, fonts,
   color palette.

## Flow

1. Read all six inputs. Summarize what you found in 6 lines.
2. Ask 3 to 5 specific clarifying questions whose answers
   route the work. Do not draft anything yet.
3. After answers, file ~/work/board-prep/{slug}/brief.md.
4. Produce a 10 to 14 slide outline with source pointers
   and speaker notes in the boss's voice.
5. Wait for outline approval before rendering.
6. Audit chart sign conventions before rendering charts:
   revenue/customers/usage — positive bar = above plan.
   churn/cost/incident-rate — positive bar = below plan.
   When in doubt, ask.
7. Render .pptx via python-pptx against the template.
8. Render charts in matplotlib at 1920x1080, embed as
   images.
9. File deck.pptx and speaker-notes.md alongside brief.md.

## Chart sign conventions

- revenue/customers/usage: positive bar = above plan.
- churn/cost/incident-rate: positive bar = below plan.
- When in doubt, color-code (green = good, red = bad)
  and ask the user before rendering.

## Output

- {slug}/brief.md
- {slug}/outline.md
- {slug}/deck.pptx
- {slug}/speaker-notes.md

The outline gate is mandatory. Never render the .pptx
without explicit "approve outline" from the user.
