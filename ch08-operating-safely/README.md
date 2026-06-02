# Chapter 8 — Operating safely

This chapter builds **the leash you put on before you hire any staff**: three
safety primitives that make Claude *propose-then-act, with a paper trail*.
Plan mode (`defaultMode: "plan"`) shows you the whole plan before anything
irreversible runs; an **allow / ask / deny** permissions block auto-approves the
boring stuff, always asks on the dangerous stuff, and flat-out refuses the
off-limits stuff; and a `PreToolUse` **audit-logging hook** appends one line to
`~/work/.claude/audit.log` every time Claude is about to use a tool. All three
live in `~/work/.claude/settings.json` plus a 15-line shell script — all of it
configured by prompting Claude, none of it hand-written JSON.

## Files in this folder

### Core artifacts (the three things the chapter builds)
| Path | Purpose |
|------|---------|
| `work/.claude/settings.json` | The full settings file: `permissions` (plan mode + allow/ask/deny) and two hooks (`SessionStart`, `PreToolUse`). This is the **final** state, after the "When the leash chafes" tightening that adds `Edit(~/work/**)` and `Write(~/work/**)` to the allow list. |
| `work/scripts/audit-log.sh` | The 15-line `PreToolUse` logger. Reads the hook payload from stdin, appends `timestamp · tool · first-200-chars` to `audit.log`, **always exits 0** so it can never block a tool call. |
| `work/scripts/show-brief.sh` | The Chapter 7 `SessionStart` hook, included so this chapter's `settings.json` is complete and runnable. Prints the most recent brief from `work/briefs/`. |
| `work/.claude/audit.log` | A seeded sample audit trail (the same 10 lines the chapter shows). Append-only; yours grows over time. |

### Sample data so the setup runs
| Path | Purpose |
|------|---------|
| `work/briefs/2026-05-06.md` | A tiny synthetic morning brief so `show-brief.sh` has something to display. |
| `work/briefs/README.md` | What this folder is and where briefs come from (Chapter 7). |

### Variants (the "Make it yours" follow-ups + The lift)
| Path | Purpose |
|------|---------|
| `variants/settings-step3-before-tightening.json` | Settings exactly as Claude first writes it in Step 3, **before** the chafe-tightening — useful to see what changed and why. |
| `variants/sensitive-project/.claude/settings.json` | Make it yours #1 — a per-project override for client/NDA folders: read-only, no shell, every audit line tagged with the client name. |
| `variants/sensitive-project/scripts/audit-log-client.sh` | Companion logger that tags each line with `[client:{name}]`. |
| `variants/sandbox/.claude/settings.json` | Make it yours #2 — a throwaway sandbox override: `acceptEdits` default, `Bash(*)` allowed, global deny list kept intact. |
| `variants/approvals-journal/.claude/settings.json` | Make it yours #3 — a `Stop` hook block to merge in, journaling what you approved each session. |
| `variants/approvals-journal/scripts/approvals-journal.sh` | The Stop-hook script that asks for a one-line note and appends to `approvals.log`. |
| `variants/log-rotate/rotate-audit-log.sh` | From "The lift" — monthly rotation: gzip the old `audit.log`, start a fresh one. Includes the cron line to schedule it. |

## How to use

1. Copy the `work/` folder into your home directory so it lands at `~/work/`:
   ```
   cp -R work/. ~/work/
   ```
   That places `settings.json` at `~/work/.claude/settings.json`, the scripts at
   `~/work/scripts/`, and the sample brief at `~/work/briefs/`.
2. Make the scripts executable:
   ```
   chmod +x ~/work/scripts/audit-log.sh ~/work/scripts/show-brief.sh
   ```
3. Open Claude in the folder (`cd ~/work && claude`) and ask it to read the
   settings back to you in plain English — the Step 5 checkpoint:
   *"Read ~/work/.claude/settings.json and walk me through every block, line by
   line, as if I'd never seen JSON."*
4. To try a variant, copy its `.claude/settings.json` into the matching
   subfolder (e.g. `~/work/clients/{client}/.claude/`, `~/work/sandbox/.claude/`)
   and its script into `~/work/scripts/`, then `chmod +x` it.

Requirements: `python3` is used by `audit-log.sh` to parse the JSON payload
(present by default on macOS and most Linux). The scripts are POSIX `bash`.

The book is self-contained — these files are ready-to-clone copies of what
Chapter 08 walks you through building.
