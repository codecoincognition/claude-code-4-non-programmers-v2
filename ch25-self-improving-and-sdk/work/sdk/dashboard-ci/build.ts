// Agent SDK — dashboard CI build
//
// Runs in GitHub Actions. No human at the terminal. The agent
// reads refresher scripts, runs the build, deploys, pings Slack.
//
// Five things the chapter calls out about this script:
//   1. One import: `query` from @anthropic-ai/claude-agent-sdk.
//      There is no `new ClaudeAgent(...)` class — `query()` is the
//      whole surface.
//   2. `query()` returns an async iterable; iterate with `for await`.
//      Each item is one message (system init, tool-use, tool-result,
//      assistant text, and finally a `result` message wrapping the run).
//   3. Configuration goes in `options`: `systemPrompt`, `allowedTools`
//      (note the name — NOT `tools`), `permissionMode`, `mcpServers`.
//   4. `permissionMode: "acceptEdits"` is the CI posture — no human
//      around to answer an approval prompt.
//   5. The script's side effect is the process exit code. The Slack
//      ping is a side effect of the agent's own tool calls.

import { query } from "@anthropic-ai/claude-agent-sdk";

const systemPrompt = `
  You are a build agent. You run in CI. Your job is to:
  1. Run the six refreshers in ./dashboard/refreshers/
  2. Run build.sh; verify exit code 0
  3. Deploy via the vercel CLI
  4. On success, post the deploy URL to #devon-deploys via Slack MCP
  5. On failure, post the error trace to #devon-deploys

  No interactive prompts. No human approval steps. Fail loudly.
`;

let lastResult: { is_error?: boolean; result?: string } | null = null;

for await (const message of query({
  prompt: "Run the dashboard build pipeline. Deploy on success.",
  options: {
    systemPrompt,
    allowedTools: ["Bash", "Read", "Write", "mcp__slack"],
    permissionMode: "acceptEdits",
    mcpServers: {
      slack: {
        command: "npx",
        args: ["-y", "@modelcontextprotocol/server-slack"],
      },
    },
  },
})) {
  // Stream every message to the CI log so the GitHub Actions run page
  // shows the agent's reasoning and tool calls in real time.
  console.log(JSON.stringify(message));
  if (message.type === "result") lastResult = message;
}

// In CI the side effect is the process exit code plus the Slack ping
// the agent itself sent. Anything non-success fails the workflow.
if (!lastResult || lastResult.is_error) {
  process.exit(1);
}
