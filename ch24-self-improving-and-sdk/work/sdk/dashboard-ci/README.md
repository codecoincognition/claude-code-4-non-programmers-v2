# dashboard-ci — Agent SDK build in GitHub Actions

Moves the nightly dashboard build off Devon's Mac mini and into a CI
runner. The Agent SDK script reads the six refresher scripts, runs
`build.sh` (from Ch 23), deploys via Vercel, and posts the deploy URL
to Slack `#devon-deploys`. On failure it posts the error trace instead.

## Files

- `package.json` — declares `@anthropic-ai/claude-code` as a dependency, `npm run build` runs the agent.
- `build.ts` — the Agent SDK script. Imports the client, configures the agent (system prompt, tools, model), runs with a one-line prompt, reads the structured result, exits with the agent's exit code.
- `.github/workflows/build.yml` — wires the script into GitHub Actions. Runs on every push to `main`, nightly via cron, and on manual dispatch.

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

- `claude-sonnet-4-7` is the model named in the chapter. Swap to whatever model is current when you clone.
- The agent expects `~/work/dashboard/refreshers/` and `build.sh` to exist on the runner — clone Ch 23's dashboard artifacts alongside this, or adjust the system prompt paths.
