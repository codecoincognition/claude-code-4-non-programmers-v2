# Fixtures — input shapes the monitors read

The watchdog monitors read from your own connected apps and MCPs. We do
NOT ship fabricated private data. This file documents the input *shape*
each monitor expects, plus tiny synthetic samples where they help.

## inbox-monitor — Gmail (Iris's queue, Ch 9)

Reads via the Gmail MCP. Relevant fields per thread:

```jsonc
{
  "thread_id": "18f2c...",
  "from": "customer@example.com",
  "subject": "URGENT: invoice for cancelled plan",
  "labels": ["INBOX", "iris/customer"],
  "unread": true,
  "received_at": "2026-05-08T23:48:00-04:00",
  "message_count_24h": 3        // how many times this sender emailed overnight
}
```

The monitor looks at *rhythm*: unread volume vs. baseline, repeat senders,
bursts of contract-keyword threads. It never reads message bodies for
content — only signals.

## calendar-monitor — Google Calendar

Reads via the Google Calendar MCP. Relevant fields per event:

```jsonc
{
  "id": "evt_9a1...",
  "summary": "Quarterly review w/ Acme",
  "start": "2026-05-09T10:00:00-04:00",
  "end": "2026-05-09T11:00:00-04:00",
  "attendee_response": "accepted",
  "conferencing_joined": false,
  "prep_doc_linked": false
}
```

## deploys-monitor — three (or four) signal sources

### vercel
Output of `vercel ls` (authenticated from Ch 19 Step 0). Sample synthetic
deploy line in `vercel-sample.txt`. States seen: `queued`, `building`,
`ready`, `error`.

### dashboard (nightly cron build log)
A plain log file. See `dashboard-cron-sample.log` for the shape: one line
per nightly run with an exit code.

### buffer
Reads via the Buffer MCP. Relevant fields per scheduled post:

```jsonc
{
  "id": "post_771",
  "text": "Spring pricing is live →",
  "scheduled_at": "2026-05-09T09:00:00-04:00",
  "status": "queued",          // queued | sent | failed
  "last_response_code": 200
}
```

### funnel (optional fourth source)
One Notion query — count rows in the Leads DB where
`Submitted At > now() - 24h` — joined against the launch-fired timestamp
in `~/work/launches/last-fire.log` (the launch crew writes it). See
`../work/launches/last-fire.log` for that file's shape.
