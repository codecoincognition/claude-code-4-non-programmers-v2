# Fixtures — what the three core MCPs feed into the synthesis

The Chapter 5 payoff prompt reads three live sources and writes one file:

> *"Read my unread Gmail from the last 12 hours, my Calendar for today, and my Notion mentions in the last 24 hours. Synthesize the three into a one-page priorities brief at `~/work/inbox/2026-Q4-priorities.md`. Cite each item by source."*

That data comes from **your own accounts** through the Gmail, Calendar, and Notion MCPs. We do **not** ship real mailbox/calendar/Notion data — that would be fabricating private content. Instead, this folder describes the *shape* of each input and gives a tiny synthetic sample so you can:

- understand what each MCP returns before you wire up your real accounts, and
- dry-run the synthesis logic (hand Claude these three samples and ask it to produce the brief) without touching live data.

The finished brief these inputs roll up into lives at `../work/inbox/2026-Q4-priorities.md`.

## Where the real data actually comes from

| Source | MCP | What the synthesis reads | How it's authed |
|--------|-----|--------------------------|-----------------|
| Gmail | `gmail` | Unread threads from the last 12 hours — subject + sender + a one-line gist. | OAuth (browser). Read + draft scopes only; never sends. |
| Calendar | `calendar` | Today's events — time + title. | OAuth (browser). Read + create; no delete. |
| Notion | `notion` | Pages that mention you, updated in the last 24h — title + author + a note on contents. | Integration token (paste). Only pages shared with the "Claude Code" integration are visible. |

None of these come from a file in your repo. The MCP talks directly to each service. The `*-sample.md` files here are illustrations only.

## Dry-run without real accounts

If you want to see the synthesis work before connecting anything:

> *"Treat the three files in `fixtures/` as if they were my Gmail unread, my Calendar today, and my Notion mentions. Synthesize them into a one-page priorities brief, cite each item by its source file, and show me the result."*

Compare what Claude produces to `../work/inbox/2026-Q4-priorities.md`.
