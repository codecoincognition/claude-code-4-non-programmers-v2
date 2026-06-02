# Chapter 16 — The launch crew · every prompt, verbatim and in order

## Conducting the launch

### Step 1 — Author the launch crew under .claude/agents/launch-crew/

> Author my launch crew under .claude/agents/launch-crew/ — five files: producer (the orchestrator), and four channel writers — linkedin-writer, x-writer, one-pager-writer, email-writer. Each writer extends your-tone.md from Ch 14 with a small per-channel sub-rule pack. The producer dispatches all four in parallel, composes a launch package, and on my approval ships the approved channels via the Buffer MCP. Show me the producer file in full and the four writer files summarized.

### Step 2 — Compare LinkedIn writer and X writer side by side

> Show me the channel-rules section of the LinkedIn writer side-by-side with the X writer. I want to see what's shared (the your-tone skill) and what's specialized (the per-channel rules).

### Step 3 — Run the launch crew on yesterday's auto-tag draft

> Run the launch crew on yesterday's auto-tag draft at ~/work/work-products/2026-05-08-auto-tag-launch/draft.md. Tell me where the launch package will land.

### Step 4 — Read the launch package back

> Read the launch package back to me — show me the four artifacts in order. I want to see whether each one sounds right for its channel.

### Step 5 — Approve three channels and schedule via Buffer

> Approve LinkedIn, X, and email. The one-pager I want to tweak myself — leave it as a file. Schedule the LinkedIn post for tomorrow 9 AM Eastern, the X post for tomorrow 11 AM, and the email for tomorrow 2 PM.

#### Gmail fallback (callout)

> For email, route through the Gmail MCP with scheduled-send instead of Buffer.

### Step 6 — Audit voice across the four writers as a design decision

> Pull up your-tone.md and the four writer files. Walk me through where the brand voice is consistent and where it's deliberately specialized. I want to see this as a design decision, not an accident.

### Step 7 — Look ahead to the watchdog mesh

> Tell me how the watchdog mesh in Chapter 17 will differ from the launch crew. Both have a parent orchestrating workers, but they're solving different shapes of problem.

## When it goes wrong — the postmortem prompt

> The email never sent yesterday — Buffer says the email channel isn't connected. First: tell me what Buffer's account actually has connected (use claude mcp logs buffer if you need to). Second: rewrite the producer's Buffer-dispatch logic so it verifies channel availability before reporting success, and so it surfaces a per-channel readiness check at launch-package time, not at scheduling time.

## The lift — distilled prompt grammar

> "For each channel I publish to, author one writing agent that loads `{voice file}` and adds {channel-name} specific rules: {3-5 channel rules}. The orchestrator dispatches all of them in parallel and composes a launch package."

## Make it yours — five variations

### 1. Add an Instagram writer

> Add an Instagram writer to the launch crew. Channel rules: one-line hook, 3-5 hashtags at the end, image prompt as a separate field for the image-prompter from Ch 15's Make-it-yours.

### 2. Tighten LinkedIn from real engagement data

> My LinkedIn posts are getting 4x the engagement of my X posts — let's update the LinkedIn writer's channel rules to capture what's working. Read my last 10 LinkedIn posts (via Buffer's history) and propose 3 new rules.

### 3. Convert from on-demand to scheduled

> Convert the launch crew from on-demand to scheduled — every Monday morning, dispatch the producer on whatever's in `~/work/launches/incoming/` and queue the week's posts. Use the scheduling primitive from Ch 7.

### 4. Audit the channel-rules layers for drift

> Audit the four channel-rules layers — are any of them so heavy they've drifted from `your-tone`? For each writer, tell me what percentage of the body voice still comes from the shared skill vs. the layer.

### 5. Add a Slack pre-publish gate

> Buffer is queueing my posts but I want one more gate before publish — a Slack message to me with the draft and a thumbs-up/thumbs-down. Add that gate to the producer using the Slack MCP from Ch 5.

## Test yourself in 60 seconds

1. > Run the producer on the auto-tag draft. Land one artifact per channel in ~/work/launches/{date}-auto-tag/.
2. > Tell me which channels in my launch crew are Buffer-gate-ready and which fall back to Gmail.
3. > Read all four channel writers and confirm each one loads ~/work/.claude/skills/your-tone.md.

### Stuck?

> audit my Chapter 16 setup against the chapter spec
