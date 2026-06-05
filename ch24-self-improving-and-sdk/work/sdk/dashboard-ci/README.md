# dashboard-ci — Agent SDK build in GitHub Actions

Moves the nightly dashboard build off Devon's Mac mini and into a CI
runner. The Agent SDK script reads the six refresher scripts, runs
`build.sh` (from Ch 23), deploys via Vercel, and posts the deploy URL
to Slack `#devon-deploys`. On failure it posts the error trace instead.

## Files

- `package.json` — declares `@anthropic-ai/claude-agent-sdk` as a dependency; `npm run build` runs the agent.
- `build.ts` — the Agent SDK script. One import (`query`), one `for await` loop, configuration in `options` (`systemPrompt`, `allowedTools`, `permissionMode`, `mcpServers`). Reads the `result` message at the end of the stream, exits non-zero on `is_error`.
- `.github/workflows/build.yml` — wires the script into GitHub Actions. Runs on every push to `main`, nightly via cron, and on manual dispatch.

## Install

```bash
npm install @anthropic-ai/claude-agent-sdk
```

## SDK shape (what `build.ts` looks like)

```ts
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Run the dashboard build pipeline. Deploy on success.",
  options: {
    systemPrompt: "...",
    allowedTools: ["Bash", "Read", "Write", "mcp__slack"],
    permissionMode: "acceptEdits",
    mcpServers: { /* ... */ },
  },
})) {
  if (message.type === "result" && message.is_error) process.exit(1);
}
```

Notes on the shape:

- `query()` is the whole surface — there is no `new ClaudeAgent(...)` class.
- `query()` returns an **async iterable**; you iterate with `for await`. Each item is one message (system init, tool-use, tool-result, assistant text, and finally a `result` message wrapping the run).
- The option key is `allowedTools` (not `tools`).
- `permissionMode: "acceptEdits"` is the CI posture — no human around to answer an approval prompt.

## Env vars / secrets

Set these as **GitHub Actions repository secrets** (Settings → Secrets and variables → Actions):

| Secret | What it is |
|---|---|
| `ANTHROPIC_API_KEY` | Your Anthropic API key — authenticates the Agent SDK. |
| `VERCEL_TOKEN` | Vercel deploy token (same auth flow as Ch 19 §Step 0). |
| `SLACK_BOT_TOKEN` | Slack bot token so the agent can post to `#devon-deploys`. |

## How to use

1. Drop this folder into a repo (or make it the repo root).
2. Add the three secrets above in your repo settings.
3. `npm ci` locally to verify the install, then push to `main`.
4. Watch the Actions tab: the agent runs the build, deploys via Vercel, and pings Slack with the deploy URL.

Once this is green, you can turn off your Mac mini and the dashboard
still refreshes nightly.

## Notes

- Model selection: the SDK picks a default Claude model; override with `options.model` (use the friendly alias `"sonnet"` or `"opus"` so the setting doesn't rot when minor versions roll).
- The agent expects the refreshers folder and `build.sh` to exist on the runner — clone Ch 23's dashboard artifacts alongside this, or adjust the system prompt paths.
