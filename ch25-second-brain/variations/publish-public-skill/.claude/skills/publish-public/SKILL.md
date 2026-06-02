---
name: publish-public
description: Publish a sanitized copy of a tagged brain entry to the public website posts folder. Use when an entry in ~/work/brain/ carries the tag `public-ok` and the user wants it turned into a blog post. Strips client names and people identifiers; the brain stays private, only the deliberate subset leaves.
---

# publish-public

Turn a deliberately tagged brain entry into a public blog post — sanitized,
copied, and handed to the Chapter 19 website rebuild.

## When to run

Only when an entry in `~/work/brain/` carries the tag `public-ok`. There is no
auto-publication, ever. The user must have tagged the entry explicitly. If you
are asked to publish an entry that is NOT tagged `public-ok`, stop and say so —
do not publish.

## Steps

1. **Find the source.** Confirm the named entry exists under `~/work/brain/` and
   contains the `public-ok` tag. If it doesn't carry the tag, refuse and explain.
2. **Sanitize a copy in memory.** Produce a public version that:
   - Strips client names and company names (replace with neutral phrasing like
     "a client" or "a mid-market SaaS company").
   - Strips people identifiers (names, emails, handles).
   - Removes the `public-ok` tag itself and any internal-only `[[wikilinks]]`
     that point at private brain entries (a public post must not leak the brain's
     structure).
   - Keeps the substance: the decision, the pattern, the lesson.
3. **Show the user the sanitized version before writing.** List exactly what was
   stripped. Wait for approval.
4. **Write the post** to `~/work/website/posts/{YYYY-MM-DD}-{slug}.md` with a
   minimal front-matter header (title, date, tags).
5. **Hand off.** The Chapter 19 website rebuild hook picks up new files in
   `posts/` automatically — you do not need to deploy. Tell the user it will
   appear on the next rebuild.

## Hard rules

- Never publish an entry without a `public-ok` tag.
- Never auto-publish on a schedule. This skill only runs when invoked.
- When in doubt about whether a string is identifying, strip it and note it for
  the user rather than leaving it in.

## The prompt this skill stands in for

> *"Add a `publish-public` skill: when I tag an entry with `public-ok`, copy a
> sanitized version (strip client names, people identifiers) to
> `~/work/website/posts/`. The Chapter 19 website rebuild hook picks it up
> automatically. The brain stays private; the deliberate subset becomes blog
> posts."*
