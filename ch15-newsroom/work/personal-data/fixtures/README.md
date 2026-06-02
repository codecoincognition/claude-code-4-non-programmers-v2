# personal-data fixtures — what the researcher reads

The researcher agent does not read these files directly. It queries
the **`personal-data` MCP you built in Chapter 13**, which serves the
same data through a tool the researcher's allowlist permits
(`mcp__personal_data`). The Chapter 13 MCP is the load-bearing wrench
of this chapter — without it, the researcher has no archive to read
against and the draft has no past-launch grounding.

This folder gives you a tiny **synthetic** sample so the newsroom can
be run end-to-end without your real three years of campaign briefs.
None of this is private data — it's invented to show the *shape* the
MCP returns.

## Input shape

The Chapter 13 MCP exposes (at minimum) a tool the researcher calls:

- `summarize_records` / a search over past campaigns — returns the N
  most-similar past launches given a brief, each with: a slug, a
  launch date, the product family, the headline that shipped, the
  key performance number (CTR / opens / replies), and a short
  post-mortem of what landed and what didn't.

The researcher asks for the 3 most-similar launches, reads their
post-mortems, and returns a structural recommendation.

## Files here

- `past-campaigns.csv` — the synthetic archive the Chapter 13 MCP
  serves. Each row is one past launch. Point your Chapter 13 MCP at
  this file (or your own real CSV) to run the newsroom.

## Using your real data

In the book, this CSV is three years of real campaign briefs and
post-mortems. Swap `past-campaigns.csv` for your own export and the
researcher's recommendations get correspondingly better. The
newsroom's research depth is exactly the depth of your custom MCP.
