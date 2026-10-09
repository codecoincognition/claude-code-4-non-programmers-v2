# Claude Code Power-User Command Cheat Sheet

A one-page lookup for every power-user command in *Claude Code for Non-Programmers* (chapters 23-25). For depth on *why* a command behaves the way it does, go back to the chapter named in the "Taught in" column.

> Verified against the Claude Code v2.x command surface as of the book's draft date. The surface evolves — commands may be renamed or restructured. The errata page is the live truth: https://github.com/codecoincognition/claude-code-4-non-programmers-v2/blob/main/ERRATA.md — if an entry here doesn't match what your terminal does, the errata page wins.

---

## Quick lookup (alphabetical)

| Command | What it does | Taught in |
|---|---|---|
| `/auto` * | Personalized wrapper around auto mode: a classifier reads each prompt, picks the command, model, and effort, and tells you what it picked. | Ch 24 |
| `/batch` | Splits a sweep into 5-30 independent units, runs each in its own git worktree in parallel, and opens a pull request per unit. Requires a git repo. | Ch 24 |
| `/branch` | Switches your session into a copy of the conversation (new conversation ID). The parent stays intact and resumable. | Ch 23 |
| `/btw` | Mid-task correction: injects an extra constraint into an in-progress reply without restarting the work. | Ch 23 |
| `--channels` | Session-launch flag: loads channel plugins so an MCP server can push inbound events (Telegram, iMessage, Discord) into the session. | Ch 13 |
| `/channels` | Lists the channel plugins active in the session, with status, sender allowlist, and pairing state. Read-only. | Ch 13 |
| `/compact` | Summarizes session history into compact form to free context-window space. Lossy — pin decisions first. | Ch 23 |
| `/context` | Shows current context-window usage as a percentage of the model's window. | Ch 23 |
| `/cost` | Shows total session token spend. | Ch 23 |
| `Ctrl+G` | Opens your external editor (`$EDITOR`) for editing a multi-line prompt. | Ch 23 |
| `/effort` | Sets reasoning intensity for the session: `low`, `medium`, `high`, `xhigh`, `max`, `ultracode`, or `auto`. | Ch 23 |
| `/fork` | Spawns a forked subagent in the background that inherits the conversation and works on your directive; its result returns to your session. | Ch 23 |
| `/goal` | Sets a condition Claude keeps working toward across turns until it's met. | Ch 23 |
| `/imessage:access` | Manages the sender allowlist for the iMessage channel plugin (`allow`, `revoke`, `list`). macOS only. | Ch 13 |
| `/insights` | Reads session history and reports patterns you repeat, prompts you almost-always paste, and skills that would save the most time. | Ch 25 |
| `/loop` | Bundled skill (alias `/proactive`): runs a prompt repeatedly while the session stays open. | Ch 23 |
| `/model` | Switches the active model for the session. | Ch 23 |
| `/plan` | Plan mode: Claude explores read-only, drafts a single plan, and waits for your approval before executing. | Ch 23 (surfaced as a command); Ch 8 (taught as a permission posture) |
| `/plugin` | Browses, installs, and manages plugins from configured marketplaces. MCPs live under *External integrations* in `/plugin` Discover. | Ch 23 |
| `--resume` and `claude rm` | `claude --resume` opens a picker of resumable sessions; `claude rm <id>` deletes one. | Ch 23 |
| `/review-mine` * | Personalized command authored in Ch 24 — runs the auto-mode review pipeline on `$ARGUMENTS`. | Ch 24 |
| `/rewind` (`Esc Esc`) | Rolls back the session to a chosen prior prompt, keeping the rest. | Ch 23 |
| `/sandbox` | Runs a script or command in an isolated environment (mocked filesystem, network, credentials). | Ch 24 |
| `/schedule` | Creates routines that run on Anthropic-managed cloud infrastructure on a cron schedule (alias `/routines`). | Ch 23 (surfaced); Ch 7 (taught conceptually); Ch 25 (deep dive) |
| `/security-review` | Reviews your pending git changes and flags secrets, injection surfaces, auth gaps, insecure defaults, and AI-code bug shapes. | Ch 24 |
| `/simplify` | Four-agent quality review (reuse, simplification, efficiency, abstraction), then applies the fixes. | Ch 24 |
| `/skills` | Lists the skills loaded in your session, including those shipped inside installed plugins. | Ch 23 |
| `/telegram:access` | Manages the pairing flow and sender allowlist for the Telegram channel plugin. | Ch 13 |
| `ultrathink` | Keyword (not a slash command): deepest reasoning for one prompt, regardless of `/effort`. Costs 5-10x. | Ch 23 |

\* Personalized command authored in this book (Chapter 24), not a Claude Code built-in.

---

## By family

Use the family to find the right neighborhood, then drill into the entry. The table is a reading aid, not a taxonomy — some commands belong to more than one family.

| Family | Members | What they share |
|---|---|---|
| Navigation | `/rewind`, `/branch`, `/fork`, `--resume` | Move through session history |
| Mid-task control | `/btw`, `Ctrl+G` | Adjust in-flight work |
| Awareness | `/cost`, `/context`, `/compact` | Sense the session |
| Intensity | `/model`, `/effort`, `ultrathink` | Tune reasoning depth and cost |
| Modes | `/plan`, `/auto` * | Set behavioral posture |
| Review | `/simplify`, `/code-review`, `/security-review`, `/sandbox`, `/batch`, `/review-mine` * | Audit existing artifacts |
| Self-improvement | `/insights` | Observe and propose |
| Persistence | `/schedule`, `/loop`, `/goal` | Keep work going past a single turn — clock-shaped, session-shaped, or condition-shaped |
| Discovery | `/plugin`, `/skills` | Find and inspect capabilities |

`/auto` is a Mode that picks among Review commands. `/schedule` is Scheduling but it also drives every long-running Self-improvement loop. Entries marked `*` are personalized commands authored in this book (Chapter 24), not Claude Code built-ins.

---

## Common compositions

- `/insights` → (manual distillation prompt) → `/auto` — observe, file as a skill, let auto pick it next time.
- `/security-review` → `/sandbox` — audit static, then verify behavior.
- `/cost` → `/context` → `/compact` — situational awareness, then act on it.
- `/branch` → work in copy → `claude --resume <parent>` — try an alternative without committing the main thread.

---

## Entry detail

### `/auto` * — Ch 24
Switches on auto mode for the session: a classifier reads each prompt and picks the command, model, and effort, telling you what it picked. Use when you'd rather prompt in plain English and let Claude pick the command surface — especially for review tasks where the right command varies by file type. Picks among `/simplify`, `/security-review`, `/sandbox`, `/batch`. \* Presented as the personalized command authored in Chapter 24 that wraps auto-mode behavior; it isn't a Claude Code built-in. The built-in primitive is auto permission mode, set via `--permission-mode auto` or by cycling Shift+Tab to it.

### `/batch` — Ch 24
Splits a sweep into 5-30 independent units of work, dispatches each into its own isolated git worktree in parallel, and opens a pull request per unit when finished. Requires a git repo. Use to apply a corrective pattern (error handling, naming, dependency upgrade) across a folder at once, where each unit can land as its own PR. Faster than running `/simplify` six times serially. Related: `/simplify` (single-file deep), `/security-review` (audit broad).

### `/branch` — Ch 23
Switches your current session into a copy of the conversation up to the chosen point — a new conversation ID, with you driving. The parent conversation is left intact and resumable. Use when you want to try an alternative approach yourself and keep the original thread untouched. Return to the parent with `claude --resume <parent-id>`. Related: `/fork` (when you want a background subagent to take the alternative, not you).

### `/btw` — Ch 23
Mid-task correction primitive. Interjects an extra constraint or instruction into a reply that's already in progress, without restarting the work. Use when, halfway through a reply, you realize you also wanted X: type `/btw add X` instead of waiting and re-prompting. Related: `/rewind` (when the correction is too big for `/btw`), `Ctrl+G`.

### `--channels` — Ch 13
A session-launch flag. Loads one or more channel plugins so an MCP server can *push* inbound events into the running session. The three official plugins are `plugin:telegram@claude-plugins-official`, `plugin:imessage@claude-plugins-official`, and `plugin:discord@claude-plugins-official`; `--dangerously-load-development-channels` is required during research preview to load custom channels you authored yourself. Use when launching a session that should listen to a chat surface — Pheme's background session in Ch 13 is the canonical example. Example: `claude --channels plugin:telegram@claude-plugins-official --channels plugin:imessage@claude-plugins-official -n pheme --agent pheme --bg`. Related: `/channels`, `/telegram:access`, `/imessage:access`, `channelsEnabled` in `settings.json` (Appendix F).

### `/channels` — Ch 13
Lists the channel plugins active in the current session, with each channel's status, sender allowlist, and pairing state. Read-only — to add or remove a channel, restart the session with a different `--channels` flag. Use after launching with `--channels` to verify the plugins loaded, or when debugging a "Pheme didn't react" gap.

### `/compact` — Ch 23
Summarizes the session's history into compact form, freeing context-window space. Use when `/context` shows you're near the model's limit. Pin irreducible decisions to a `decisions.md` file before compacting — the compactor is lossy. Related: `/context`, `/rewind`.

### `/context` — Ch 23
Shows current context-window usage as a percentage of the model's window. Use when responses feel slow or you suspect accumulated verbose history. Run alongside `/cost`.

### `/cost` — Ch 23
Shows total session token spend. Use before a long run, when you suspect you've been burning tokens, or routinely at end-of-session for hygiene. Related: `/context`, `/effort`.

### `Ctrl+G` — Ch 23
Opens your external editor (configured via `$EDITOR`) for editing a multi-line prompt instead of typing it into the terminal. Use when the prompt is long, has formatting, or you want a real editor's surface. Default keybinding in current Claude Code; rebindable via `~/.claude/keybindings.json`.

### `/effort` — Ch 23
Sets reasoning intensity for the session. Levels: `low | medium | high | xhigh | max | ultracode | auto`. Higher effort means deeper reasoning, more tokens, more cost. For one-shot deep reasoning, prefer the `ultrathink` keyword. Example: `/effort high`.

### `/fork` — Ch 23
Spawns a forked subagent in the background that inherits the full conversation and works on the directive you pass. Its result returns to your conversation when it finishes; your current session keeps going. Use when you want a parallel attempt running while you stay on the main thread. To switch yourself into a copy instead, use `/branch`. (Before v2.1.161, `/fork` was an alias for `/branch`.)

### `/goal` — Ch 23
Sets a *condition* that Claude keeps working toward across turns until it's met. With no argument, shows the current or most recently achieved goal; `clear`, `stop`, `off`, `reset`, `none`, and `cancel` all remove an active goal early. Use when you know the done-state but not how many turns it'll take — a flaky test passing three runs in a row, a green build, an error that stops appearing. Related: `/loop`, `/schedule`, `/effort`.

### `/imessage:access` — Ch 13
Manages the sender allowlist for the iMessage channel plugin: `allow <handle>`, `revoke <handle>`, and `list`. The allowlist persists in `~/.claude/channels/imessage/access.json`. Use right after launching Pheme with the iMessage channel — every channel must be gated on a sender allowlist. iMessage needs no token; it reads `~/Library/Messages/chat.db` after macOS Full Disk Access is granted to Terminal. macOS only.

### `/insights` — Ch 25
Reads your session history and produces a structured report — patterns you repeat, prompts you almost-always paste, agents you almost-always invoke together, skills that would save the most time. Use monthly, or when you suspect you've been repeating yourself. Example: `/insights --last 30d`. Related: Ch 27's governance hour; the manual distill-a-pattern-into-a-skill prompt from Ch 25.

### `/loop` (bundled skill; alias `/proactive`) — Ch 23
Runs a prompt repeatedly while the session stays open. Omit the interval and Claude self-paces; omit the prompt and, where available, Claude runs an autonomous maintenance check or the prompt in `.claude/loop.md`. Use for a recurring check that lives only as long as you're at the terminal — tailing a deploy log, polling a slow API. Stops when the session closes. Example: `/loop 5m check if the deploy finished`. For schedules that must run whether or not you're there, use `/schedule` (cloud) or cron (local).

### `/model` — Ch 23
Switches the active model for the session. Use for a heavier model on a hard reasoning step, or a lighter model for cheap routine work. The aliases (`opus`, `sonnet`, `haiku`) are the safer default over pinned dated model IDs. Model is the largest cost driver.

### `/plan` — Ch 23 (surfaced as a command); Ch 8 (taught as a permission posture)
Enters plan mode: Claude reads, greps, and explores read-only, then drafts a single plan and waits for your approval before any execution begins. Persists until you exit with `/plan` again or Shift+Tab. Use before risky operations — production deploys, browser-use on new sites, computer-use sessions, modifying hooks.

### `/plugin` — Ch 23
Browses, installs, and manages plugins from configured marketplaces, including the official Anthropic marketplace. Plugins can bundle skills, subagents, hooks, slash commands, and MCP servers; MCP integrations live in the *External integrations* section of `/plugin` Discover. Use when you're missing an MCP, skill, or workflow someone has already packaged. Run Appendix C's rubric before installing. Related: `claude mcp add <name> -- <command>` (one-off MCP install without a plugin), `/skills`.

### `--resume` and `claude rm` — Ch 23
`claude --resume` opens an interactive picker of your resumable sessions and restores the one you choose. `claude rm <id>` deletes a session you no longer want. For automatic pruning, set `cleanupPeriodDays` in `settings.json`. Use `--resume` to return after closing the terminal or to switch back to a parent thread after a `/branch` or `/fork`; `claude rm` for one-off cleanup.

### `/review-mine` * — Ch 24
A personalized slash command (not a built-in) that runs the auto-mode review pipeline on whatever files you pass as `$ARGUMENTS`, filing output to `~/work/reviews/{date}/`. Use for end-of-week review of files you authored; wire into a Stop hook for end-of-session review. Install it with the prompt in Chapter 24.

### `/rewind` (also `Esc Esc`) — Ch 23
Rolls back the session to a chosen prior prompt, selectively undoing without losing the rest. Use when you realize three prompts ago was the wrong fork. `Esc Esc` is the faster path and works inside an in-progress reply too. Related: `/fork`, `/branch`.

### `/sandbox` — Ch 24
Runs a script or command in an isolated environment with mocked filesystem, network, and credentials so it can't touch real state. Use on the first run of any new shell script, any Claude-authored hook, or any operation touching `~/work/` paths you can't easily restore. Available on macOS, Linux, and WSL2; native Windows is not supported.

### `/schedule` — Ch 23 (surfaced); Ch 7 (taught conceptually); Ch 25 (deep dive)
Creates *routines* that run on Anthropic-managed cloud infrastructure on a cron schedule (alias: `/routines`). Claude walks you through setup conversationally. Use anywhere you'd say "refresh this every night" and want it to run whether or not your laptop is on. Example: `/schedule refresh the dashboard every morning at 3 AM`. For schedules that must run on your own machine, use cron (macOS/Linux) or Task Scheduler (Windows).

### `/security-review` — Ch 24
Reviews your pending git changes (the set `git diff` would show) and flags security risks: secrets, injection surfaces, auth gaps, insecure defaults, and AI-authored-code-specific bug shapes. You don't pass it a file path; it picks up whatever you've changed. Use before committing any Claude-authored work, especially slash command files (these grant permissions). Run it on the change set, not the whole repo.

### `/simplify` — Ch 24
Four-agent review pipeline focused on quality, not bugs — looks for reuse, simplification, efficiency, and abstraction (altitude) cleanups, then applies the fixes. Use when code works but smells off. Pair with `/code-review` if you also want correctness bugs surfaced. Related: `/security-review` (security audit), `/batch` (sweep across many files).

### `/skills` — Ch 23
Lists the skills currently loaded in your session — first-party and any shipped inside installed plugins. Skills aren't browsed from a standalone marketplace; they're distributed inside plugins. Use to see what's available, or to confirm a plugin you just installed contributed the skill you expected. Related: `/plugin`, Appendix C.

### `/telegram:access` — Ch 13
Manages the pairing flow and sender allowlist for the Telegram channel plugin. Pair-up: (1) save your BotFather token to `~/.claude/channels/telegram/.env` as `TELEGRAM_BOT_TOKEN=...`; (2) DM your bot from your real Telegram account; (3) run `/telegram:access pair <code>` with the code the bot replies with. Then `allow <handle>`, `revoke`, and `list` manage senders. State lives in `~/.claude/channels/telegram/access.json`. Every channel must be gated on a sender allowlist — an ungated Telegram channel is a documented prompt-injection vector.

### `ultrathink` (keyword, not a slash command) — Ch 23
Type inline in any prompt to request the deepest reasoning available, regardless of session-level `/effort`. Use for prompts where you'd otherwise wait an hour to ask a colleague. Costs 5-10x a normal prompt. Related: `/effort`, `/model`.
