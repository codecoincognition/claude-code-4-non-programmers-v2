# Claude Code Power-User Command Cheat Sheet

A one-page lookup for every power-user command in *Claude Code for Nonprogrammers* (chapters 22-24). For depth on *why* a command behaves the way it does, go back to the chapter named in the "Taught in" column.

> Verified against the Claude Code v2.x command surface as of the book's draft date. The surface evolves — commands may be renamed or restructured. The errata page is the live truth: https://github.com/codecoincognition/claude-code-for-nonprogrammers-v2/blob/main/ERRATA.md — if an entry here doesn't match what your terminal does, the errata page wins.

---

## Quick lookup (alphabetical)

| Command | What it does | Taught in |
|---|---|---|
| `/auto` | Auto mode: an AI classifier reads each prompt and picks the command, model, and effort for you, then tells you what it picked. | Ch 23 |
| `/batch` | Applies the same change across many files in parallel, with a per-file diff confirmation before commit. | Ch 23 |
| `/btw` | Mid-task correction: injects an extra constraint into an in-progress reply without restarting the work. | Ch 22 |
| `/compact` | Summarizes session history into compact form to free context-window space. Lossy — pin decisions first. | Ch 22 |
| `/context` | Shows current context-window usage as a percentage of the model's window. | Ch 22 |
| `/cost` | Shows total session token spend. | Ch 22 |
| `Ctrl+G` | Opens your external editor for composing a multi-line prompt. | Ch 22 |
| `/effort` | Sets reasoning intensity for the session: `default`, `high`, or `ultra`. | Ch 22 |
| `/fork` | Spawns a parallel conversation from the current point; parent thread is untouched. | Ch 22 |
| `/insights` | Reads session history and reports patterns you repeat (skill candidates). | Ch 24 |
| `/insights-to-skills` | Turns an `/insights` finding into a draft skill for review before commit. | Ch 24 |
| `/mcp marketplace` | Browses and installs MCP servers. | Ch 22 |
| `/model` | Switches the active model for the session. | Ch 22 |
| `/plan` | Plan mode: Claude proposes each action; you approve before execution. | Ch 22 (Ch 8 conceptual) |
| `/rewind` (`Esc Esc`) | Rolls back the session to a chosen prior prompt, keeping the rest. | Ch 22 |
| `--resume <id>` | Resumes a previous session by ID, restoring its state. | Ch 22 |
| `/sandbox` | Runs a script in an isolated environment (mocked filesystem, network, credentials). | Ch 23 |
| `/schedule` | Registers a cron-style scheduled job. | Ch 22 (Ch 7 conceptual, Ch 24 deep dive) |
| `/security-review` | Audits a file/folder for secrets, injection, auth gaps, insecure defaults, AI-code bug shapes. | Ch 23 |
| `/sessions cleanup` | Lists and prunes old session forks and resumable sessions. | Ch 22 |
| `/simplify` | Three-agent pipeline (critic → simplifier → verifier) on a single file. | Ch 23 |
| `/skills marketplace` | Browses and installs skills. | Ch 22 |
| `ultrathink` | Keyword (not a slash command): deepest reasoning for one prompt, regardless of `/effort`. Costs 5-10x. | Ch 22 |
| `/review-mine` * | Personalized command authored in Ch 23 — runs the auto-mode review pipeline on `$ARGUMENTS`. | Ch 23 |

\* `/review-mine` is a personalized command from the book, not a built-in. You author it yourself in Chapter 23.

---

## By family

Use the family to find the right neighborhood, then drill into the entry. Some commands belong to more than one family.

| Family | Members | What they share |
|---|---|---|
| Navigation | `/rewind`, `/fork`, `--resume`, `/sessions cleanup` | Move through session history |
| Mid-task control | `/btw`, `Ctrl+G` | Adjust in-flight work |
| Awareness | `/cost`, `/context`, `/compact` | Sense the session |
| Intensity | `/model`, `/effort`, `ultrathink` | Tune reasoning depth and cost |
| Modes | `/plan`, `/auto` | Set behavioral posture |
| Review | `/simplify`, `/security-review`, `/sandbox`, `/batch`, `/review-mine` | Audit existing artifacts |
| Self-improvement | `/insights`, `/insights-to-skills` | Observe and propose |
| Scheduling | `/schedule` | Run things later |
| Marketplaces | `/skills marketplace`, `/mcp marketplace` | Discover capabilities |

---

## Common compositions

- `/insights` → `/insights-to-skills` → `/auto` — observe, file as a skill, let auto pick it next time.
- `/security-review` → `/sandbox` — audit static, then verify behavior.
- `/cost` → `/context` → `/compact` — situational awareness, then act on it.
- `/fork` → work in fork → `--resume <parent>` — try an alternative without committing the main thread.
- `/btw` (small mid-flight fix) vs `/rewind` (when the correction is too big and you need to roll back).

---

## Entry detail

### `/auto` — Ch 23
Switches on auto mode for the session. A classifier reads each prompt and routes to the appropriate command, model, and effort, telling you what it picked. Use when you'd rather prompt in plain English and let Claude pick the command surface — especially for review tasks where the right command varies by file type. Picks among `/simplify`, `/security-review`, `/sandbox`, `/batch`.

### `/batch` — Ch 23
Applies the same change across many files in parallel, with a per-file diff confirmation before commit. Use for sweep operations — apply one corrective pattern (error handling, naming, dependency upgrade) across a folder at once. Faster than running `/simplify` six times.

### `/btw` — Ch 22
Mid-task correction primitive. Interjects an extra constraint into an in-progress reply without restarting the work. Use when, halfway through a reply, you realize you also wanted X: type `/btw add X` instead of waiting and re-prompting. For corrections too big for `/btw`, use `/rewind`.

### `/compact` — Ch 22
Summarizes the session's history into compact form, freeing context-window space. Use when `/context` shows you're near the model's limit. Pin irreducible decisions to a `decisions.md` file before compacting — the compactor is lossy.

### `/context` — Ch 22
Shows current context-window usage as a percentage. Use when responses feel slow or you suspect accumulated verbose history. Run alongside `/cost`.

### `/cost` — Ch 22
Shows total session token spend. Use before a long run, when you suspect you've been burning tokens, or routinely at end-of-session for hygiene.

### `Ctrl+G` — Ch 22
Opens your configured external editor for a multi-line prompt instead of typing into the terminal. Use when the prompt is long, has formatting, or you want a real editor's surface. Configured by the `editor` setting in `~/.claude/settings.json`.

### `/effort` — Ch 22
Sets reasoning intensity for the session: `default`, `high`, or `ultra`. Higher effort = deeper reasoning, more tokens, more cost. For one-shot deep reasoning, prefer the `ultrathink` keyword instead.

### `/fork` — Ch 22
Spawns a parallel conversation from the current point with a new conversation ID; the parent is unchanged. Use to try an alternative approach without committing the main thread. Return to either thread with `--resume <id>`.

### `/insights` — Ch 24
Reads your session history and reports patterns you repeat — prompts you almost always paste, agents you invoke together, skills that would save the most time. Use monthly, or when you suspect you've been repeating yourself.

### `/insights-to-skills` — Ch 24
Takes an `/insights` finding and generates a draft skill capturing the pattern; you review and approve before commit. Use right after `/insights` surfaces a pattern. Pair with the gate question: *"are you going to keep doing this for the next quarter?"*

### `/mcp marketplace` — Ch 22
Browses available MCP servers and lets you install them. Use when you're missing an MCP for a tool you use. See Appendix C for the evaluation rubric.

### `/model` — Ch 22
Switches the active model for the session. Use for a heavier model on a hard reasoning step, or a lighter model for cheap routine work. Model is the largest cost driver.

### `/plan` — Ch 22 (conceptual in Ch 8)
Plan mode: Claude proposes each action; you approve before execution. Persists until exited. Use before risky operations — production deploys, browser-use on new sites, computer-use sessions, modifying hooks.

### `/rewind` (also `Esc Esc`) — Ch 22
Rolls back the session to a chosen prior prompt, selectively undoing without losing the rest. Use when you realize three prompts ago was the wrong fork. `Esc Esc` is the faster path and works inside an in-progress reply.

### `--resume <id>` — Ch 22
Resumes a previous session by ID, restoring conversation state. Use when returning after closing the terminal, or to switch back to a parent thread after a `/fork`. Example: `claude --resume abc123`.

### `/sandbox` — Ch 23
Runs a script or command in an isolated environment with mocked filesystem, network, and credentials so it can't touch real state. Use on the first run of any new shell script, any Claude-authored hook, or any operation touching paths you can't easily restore.

### `/schedule` — Ch 22 (conceptual in Ch 7, deep dive in Ch 24)
Registers a cron-style scheduled job to run a command, slash command, or build script at fixed times. Use anywhere you'd say "refresh this every night" or "run this every Monday." Example: `/schedule '0 3 * * *' ~/work/dashboard/build.sh`. See also `/schedule list`, `/schedule --deep`.

### `/security-review` — Ch 23
Audits a file or folder for secrets, injection surfaces, auth gaps, insecure defaults, and AI-authored-code-specific bug shapes. Use on any Claude-authored file before committing, on any slash command file (these grant permissions), and periodically on your `.claude/` directory.

### `/sessions cleanup` — Ch 22
Lists old session forks and resumable sessions and prunes the ones you no longer need. Use for quarterly hygiene, or when `/fork` proliferation has accumulated.

### `/simplify` — Ch 23
Three-agent pipeline: a critic finds quality smells in one file, a simplifier proposes fixes, a verifier confirms the fixes don't break behavior. Use when code works but smells off. Single-file, deep. For broad audits use `/security-review`; to apply across many files use `/batch`.

### `/skills marketplace` — Ch 22
Browses available skills and lets you install them. Use when you'd want a skill someone else built. See also `/mcp marketplace` and Appendix C.

### `ultrathink` (keyword, not a slash command) — Ch 22
Type inline in any prompt to request the deepest reasoning available, regardless of session-level `/effort`. Use for prompts where you'd otherwise wait an hour to ask a colleague. Costs 5-10x a normal prompt.

### `/review-mine` (personalized — authored in Ch 23)
A personalized slash command (not a built-in) that runs the auto-mode review pipeline on whatever files you pass as `$ARGUMENTS`, filing output to a dated reviews folder. Use for end-of-week review of files you authored; wire into a Stop hook for end-of-session review. Install it using the prompt in Chapter 23.
