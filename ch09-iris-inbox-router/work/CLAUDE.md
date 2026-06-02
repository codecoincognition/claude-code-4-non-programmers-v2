# CLAUDE.md — ~/work

This file holds the portable facts every agent in ~/work reads on launch.
Iris pulls her Notion target IDs from here so her agent file stays portable:
when you move machines or hand the folder to someone else, you change the IDs
in ONE place, not inside every agent.

## Notion targets (used by Iris — Chapter 9)

Replace the placeholders below with your own Notion IDs. To find a Notion
database or page ID, open it in a browser; the long hex string in the URL is
the ID (with or without dashes — both work).

- **Tasks DB ID:** `REPLACE_WITH_YOUR_NOTION_TASKS_DB_ID`
  Columns: Title · Status · Owner · Due · Source
- **Project Notes parent page ID:** `REPLACE_WITH_YOUR_PROJECT_NOTES_PARENT_PAGE_ID`
  Iris appends FYI / commit blocks under the project page that matches the thread.

## Leads DB (used by Iris's launch-funnel extension — "Make it yours" #6)

- **Leads DB ID:** `REPLACE_WITH_YOUR_NOTION_LEADS_DB_ID`
  Written to by the launch landing page (Chapter 19). Iris reads new rows here
  to draft personalized follow-ups.

## Who's who (helps Iris route)

- **Maya** — you. Owner of all tasks Iris files.
- Adjust the routing heuristics in `iris.md` to match your own senders:
  e.g. "messages from my boss tend to be tasks; messages from the agency
  tend to be project notes; messages from old colleagues tend to be replies."
