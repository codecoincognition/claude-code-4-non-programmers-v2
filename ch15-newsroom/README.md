# Chapter 15 — The newsroom

This chapter builds a **four-agent newsroom**: one parent agent (the
editor) that orchestrates three specialists. The editor dispatches
the **researcher** and the **fact-checker** in parallel, waits for
both, composes a draft from the verified claims and the research
structure, hands the draft to the **headline-writer** (the only
agent that loads the voice file), and files four separate artifacts.
Three primitives land here: **hand-off** (the dispatcher pattern),
**parallel dispatch**, and **voice files shared across agents**
(per-agent, opt-in). The newsroom runs on Friday's real launch — an
auto-tag feature — and the researcher's reach into past campaigns
comes through the `personal-data` MCP you built in Chapter 13.

## Files in this folder

```
ch15-newsroom/
├── README.md                                  ← you are here
├── prompts.md                                 ← every chapter prompt, verbatim, in order
└── work/                                       (maps to ~/work/)
    ├── .claude/
    │   ├── agents/newsroom/
    │   │   ├── editor.md                       orchestrator — the 5-step grammar (load-bearing)
    │   │   ├── researcher.md                   reads past campaigns via personal-data MCP; returns notes
    │   │   ├── fact-checker.md                 verified / unverified / unknown report
    │   │   └── headline-writer.md              loads your-tone; the only prose agent
    │   └── skills/
    │       └── your-tone.md                    voice file (from Ch14) — loaded by headline-writer only
    ├── specs/
    │   └── auto-tag.md                          the feature spec the fact-checker validates against
    ├── personal-data/
    │   └── fixtures/
    │       ├── README.md                        what the Ch13 MCP serves + how to point it here
    │       └── past-campaigns.csv               synthetic archive of past launches
    └── work-products/
        └── 2026-05-08-auto-tag-launch/          one folder per launch (the convention)
            ├── draft.md                         composed announcement (TK on the throughput claim)
            ├── headline.md                      chosen + tightened headline, plus 8 candidates
            ├── research-summary.md              researcher's notes
            └── fact-check.md                    the claim report
```

## How to use

1. **Copy `work/.claude/agents/newsroom/` and `work/.claude/skills/`
   into your `~/work/`** (or wherever you keep your scoped Claude
   Code config). The four agents and the voice file are ready to run.
2. **Wire up the Chapter 13 MCP.** The researcher's allowlist includes
   `mcp__personal_data`. Point your Chapter 13 `personal-data` MCP at
   `work/personal-data/fixtures/past-campaigns.csv` (synthetic) or at
   your own real campaign export. Without the MCP, the researcher has
   no archive to read against.
3. **Run it.** Open Claude in `~/work/` and run the Step 3 prompt
   (see `prompts.md`): a brief plus the spec path
   `~/work/specs/auto-tag.md`. The editor dispatches the room.
4. **Inspect the output.** The four filed artifacts under
   `work-products/2026-05-08-auto-tag-launch/` are example outputs of
   one run — yours will vary (multi-agent runs aren't fully
   deterministic; the research structure is stable, the headlines
   vary).
5. **If headlines come back off-voice**, audit the headline-writer's
   tools allowlist for skills-directory access (`Skills`) — that's
   the chapter's main bug (see the recovery prompt in `prompts.md`).

The book is self-contained — these files are ready-to-clone copies of
what Chapter 15 walks you through building.
