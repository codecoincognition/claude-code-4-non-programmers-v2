---
description: >
  Compose a customer QBR (Quarterly Business Review) deck from a
  one-line brief. Shares the question-and-outline flow with /deck
  but reads customer-specific input surfaces (Slack channel,
  support tickets, usage CSV, customer-tagged Atlas signals).
argument-hint: "<one-line brief, e.g. 'QBR for Acme on Friday'>"
---

# /qbr — customer QBR deck composer

## Inputs to read

1. The customer's dedicated Slack channel.
2. ~/work/customers/{customer}/tickets/ — support ticket folder.
3. ~/work/customers/{customer}/usage-*.csv — usage export.
4. ~/work/atlas/ — most recent weekly signal file, signals
   tagged with the customer name.
5. ~/work/templates/qbr-{customer}.pptx (fall back to
   ~/work/templates/board-deck.pptx if no branded template).

## Flow

1. Read all inputs. Summarize what you found in 6 lines.
2. Ask 3 specific clarifying questions whose answers route the
   work. Do not draft anything yet.
3. After answers, file ~/work/board-prep/{slug}/brief.md.
4. Produce a 10 to 14 slide outline with source pointers and
   speaker notes.
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
