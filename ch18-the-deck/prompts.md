# Prompts — Chapter 18, The deck your boss asked for

Every prompt from the chapter, verbatim and in order.

---

## Open Claude in your work folder

```
cd ~/work && claude
```

## Step 1 — One prompt that reads everything

> My boss just emailed asking for a board deck for tomorrow 9 AM. Read the email at the top of my Gmail (subject: "Tomorrow's board prep") and the Notion page she linked in it. Read the May 2026 board deck at ~/work/templates/board-deck-may-2026.pptx and the company template at ~/work/templates/board-deck.pptx — extract the slide masters, fonts, and color palette so the new deck matches. Read the Q3 P&L files in ~/work/finance/2026-Q3/ (CSV bank export and Stripe export). Read the roadmap at ~/work/strategy/q4-roadmap.md and the all-hands notes in the same folder. Read this week's Atlas signal file at ~/work/atlas/signals-2026-05-08.md. Then ask me 3 to 5 specific questions before you draft anything.

## Step 2 — Answer in plain English; let Claude file the brief

> Answers: (1) Q3 vs plan, not vs Q2. (2) Pricing gets one slide of its own. (3) The two Atlas-flagged signals are correct — use them. (4) Yes, use the two-column master for competitive moves. (5) Target 12 slides total, including title and thank-you. Also: file all of this — the boss's email, the Notion content, my answers — at ~/work/board-prep/2026-q3/brief.md so we have a source of truth for the rest of the session.

## Step 3 — Outline first; never the .pptx first

> Now produce the outline — 12 slides, one line each, with the slide title, a one-line content summary, and a parenthetical source pointer for any fact or number ("source: bank-export.csv row 412" or "source: Notion bullet 3" or "source: Atlas signal 2026-05-08 #4"). Speaker notes for each slide drafted in my boss's voice — pull her phrasing from the Notion page where you can. Don't render the .pptx yet.

## Step 4 — Catch the wrong slides early

> Two fixes. Slide 7 — re-read this week's Atlas signal file; the CompetitorX entry was updated Wednesday with a corrected raise size. Use the corrected version. Slide 9 — re-read all-hands-2026-05-02.md for the customer-onboarding commitment; the team named a specific date and a named owner. Pull both. Re-present the corrected outline lines (just slides 7 and 9, not the whole thing).

## Step 5 — Now render the .pptx

> Outline looks good. Render the .pptx. Use the company template at ~/work/templates/board-deck.pptx — match the slide masters, fonts (Inter heading, Source Sans 3 body), and the brand colors. File the deck at ~/work/board-prep/2026-q3/deck.pptx. For the charts (slides 2, 3, 4), render them in matplotlib (a Python charting library) at the deck's resolution and embed as images so they look crisp on a projector. Also produce a speaker-notes.md I can read on the way to the meeting — same content as the .pptx speaker notes but in plain markdown so I can scroll on my phone.

## Step 6 — Make it repeatable

> Author a slash command at ~/work/.claude/commands/deck.md that captures this whole flow. Argument is a one-line brief from me ("board deck for tomorrow 9 AM" or "customer QBR for Acme on Friday"). The command should: read the standard inputs (the inbox for any boss-email matching the brief, the relevant Notion pages, ~/work/finance/ for any financial inputs, ~/work/strategy/ for roadmap and all-hands, ~/work/atlas/ for signals, ~/work/templates/ for the .pptx template), ask 3 to 5 clarifying questions, file a brief, produce an outline first, wait for my approval, then render. Show me the command file before saving.

## When it goes wrong — the chart that says the opposite of the speaker note

> Slide 4 chart is inverted. Convention here is actual − plan, so positive bars mean we beat plan. Fix the chart. Then audit every other chart in the deck for the same kind of bug — flag any chart whose sign convention isn't obvious to a board reader, color-coded if needed (green = good, red = bad). Then update ~/work/.claude/commands/deck.md so this doesn't bite us next time.

---

## Make it yours — five (seven) variations on the same flow

### 1. Customer QBR every quarter

> Run the deck flow for next month's customer QBR with Acme. Inputs: their dedicated Slack channel, the support ticket folder at `~/work/customers/acme/tickets/`, the usage CSV at `~/work/customers/acme/usage-2026-q3.csv`, and Atlas signals tagged 'acme'. Use the Acme-branded template at `~/work/templates/qbr-acme.pptx`. Ask me 3 questions before drafting; outline first.

### 2. Monthly board update

> Compose the monthly board update — same flow as the quarterly but slimmer. 5 slides total: traffic, revenue, one bet we're prioritizing this month, one risk, and the ask. Inputs: most recent monthly P&L from Reuben (Ch 11), the strategy folder, and Atlas. Use the board-update template, not the full board-deck template.

### 3. Internal all-hands deck

> All-hands deck for next Friday. Different audience: the team, not investors. Inputs: my running 'wins-this-month' file at `~/work/wins/2026-05.md`, the all-hands template, and the open priorities I left in the strategy folder. Tone: warmer than the board deck. Ask me 3 questions before drafting; outline first.

### 4. Conference talk skeleton

> Skeleton a 25-minute conference talk on the topic 'AI operators for non-programmers'. Inputs: my published Substack posts at `~/work/writing/substack/`, my talk-history file at `~/work/talks/`, my book draft at `~/work/book/`. Use the conference-deck template. 18 to 22 slides. Outline first; ask me about audience level (beginners / intermediate / mixed) before drafting.

### 5. Convert any deck to a Notion page

> Take ~/work/board-prep/2026-q3/outline.md and render it as a Notion page in the 'Board Prep' database, one block per slide, with the speaker notes as toggle blocks underneath. Some readers want to read instead of view; this is for them.

### 6. Run the chart-convention audit before any render

> Add a step to /deck: before rendering any chart, run a chart-convention audit that flags every chart's sign convention and asks me to confirm. Output should be a small table — one row per chart, columns: chart title, x-axis, y-axis, sign convention (e.g., 'positive bar = above plan'), color coding. I review and confirm; THEN render.

### 7. Author parallel commands for QBR and all-hands

> Author a /qbr slash command (customer QBR) and an /all-hands command (monthly all-hands deck) that share the question-and-outline flow but differ in input surfaces. /qbr reads the customer Slack channel and tickets; /all-hands reads the wins-this-month file and the company calendar. Both inherit the chart-convention audit from /deck.

---

## Test yourself in 60 seconds

1. > Read ~/work/board-prep/2026-q3/outline.md and tell me which slide has a source pointer I should double-check.
2. > Run my deck command on next quarter's inputs. I want a 12-slide outline plus speaker notes.
3. > Open ~/work/.claude/commands/deck.md and confirm the chart-convention audit from the When-it-goes-wrong scenario is baked in.

Stuck?

> audit my Chapter 18 setup against the chapter spec
