# Fixtures — inputs you supply yourself

The Chapter 14 skill is built from *your* writing, not ours. The core step (`voice-samples/`)
already ships three synthetic samples so the chapter runs end to end — but the real value
comes from replacing them with your own. The "Make it yours" follow-ups point Claude at a few
more folders you'd populate yourself. None of these contain private data; here's the shape of
each so you can drop your own files in.

## `~/work/voice-samples/` (Step 1 — required)

Three plain-text or Markdown files, one per writing surface:

- One **email** (~200–400 words)
- One **short post** (LinkedIn, X, internal announcement; ~100–250 words)
- One **longer piece** (a brief, memo, or essay; ~600–1,000 words)

Anonymize names if you like. More variety = sharper voice extraction. We ship three
synthetic samples in `../voice-samples/`; swap them for real ones.

## `~/work/code-review-samples/` (Make it yours #1)

Three of your past code-review comments, each saved as its own `.md` file. Plain prose is
fine — paste the comment text. Example shape of one file:

```
Nice catch on the null guard. One structural question: this loop
re-reads the config on every iteration — could we hoist it out?
Two small things if you've got a minute: rename `tmp` to `parsed`,
and the error message swallows the original cause.
```

## `~/work/refs/house-style.pdf` (Make it yours #2)

Your company's house style guide as a PDF. Claude reads it directly — you don't paste it.
Any length; the chapter example assumes ~4 pages. (Not included here — supply your own.)

## `~/work/launches/` (Make it yours #3 and #4)

A folder of launch drafts Claude produced for you, used to audit the skill against your real
voice (#3) and as the scope for a folder-scoped launch-voice skill (#4). Populate it as you
ship launch material; no fixture needed up front.
