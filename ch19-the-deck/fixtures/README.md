# Fixtures — inputs that come from your own apps

Two of the chapter's five input surfaces live inside the reader's
own connected apps, not on disk. We do **not** fabricate private
data for these — instead, here is the exact shape Claude reads, so
you know what it pulls and can verify against your own accounts.

A third surface — the `.pptx` template — is covered in
`../work/templates/README.md`.

---

## 1. Gmail (read via the Gmail MCP from Ch 5)

Claude reads the most recent thread whose subject matches the brief.
In the chapter it is one thread:

```
Subject: Tomorrow's board prep — can you?
From:    (your boss)
Body:
  Investors want a 10-minute walkthrough of where Q3 landed, what's
  coming in Q4, and the two competitive moves we're worried about.
  I've started a Notion page with my rough thoughts. The deck
  template is in the shared drive. Same format as the May board
  deck. Tomorrow 9 AM.
```

A verbatim copy is filed into `../work/board-prep/2026-q3/brief.md`
section 1, so the rest of the session has it as a source of truth
without re-reading the inbox.

### Synthetic sample

See `gmail-sample-thread.md` in this folder for a tiny stand-in you
can paste into a chat if you want to dry-run the flow without a live
Gmail connection.

---

## 2. Notion (read via the Notion MCP)

Claude reads the page linked inside the boss's email — roughly 320
words of rough bullets, in the boss's voice. Claude pulls phrasing
from here so the speaker notes sound like her.

The verbatim bullets are filed into
`../work/board-prep/2026-q3/brief.md` section 2.

### Synthetic sample

See `notion-sample-page.md` in this folder for the bullets as a
stand-in.

---

## How to dry-run without live app connections

1. Open Claude in `../work/`.
2. Paste the contents of `gmail-sample-thread.md` and
   `notion-sample-page.md` when Claude reaches the read step
   (or point Claude at them directly).
3. The on-disk inputs (`finance/`, `strategy/`, `atlas/`,
   `templates/`) are already real files in this repo, so the rest
   of the flow runs unmodified.
