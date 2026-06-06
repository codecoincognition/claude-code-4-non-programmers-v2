# ENGINEER-GUIDE — the architecture under *Claude Code for Non-Programmers (2nd Edition)*

> *For readers who finished the book and want the view from the engine room.*
>
> The 26 chapters are written for operators: a small-business owner, a
> consultant, a Maya. They teach by building. This guide is written for the
> reader who closed the book and asked "how does this actually compose?" If you
> are coming from the chapter side, none of what follows is *required* — the
> chapters remain the canonical tutorial. This is the consolidated architecture
> view, written for people who plan to extend, contribute, or fork.

## What Claude Code is, in one paragraph

Claude Code is a terminal-resident agent runtime built on Anthropic's models.
At its core sits a single conversation loop: a user-typed prompt becomes
context, the model returns a response that may include tool calls, tool calls
execute against your filesystem and external services, results flow back into
context, and the loop runs until the model is done or asks for input. Five
extension layers ride on top of that loop — the **Agent SDK**, **MCP
servers**, **subagents**, **slash commands**, and **hooks**. Plus two
cross-cutting facilities (**skills** and **settings.json**) that shape how the
core loop behaves. The book introduces these one at a time across 26 chapters;
this guide describes them as a single system and points you at where the
chapters cover each.

---

## The five layers, named

### 1. The Anthropic Agent SDK (Chapter 24)

The SDK is the lowest layer the book exposes — the same engine that powers the
interactive `claude` CLI, repackaged as a Python/TypeScript library you call
programmatically. You import it, you give it a prompt, you give it a tool
allowlist, you let it run. The runtime spins up the same conversation loop the
CLI uses, but headless: no terminal, no human-in-the-loop, just programmatic
input and structured output. The SDK is how scheduled work moves from "a hook
running a CLI session" to "a real process running in CI" — the chapter's
example is a GitHub Action that runs the Chapter 21 dashboard build agent
unattended.

The SDK also exposes the permission system, the hook system, the MCP system,
and the subagent system as configurable parts of the runtime — so anything you
can do in an interactive session you can do from code. This is the layer where
"Claude Code is a CLI" gives way to "Claude Code is an SDK that *also* ships a
CLI." Most readers don't need it. The few who do — engineers building products
on top of Claude Code, teams putting agent workflows into CI — start from
Chapter 24.

**Where the book covers it:** Chapter 24 (*Self-improving and the SDK*) is the
introduction. Appendix G points outward to the SDK reference docs for the full
API surface.

### 2. MCP servers (Chapters 5, 13)

The Model Context Protocol is Anthropic's open-source spec for exposing tools
and data sources to an LLM. An MCP server is a process — typically Node, Python,
or a binary — that speaks the protocol over stdio or HTTP. It declares a set of
tools (functions the model can call) and a set of resources (data the model can
read). Claude Code reads `~/.claude.json` (registry) and the `mcpServers` block
of `settings.json` to know which servers to start; it launches them as child
processes at session boot and routes tool calls to the right one.

The book introduces MCP twice. Chapter 5 is the *consumer* view: install five
existing servers (Gmail, Calendar, Notion, Slack, Buffer) by prompting Claude
to add them to `settings.json`. Chapter 13 is the *producer* view: write your
own MCP server in TypeScript, register it locally, and call your custom tools
from any session. The protocol itself is small — the spec fits on a page —
and the ecosystem of existing servers is large enough that most operators never
need to write one. The chapter still shows how, because writing one demystifies
the whole layer.

**Where the book covers it:** Chapter 5 (install existing MCPs), Chapter 13
(write your own). Appendix D is a wishlist of MCP servers worth building.

### 3. Subagents (Chapters 6, 9-12, 15-17)

A subagent is a separate Claude conversation, started by the main session, with
its own system prompt, its own tool allowlist, and its own context window. From
the main session's point of view, calling a subagent looks like calling a tool:
you describe the task, the subagent runs, it returns a structured result, the
main session integrates the result into its own response. The subagent is
defined by a Markdown file in `.claude/agents/{name}.md` (project-local) or
`~/.claude/agents/{name}.md` (user-global) — discovery is automatic from those
fixed paths and any sub-directories within them. The file's YAML frontmatter
declares the agent's name, description, tool allowlist, and optional model
override; the body is the system prompt.

Subagents matter for three reasons. **Context isolation:** the parent
conversation isn't polluted by the subagent's intermediate work — you only see
the final return. **Specialization:** different agents can have different tool
allowlists and different system prompts, so an inbox-router agent is genuinely
read-only on Gmail while a draft-writer can write drafts but not send. **Cost
and concurrency:** subagents can run in parallel and on smaller models when
appropriate, so a four-agent newsroom (Chapter 15) costs less than a single
giant prompt asking one model to do all four jobs.

The book introduces subagents in Chapter 6 (one minimal agent), then spends
Chapters 9-12 building Maya's named staff (Iris, Atlas, Reuben, Echo — one
specialist per chapter), then Chapters 15-17 build *teams* of subagents under a
parent orchestrator (the newsroom, the launch crew, the watchdog mesh).

**Where the book covers it:** Chapter 6 introduces subagents. Chapters 9-12
build the four named specialists. Chapters 15-17 build three multi-agent teams.

### 4. Slash commands (Chapters 4, 18, 20-23)

A slash command is a Markdown file in `.claude/commands/{name}.md` that the
user invokes by typing `/{name}` at the prompt. The file has YAML frontmatter
(name, description, optional argument hints) and a body that becomes the prompt
sent to Claude. Slash commands are the cheapest extension layer — no code, no
config, just a Markdown file — and they are the right shape for any
*repeated* prompt the user types more than three times. The book introduces
them in Chapter 4 as the first extension primitive the reader builds.

Slash commands compose with the other layers. The body of a command can
reference subagents (the command becomes a one-line invocation of a complex
agent), can require MCP tools (the command's prompt assumes Gmail or Notion is
available), and can be triggered by hooks (the SessionStart hook can pre-run
a `/morning-brief` command). Most user-facing automation in the book is shaped
as a slash command that calls subagents that use MCP tools.

**Where the book covers it:** Chapter 4 introduces the primitive. Chapters 18,
20, 21, 22, 23 each ship slash commands (deck, cancel-leak, dashboard-refresh,
triage-session, review-mine, etc.) as part of larger workflows.

### 5. Hooks (Chapters 7, 8, 11, 17, 19)

A hook is a shell command that Claude Code runs in response to a lifecycle
event: `SessionStart`, `SessionEnd`, `PreToolUse`, `PostToolUse`, `Stop`,
`SubagentStop`, `UserPromptSubmit`, `Notification`, and a handful of others.
Hooks are configured in the `hooks` block of `settings.json`. Each event type
can have multiple hooks; each hook can be scoped by a matcher (only fire for
`Bash` tool calls, only for specific MCP tools, etc.). The hook script receives
the event payload as JSON on **stdin** — read it with `jq` or a `python3 -c`
one-liner; environment variables are NOT how the payload is delivered, despite
what shell intuition suggests. The script can do anything a shell script can
do — log, audit, gate, notify, refuse. The exit code is the gate signal: only
`exit 2` blocks the action for most events (other non-zero codes log stderr
but don't block); `exit 0` continues; `WorktreeCreate` is the documented
exception where any non-zero fails creation.

Hooks are how the book moves Claude from "an interactive tool you sit in front
of" to "infrastructure that runs whether you're at the keyboard or not." The
`SessionStart` hook reads the morning brief the moment you type `claude`. The
`PreToolUse` audit hook appends every Bash invocation to a log so you can
reconstruct what an agent did three months later. The `Stop` hook pings Slack
when a long task finishes. The `SessionEnd` hook triggers the bookkeeper. The
hook layer makes the staff feel always-on.

A failure mode worth knowing about: hooks run on the user's machine with the
user's permissions and do not go through the model's safety pipeline. A
malicious or buggy hook is the user's responsibility. The book treats this
with the same discipline as the permission system — read the script, pin its
location, audit it on the Sunday governance hour.

**Where the book covers it:** Chapter 7 introduces hooks and scheduling.
Chapter 8 frames the safety side (deny lists, audit log). Chapters 11, 17, 19,
25 each add lifecycle-driven hooks for specific workflows.

### Cross-cutting layer A — Skills (Chapter 14)

A skill is a Markdown file Claude loads automatically into context when the
skill's description matches the current task. The canonical layout is a
directory at `.claude/skills/{name}/` containing a `SKILL.md` (so the skill
can ship supporting files alongside it); a flat `.claude/skills/{name}.md`
also works for single-file skills with no extra assets. Skills are how you teach Claude *style* and *standing rules* without
shouting them in every prompt — your writing voice, your debugging conventions,
your code-review checklist. Like subagents, skills are discovered from fixed
paths (`~/.claude/skills/` and `.claude/skills/` and their sub-directories).
Unlike subagents, they don't run as separate processes; they're context the
main loop picks up when the description triggers.

**Where the book covers it:** Chapter 14 (*Your first custom skill*) is the
introduction. Skills then quietly compose with most later chapters — the
`your-tone` skill from Ch 14 is loaded into every newsroom (Ch 15) and launch
crew (Ch 16) write.

### Cross-cutting layer B — `settings.json` (Appendix F)

`~/.claude/settings.json` is the configuration file that ties the other layers
together. It declares MCP servers (which servers to start), permissions (which
tool calls are auto-allowed, which require asking, which are denied outright),
hooks (which scripts run on which events), the API key helper (a script that
prints your API key from a secret store), default model, output style, status
line, and environment variables. Project-local overrides live at
`.claude/settings.json` and `.claude/settings.local.json`.

Appendix F walks every meaningful key in one operator's settings file and
explains the *regret* behind each — the experience that put the key there.
Appendix F also ships its `settings.json` in this companion repo at
[`appendix-f-settings/`](./appendix-f-settings/).

---

## The three-layer architecture (Chapter 24)

Chapter 24 names something the earlier chapters quietly built: *most operator
work fits one of three shapes*, and the right shape depends on how often the
work runs, who triggers it, and how much context it needs.

**Layer 1 — Slash commands.** The right shape when a human triggers the work
interactively, the work fits in one conversation, and the prompt is something
you'd type more than three times. Cheap. No new process. No new context window.
Examples in the book: `/triage` (Ch 4), `/dashboard-refresh` (Ch 21),
`/review-mine` (Ch 23). If the work is *"I want to type one short command and
get a useful result,"* it is probably a slash command.

**Layer 2 — Subagents.** The right shape when the work is genuinely a different
*job* with a different tool allowlist, when the parent conversation shouldn't
see the intermediate noise, or when multiple jobs run in parallel under one
parent. Slightly more expensive — new process, new context window — but the
isolation is worth it. Examples: Iris reads Gmail and never sends (different
tool allowlist), the newsroom (four specialists in parallel), the watchdog mesh
(an orchestrator dispatching to monitors on a schedule). If the work needs
*"someone else to handle this part with their own rules,"* it is probably a
subagent.

**Layer 3 — Agent SDK.** The right shape when the work has to run with no human
in the loop, on a real schedule, in a real production environment — typically
CI. The SDK is the way to take the same prompt-driven Claude logic and run it
as a long-lived service instead of a terminal session. Examples in the book:
the dashboard build moved into GitHub Actions (Ch 24). If the work needs *"no
terminal, no human, the same Claude logic anyway,"* it is probably an SDK
deployment.

The three layers compose. A slash command can dispatch to subagents. A
subagent can be invoked by the SDK. The SDK runs in CI but reuses the same
agent definitions and skills the interactive CLI loads. The discipline Chapter
24 teaches is to pick the lowest layer that fits — slash command before
subagent, subagent before SDK — and only escalate when the current layer
runs out of room. The wrong direction (jumping to the SDK for work that fits a
slash command) is over-engineering.

---

## Permission modes and plan mode

Two runtime behaviors are worth flagging for engineers because they shape what
the agent is allowed to do at any given moment.

**Permission modes.** Every tool call is evaluated against the
`permissions.deny`, `permissions.ask`, and `permissions.allow` lists in
`settings.json` (with `deny` taking precedence over `ask` taking precedence
over `allow`). Pattern syntax is glob-ish for paths and prefix-ish for tool
names (`Bash(rm -rf *)`, `mcp__gmail__send_*`, `Read(~/work/**)`). The book's
Chapter 0.3 establishes the three baseline deny rules every reader installs on
day one; Chapter 8 builds the deny/ask/allow shape readers carry through every
later chapter. The pattern syntax is documented; the discipline of *what
belongs in each list* is the harder problem and the one the book invests in.

Beyond the static lists, Claude Code supports modal permission grants for the
duration of a session (the user can elevate permissions for a single call, a
single tool, or the whole session). The interactive prompt that appears when
Claude wants to use a tool not on the `allow` list — *"allow this once / always
/ never"* — writes to `settings.local.json` for the *always* case so the
choice persists.

**Plan mode.** A modal state Claude Code enters manually (the user prefixes
a prompt with `/plan` or cycles into plan mode via Shift+Tab) where the model
is restricted to read-only tool calls and writes a structured plan instead of
executing. Plan mode is the runtime expression of the discipline Chapter 0.3
introduces: *describe before mutate*. The model proposes a plan; the user reads
it; the user picks an execution mode at the ExitPlanMode gate (auto / accept
edits / review each edit / keep planning); only then does execution begin. For
destructive operations, plan mode is the cheapest safety net — cheaper than
an interactive deny, more permissive than a hard block in `settings.json`.
Engineers building tooling on top of Claude Code should treat plan mode as a
first-class state: any prompt that might mutate the user's filesystem or
external state should reach plan mode before any write.

---

## What's NOT in this guide

This is an overview, not a tutorial. It does not teach you how to write a
subagent, how to ship an MCP server, or how to wire the SDK into CI. The
chapters do that, with worked examples and the prompts that produced them.
Read this guide to understand how the pieces fit; read the chapters to build
the pieces.

It also does not document every key in `settings.json`, every event a hook can
hook, or every tool the built-in toolset exposes. Anthropic publishes the
canonical reference for all of those, and that reference is the source of
truth. The companion repo's `appendix-f-settings/settings.json` is one
operator's working file with the regrets annotated; the official schema is the
list of *what's possible*.

Finally, the architecture above is the state of Claude Code at the time the
2nd edition went to press. Anthropic ships changes weekly. Some of the layer
boundaries above will move. The chapters teach the underlying *shape* of the
problem (a small staff of specialized agents, governed weekly, composed from
slash commands → subagents → SDK as the work scales), which is the part that
should outlive any specific build.

---

## Where to go next, by interest

- *"I want to build an MCP server."* Re-read Chapter 13. Then read Anthropic's
  MCP spec at `modelcontextprotocol.io` and the existing servers at
  `github.com/modelcontextprotocol/servers` for reference implementations.
- *"I want to ship an agent in production."* Re-read Chapter 24. The SDK
  reference is the next stop. The book's `ch24-self-improving-and-sdk/`
  folder has a working GitHub Action that runs the Chapter 21 dashboard build
  on a schedule — fork it as a starting point.
- *"I want to harden the permission and hook story for my team."* Re-read
  Chapters 7, 8, and Appendix F. The deny/ask/allow shape and the hook
  catalog are the leverage points. Pair with Chapter 26 (the Sunday
  governance hour) for the weekly maintenance practice.
- *"I want to contribute to the book or this repo."* The chapters are the
  canonical tutorial; this repo is the answer key. If you spot a chapter
  artifact that's drifted from the manuscript, file an issue against the repo
  and mention the chapter number and the specific file. The book's errata
  process is described in `ERRATA.md` at the manuscript root.

The chapters above are written for operators; this guide is written for
engineers who want to extend or contribute. Both are valid entry points to the
same system.
