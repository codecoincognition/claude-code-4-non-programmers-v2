---
description: Cross-system inbox sweep — Gmail, Slack, Notion, classified into 4 buckets
---

# /triage

Cross-system inbox sweep. Read three sources, in this order:

1. Unread Gmail from the last 24 hours.
   - If the Gmail MCP is connected, use it.
   - If not, say so and ask me to paste a digest.

2. Slack DMs and @-mentions from the last 24 hours.
   - If the Slack MCP is connected, use it.
   - If not, say so and ask me to paste a digest.

3. Notion mentions and assigned tasks updated in the last 24h.
   - If the Notion MCP is connected, use it.
   - If not, say so and ask me to paste a digest.

For every thread/message/task, classify into ONE of:
  - **Needs reply** (someone is waiting for me, deadline implied)
  - **Needs action by me** (I owe a thing — not just a reply)
  - **FYI** (good to know, no action)
  - **Safe to ignore** (newsletter, automated, social)

Output: 4 sections, terse. Per item: one-line summary,
who, when (relative to now), the platform.

Do not draft replies. Triage only.
If anything is flagged "needs reply" with a deadline in
< 4 hours, surface it at the top of the output before
the four sections.
