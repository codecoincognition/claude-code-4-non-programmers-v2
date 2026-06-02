// Agent SDK — dashboard CI build
//
// Runs in GitHub Actions. No human at the terminal. The agent
// reads refresher scripts, runs the build, deploys, pings Slack.
//
// Five things the chapter calls out about this script:
//   1. Import the SDK client      (one line — a regular dependency)
//   2. Configure the agent        (system prompt, tools, model)
//   3. Run with a prompt          (one-line prompt; agent dispatches)
//   4. Read the structured output (exit codes, findings, traces)
//   5. Side effect                (exit code + the Slack ping the agent sends)

import { ClaudeAgent } from "@anthropic-ai/claude-code";

const agent = new ClaudeAgent({
  model: "claude-sonnet-4-7",
  systemPrompt: `
    You are a build agent. You run in CI. Your job is to:
    1. Run the six refreshers in ~/work/dashboard/refreshers/
    2. Run build.sh; verify exit code 0
    3. Deploy via vercel CLI
    4. On success, post deploy URL to #devon-deploys via Slack MCP
    5. On failure, post the error trace to #devon-deploys

    No interactive prompts. No human approval steps. Fail loudly.
  `,
  tools: ["Bash", "Read", "mcp__slack"],
});

const result = await agent.run({
  prompt: "Run the dashboard build pipeline. Deploy on success.",
});

if (result.exitCode !== 0) {
  process.exit(result.exitCode);
}
