# Fixtures — Iris's inputs come from your own connected apps

Iris does not read fabricated data. Her inputs are live, and they come from
MCP servers you connected in Chapter 5:

- **Gmail** — `mcp__gmail__search`, `mcp__gmail__read_thread`. The last 12 hours
  of your real inbox (unread + recently-read threads).
- **Google Calendar** — `mcp__calendar__list_events`. Today's events, so Iris
  understands what you have on when she sets task due dates and priority.
- **Notion** — `mcp__notion__create_page` (Tasks DB rows),
  `mcp__notion__append_block` (Project Notes pages). The IDs live in
  `../work/CLAUDE.md`.

There is nothing to seed here. When you run Iris against your own account, she
reads your real threads. The synthetic examples in the chapter (David W., Karim,
Susan/Bluefin, the Q3 Launch project) are illustrations of the *shape* of her
output, not data you import.

## Input shapes (what Iris reads)

### A Gmail thread (as Iris sees it)
```
thread_id:  <opaque id>
subject:    "Q4 budget question"
from:       "David W. <david@example.com>"
date:       2026-05-13T08:14:00
permalink:  https://mail.google.com/mail/u/0/#inbox/<thread_id>
snippet:    "What number should I bring to the 11 AM 1:1 — the Q4 figure..."
messages:   [ ... full bodies via read_thread ... ]
```

### A calendar event (as Iris sees it)
```
summary:  "1:1 with David W."
start:    2026-05-13T11:00:00
end:      2026-05-13T11:30:00
```

### A Notion Tasks DB row (what Iris writes)
```
Title:   "Q4 budget question"
Status:  Open
Owner:   Maya
Due:     2026-05-13
Source:  https://mail.google.com/mail/u/0/#inbox/<thread_id>
```

## Sample output Iris produces

See `../work/queue/2026-05-13.md` for a full sample queue file — the daily
aggregate of every routing call, draft, and archive with reasons. That file is
the surface Maya reviews each morning.
