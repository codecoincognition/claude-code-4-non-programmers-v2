---
description: Pin the session's irreducible decisions to a dated decisions.md before running /compact, so the lossy compactor can't discard load-bearing reasoning.
---

# /before-compact

You are about to help me protect the load-bearing reasoning in this session
from the lossy `/compact` summarizer. `/compact` preserves what looks like
*outcome* and discards what looks like *intermediate reasoning* — but sometimes
the intermediate reasoning is exactly the thing I'll need three prompts later.

Do this, in order:

1. Scan everything in this session so far for the irreducible decisions —
   especially any "we figured out that..." moments, non-obvious findings, and
   the *why* behind each fix (not just the *what*). Examples of the kind of
   detail that must survive: "LinkedIn's OAuth endpoint had a redirect loop
   that reset the cookie if the request came from a non-browser User-Agent;
   the fix was a User-Agent header." The summary "fixed LinkedIn OAuth" is NOT
   enough — preserve the why.

2. Write a concise decision summary to
   `~/work/.claude/decisions/{today's date as YYYY-MM-DD}.md`.
   Structure it as:
   - A one-line session title
   - Open files / working directory
   - Current task state (where we are right now)
   - A "Decisions made" list — each entry includes the decision AND the
     reasoning behind it (the why), in enough detail that a fresh context
     could reconstruct it.

3. Tell me the path you wrote, and remind me to pin/reload that file after I
   run `/compact`.

Do NOT run `/compact` yourself. This command only prepares the pin. I run
`/compact` manually once the decisions file looks complete.
