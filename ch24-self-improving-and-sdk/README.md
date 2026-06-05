# Chapter 24 — Self-improving and the SDK

This chapter builds the meta layer: a self-improving loop that observes your own usage and proposes automations (with you as the gate), a meta-judge agent that reviews another agent's decisions, and the Agent SDK path that moves scheduled work off your laptop into a CI runner. Devon turns repeated patterns into skills, authors a reviewer for his inbox router Iris, and ports his nightly dashboard build into GitHub Actions so it runs whether or not his laptop is open.

## File-by-file

- `work/.claude/skills/morning-conflict-check.md` — the skill `/insights-to-skills` authored from pattern 1 (after `/triage`, check the calendar for conflicts). Tagged with provenance.
- `work/.claude/agents/meta-judge.md` — the reviewer-for-Iris subagent. Reads Iris's last 24 hours of Notion routing, grades each against three criteria (routing, tone, tag-respect), pings disagreements to Slack. Intended cadence: weekdays 8:30 AM, before `/triage` — wire the schedule via `/schedule` (cloud routine) or a local cron that invokes this agent. Subagent frontmatter has no `schedule:` key; adding one is silently ignored.
- `work/.claude/insights-config.md` — the gate config for `/insights-to-skills`: the gate question, the 60-second default-deny, the per-run cap of 1 skill, and the provenance-tag policy.
- `work/.claude/three-layer.md` — the architecture note mapping all eight of Devon's built jobs to slash / subagent / SDK layers.
- `work/sdk/dashboard-ci/` — the Agent SDK build, wired into CI:
  - `package.json` — declares `@anthropic-ai/claude-agent-sdk`.
  - `build.ts` — the SDK script (one import: `query`; configuration in `options` with `systemPrompt` / `allowedTools` / `permissionMode` / `mcpServers`; iterate the async iterable with `for await`; read the `result` message; exit non-zero on `is_error`).
  - `.github/workflows/build.yml` — GitHub Actions: push-to-main, nightly cron, manual dispatch.
  - `README.md` — env vars / secrets and setup.
- `fixtures/README.md` — input shapes for `/insights` (session history), Iris's Notion output, Slack write surfaces, and the declined Friday-summary skill.
- `fixtures/iris-tasks-sample.json` — three synthetic Notion Tasks DB rows showing what the meta-judge grades against (one clean, one tag-override, one off-tone).
- `prompts.md` — every prompt from the chapter, verbatim and in order.

## How to use

1. Copy `work/.claude/` contents into your own `~/work/.claude/` to get the skill, meta-judge agent, gate config, and architecture note.
2. The meta-judge needs the Notion and Slack MCPs connected; point it at your own Iris setup (Ch 9). Use `fixtures/iris-tasks-sample.json` to understand the grading input.
3. For the SDK build: drop `work/sdk/dashboard-ci/` into a repo, set the three GitHub secrets (`ANTHROPIC_API_KEY`, `VERCEL_TOKEN`, `SLACK_BOT_TOKEN`), `npm ci`, and push. See its own README for details.
4. Run `/insights --last 30d` against your real history; `/insights-to-skills --pattern N` proposes a skill and the gate (from `insights-config.md`) fires before commit.

The declined Friday-summary skill is intentionally **not** shipped as a real file — the chapter's When-it-goes-wrong beat is that the gate prevented it. See `fixtures/README.md` for what it would have looked like.

The book is self-contained — these files are ready-to-clone copies of what Chapter 24 walks you through building.
