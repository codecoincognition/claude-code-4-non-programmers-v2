---
description: >
  Compose a monthly all-hands deck from a one-line brief. Shares
  the question-and-outline flow with /deck but reads the
  wins-this-month file and the company calendar, and uses a
  warmer, team-facing tone (not investor-facing).
argument-hint: "<one-line brief, e.g. 'all-hands for next Friday'>"
---

# /all-hands — monthly all-hands deck composer

## Inputs to read

1. ~/work/wins/{YYYY-MM}.md — running wins-this-month file.
2. The company calendar (next month's milestones / events).
3. ~/work/strategy/ — open priorities and roadmap.
4. ~/work/templates/all-hands.pptx (fall back to
   ~/work/templates/board-deck.pptx if absent).

## Flow

1. Read all inputs. Summarize what you found in 6 lines.
2. Ask 3 specific clarifying questions whose answers route the
   work (audience tone is one of them). Do not draft yet.
3. After answers, file ~/work/board-prep/{slug}/brief.md.
4. Produce a 10 to 14 slide outline with source pointers and
   speaker notes. Tone: warmer than the board deck — this
   audience is the team, not investors.
5. Wait for outline approval before rendering.
6. Audit chart sign conventions before rendering charts
   (inherited from /deck).
7. Render .pptx via python-pptx against the template.
8. Render charts in matplotlib at 1920x1080, embed as images.
9. File deck.pptx and speaker-notes.md alongside brief.md.

## Chart sign conventions

Inherited from /deck:
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
