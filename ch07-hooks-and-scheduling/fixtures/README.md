# Fixtures — what the brief scripts read

The Chapter 7 scripts do not read static files for their three sources. They
read **live data from your connected MCPs** (Gmail, Calendar, Notion, Slack,
GitHub). There is nothing to clone for those inputs — and we deliberately do
**not** ship fake mailboxes or calendars, because the whole point is that the
script reaches into *your* real accounts via the MCPs you connected in
Chapter 5.

## What each source looks like (so you know what to expect)

| Source | MCP | What the script asks for |
|---|---|---|
| Unread Gmail | `gmail` | Messages received in the last 12 hours, unread, sender + one-line gist |
| Today's calendar | `calendar` | Events for the current day — time, title, attendees |
| Notion mentions / tasks | `notion` | Pages where you're @-mentioned + tasks assigned to you |
| Slack DMs (eod / week-in-review) | `slack` | Your DMs over the last 8 hours / past week |
| GitHub PRs (pr-review-reminder) | `gh` CLI or `github` MCP | Open PRs awaiting your review > 24h |

## The one input you DO clone

`../work/watchlist.txt` — a plain list of stock tickers, one per line, read by
`stock-watcher.sh`. That one is real sample data because it isn't private and
doesn't come from an MCP. Edit it to your own tickers.

## The one output we ship as a sample

`../work/briefs/2026-05-05.md` — a synthetic example of what a generated
morning brief looks like. This is the *output* of `morning-brief.sh`, included
so `show-brief.sh` and the SessionStart hook have something to display when you
clone the repo before running anything. Delete it once your own briefs start
generating.
