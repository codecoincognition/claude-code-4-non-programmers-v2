# Chapter 10 — Atlas, your watch on the world

Atlas is Maya's second staff member: a **world-watcher** subagent. Where Iris
reacts to what lands in the inbox, Atlas runs on a schedule, goes out and reads
a watchlist of competitor pricing pages, GitHub release feeds, and RSS feeds,
takes a dated *snapshot* of each source, **diffs** tonight against last week,
and writes a one-page *signal file* with anything that moved. On quiet nights he
writes "no signals" and stays out of the way; on genuinely big moves he escalates
via Slack — but only after **two consecutive confirmations**, the rule that kills
false alarms. The pattern installed here is *diff-over-time*: a scheduled snapshot,
a stored memory of last week, and a threshold that separates signal from noise.

## Files in this folder

```
ch10-atlas-world-watcher/
├── README.md                         this file
├── prompts.md                        every prompt from the chapter, in order
└── work/
    ├── .claude/agents/
    │   └── atlas.md                  the Atlas subagent (frontmatter + tools allowlist + body)
    ├── atlas/
    │   ├── sources.md                THE WATCHLIST — Maya edits this; Atlas reads it every run
    │   ├── signals-2026-05-07.md     baseline run (nothing to diff yet)
    │   ├── signals-2026-05-14.md     first real diff (Acme Pro $99 → $87, first confirmation)
    │   ├── signals-2026-05-21.md     a quiet day ("no signals")
    │   └── snapshots/
    │       ├── 2026-05-07/           baseline week — raw extract per source
    │       │   ├── acme-pricing.html        (Pro $99)
    │       │   ├── bolt-pricing.html
    │       │   ├── crate-pricing.html
    │       │   ├── vercel-nextjs-releases.json
    │       │   ├── polars-releases.json
    │       │   ├── playwright-releases.json
    │       │   ├── stratechery-feed.xml
    │       │   ├── latent-space-feed.xml
    │       │   └── crunchbase-funding-feed.xml
    │       └── 2026-05-14/           diff week
    │           ├── acme-pricing.html        (Pro $87 — the 12% cut)
    │           ├── bolt-pricing.html        (unchanged)
    │           └── crate-pricing.html       (unchanged)
    └── scripts/
        ├── show-brief.sh             morning brief; section 3 pulls Atlas's latest signals
        └── fixtures/
            ├── acme-pricing-captcha.html         the bot-block page that faked a "$0" price
            └── signals-2026-05-21-captcha-variant.md   what Atlas writes after the fix
```

`atlas.md` already ships with the **Source-completeness check** written out in
full — in the chapter that block starts as a stub and gets filled in during the
"night Acme went to zero" recovery. The clone-ready copy here is the post-fix
version, which is what you want in production from day one.

## How to use

1. **Drop into place.** Copy `work/.claude/agents/atlas.md` to your own
   `~/work/.claude/agents/atlas.md`, and `work/atlas/sources.md` to
   `~/work/atlas/sources.md`. Edit `sources.md` to your real competitors, repos,
   and feeds — adding a source is one line; removing one is deleting one line.

2. **Run the baseline.** In Claude, from `~/work`: *"Run Atlas now against my
   watchlist."* The first run has nothing to diff, so it writes a baseline signal
   file. The `signals-2026-05-07.md` / `2026-05-14` files here show you the shape
   of a baseline run and the shape of a first real diff.

3. **Schedule it.** *"Schedule Atlas to run every weeknight at 11 PM"* →
   `0 23 * * 1-5`. Keep it on a different cadence from Iris's 7 AM morning run.

4. **Surface signals.** `work/scripts/show-brief.sh` is the Chapter 7/9 morning
   brief with the Atlas section added. It collapses to `all quiet.` on quiet days
   and lists `**bold**` signal lines when something moved. Run it directly to see
   the four-section brief; it never crashes on missing files.

5. **Test the loud-fail path.** Feed `fixtures/acme-pricing-captcha.html` to Atlas
   and confirm he writes a "fetch failed — possible bot block" line (see
   `fixtures/signals-2026-05-21-captcha-variant.md`) instead of a phantom price
   change, and does NOT overwrite the last good snapshot.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 10 walks you through building.
