# Fixtures — external inputs the launch crew touches

The launch crew reads one local file and talks to one or two external
systems through MCP. Nothing private is fabricated here. This note
explains the shape of each external input so you can wire your own.

## 1. The source draft (local — provided)

The producer reads a finished long-form draft from a launch folder:

```
~/work/work-products/2026-05-08-auto-tag-launch/draft.md
```

A real, ready-to-run sample lives at
`work/work-products/2026-05-08-auto-tag-launch/draft.md`. It carries
the headline, the body, and a fact-check notes block (the kind the
newsroom from Chapter 15 leaves behind). Point the producer at your
own draft and the shape is the same: a Markdown file with a headline
and body.

## 2. Buffer MCP (the publishing tail — your account)

The Buffer MCP is the one you installed in Chapter 5. The producer
calls two things on it:

- `buffer.list_channels` — gate-readiness check. Returns the channels
  connected to YOUR Buffer account. Shape (illustrative):

  ```json
  {
    "account": "code-coin-cognition",
    "channels": [
      { "id": "ch_li_001", "service": "linkedin", "name": "Maya Sah",     "connected": true },
      { "id": "ch_x_001",  "service": "twitter",  "name": "@codecoin_cc", "connected": true },
      { "id": "ch_em_001", "service": "email",    "name": "Buffer Reach", "connected": true }
    ]
  }
  ```

- `buffer.create_post` (a.k.a. the queue mutation) — schedules an
  approved artifact for a channel at a time. Returns a Buffer ID:

  ```json
  { "id": "post_4f9a", "channel_id": "ch_li_001", "scheduled_at": "2026-05-09T09:00:00-04:00", "status": "queued" }
  ```

> The hard lesson from "When it goes wrong": a 200 / queued response is
> NOT proof the post went to the channel you intended. Always run
> `buffer.list_channels` first and confirm the channel is connected at
> *package* time, not at scheduling time.

Do not commit your Buffer token. It lives in your MCP config, not here.

## 3. Gmail MCP (the email fallback — your account)

If your Buffer account has no email channel (Buffer Reach is rolled out
unevenly), the producer routes the email artifact through the Gmail MCP
from Chapter 5 instead:

- `mcp__gmail.create_draft` — body + subject + recipients → draft id.
- `mcp__gmail.schedule_send` — draft id + send time → scheduled id.

Everything upstream (the email writer's job) is unchanged; only the
publishing tail differs.

## Verifying the tail

The chapter's reflex: before you trust the queue, read it.

```
list scheduled posts
claude mcp logs buffer
```

The Buffer log on macOS lives at:

```
~/Library/Logs/Claude/mcp-server-buffer.log
```
