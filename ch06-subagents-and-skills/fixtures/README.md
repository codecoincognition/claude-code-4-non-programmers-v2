# Fixtures — sample inputs for the Chapter 6 subagents

The Chapter 6 subagents read inputs that, in real use, come from your own
accounts and files. We do not ship anyone's real Gmail or real meetings.
Instead, here is what each input looks like, plus one tiny synthetic
sample you can run against.

## `inbox-digest` subagent — reads your Gmail

The `inbox-digest` subagent (in `work/.claude/agents/inbox-digest.md`)
reads the last 24 hours of **your** Gmail through the Gmail MCP you
connected in Chapter 5. There is nothing to copy here — once the Gmail
MCP is connected, the subagent pulls live threads. Each thread it sees
looks roughly like:

```
From:    Dana Okafor <dana@northwind.example>
Subject: Q3 reconciliation — one more file
Date:    Wed, 2026-06-01 07:12
Snippet: Hey — forgot the May Stripe export, attaching now. Can you
         fold it into the reconciliation before our 2pm? Thanks!
```

The subagent classifies each such thread as **action / FYI / noise** and
writes the digest to `~/work/inbox/digest-{date}.md`. It never sends,
drafts, labels, or deletes mail.

## `meeting-notes-summarizer` subagent — reads a transcript file

This one reads a plain-text transcript file you point it at. A real
transcript is whatever your meeting tool (Granola, Zoom, Otter, etc.)
exports. A synthetic sample you can run against ships at
`sample-meeting-transcript.txt` in this folder — copy it somewhere under
`~/work/` and run:

> "Use the meeting-notes-summarizer subagent on
> ~/work/sample-meeting-transcript.txt"

You should get back 5 summary bullets + 3 action items, and the full
transcript should never enter your main conversation.
