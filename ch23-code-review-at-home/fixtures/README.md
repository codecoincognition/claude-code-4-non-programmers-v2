# Fixtures — Chapter 23

The review commands in this chapter (`/simplify`, `/security-review`,
`/sandbox`, `/batch`) and **auto mode** are built into the Claude Code
harness. There is no external private data to ingest. The "inputs" are
just the files in your own `~/work/` tree that you ask Claude to review.

## What the chapter reads

| Input | Shape | Where it comes from |
|---|---|---|
| Files to review | Any shell script, slash command, hook, agent, Python file, config | Your own `~/work/` — authored by you or by Claude in earlier sessions |
| Auto-mode hints | `~/work/.claude/auto-mode-hints.md` | A short Markdown file you author (provided in `work/.claude/`) |
| Review output | `~/work/reviews/{date}/{file}.md` + `review-summary.md` | Written by the review run |

## The three sample files Maya reviews

The repo ships the **post-review** versions of Maya's three Friday files
plus the six refreshers, so a clone runs cleanly:

- `work/dashboard/build.sh` — `/simplify` target (3 fixes applied)
- `work/.claude/commands/cancel-leak.md` — `/security-review` target (HIGH + MED fixed)
- `work/scripts/kill-switch.sh` — `/sandbox` target (2 fixes applied)
- `work/dashboard/refreshers/*` — six `/batch` targets (error-handling pattern applied)

The matching review reports live under `work/reviews/2026-05-08/`.

## /sandbox notes

`/sandbox` mocks the filesystem, network, and credentials. No real Slack
webhook, Stripe key, or `~/work/` path is touched during a sandbox run.
The `SLACK_WEBHOOK_URL`, `STRIPE_API_KEY`, `BUFFER_TOKEN` env vars the
scripts reference are read from your real `~/.env` only on a real run —
never inline. Keep secrets out of the files themselves (this is exactly
the MEDIUM finding the chapter catches).
