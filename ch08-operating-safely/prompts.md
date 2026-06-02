# Chapter 8 — Operating safely · Prompts

Every prompt the chapter has you type, in order. Copy them verbatim. The point of
the chapter is that you *describe the safety you want* and Claude writes the JSON
and the shell scripts — you never hand-edit either. The finished files those
prompts produce are checked into this folder (`work/.claude/settings.json`,
`work/scripts/audit-log.sh`) so you can compare your result against the reference.

---

## Building the leash

### Step 1 — Set plan mode as the default

Open Claude in your work folder first:

```
cd ~/work && claude
```

Then:

> I want to start every Claude session in plan mode by default. First, show me the four permission modes and what each one does — then make the change in ~/work/.claude/settings.json.

Produces: `permissions.defaultMode = "plan"` in `work/.claude/settings.json`.

### Step 2 — See what plan mode looks like before you trust it

Quit (Ctrl-C twice or `/exit`), open a fresh session, then ask for a delete you
will refuse:

```
claude
```

> Delete the file ~/work/briefs/test.md.

When the plan appears (`1. Delete ~/work/briefs/test.md`), answer `n`. Nothing is
deleted. That's the leash working.

### Step 3 — Add an allow / ask / deny list

> Set up an allow / ask / deny list in ~/work/.claude/settings.json. Allow read-only file operations and "git status." Always ask before any file deletion or any shell command outside ~/work/. Deny anything that touches ~/.ssh/, ~/.aws/, or any environment variable starting with SECRET_. Show me the diff before you save.

Produces the `permissions` block with `allow` / `ask` / `deny`. See
`variants/settings-step3-before-tightening.json` for exactly what Claude writes
here, *before* the Step in "When the leash chafes" widens the allow list.

Test the new rules without leaving the session:

> Try three things in a row, one at a time, and tell me which approval prompt fires for each: (1) read ~/work/CLAUDE.md, (2) read ~/.ssh/known_hosts, (3) run "git diff" in this folder.

Expect: auto-approve, deny-blocked, ask. One of each.

### Step 4 — Install the audit-logging hook

> Now install the PreToolUse audit hook from Chapter 7's hook menu. Every time Claude is about to use any tool, append one line to ~/work/.claude/audit.log with the timestamp, the tool name, and the first 200 characters of what it's about to do. Don't block anything — just log. Save the script to ~/work/scripts/audit-log.sh and add the hook entry to settings.json.

Produces: `work/scripts/audit-log.sh` (15 lines, always exits 0) and the
`PreToolUse` block in `settings.json`.

Seed the log:

> Read ~/work/CLAUDE.md and tell me how many lines it has.

Then look at what was captured:

```
tail -3 ~/work/.claude/audit.log
```

### Step 5 — Read what you just installed

> Read ~/work/.claude/settings.json and walk me through every block, line by line, in plain English. Treat me like I've never seen JSON. I want to know exactly what I just installed.

The "do you understand what you installed" checkpoint. Re-run it once a month, or
twice a month if you've changed something.

### Step 6 — Tail your audit log and ask Claude to read it

> Tail my audit log for the last 10 entries. Tell me which were auto-approved, which I had to approve, and whether anything looked surprising.

The read-after-the-fact pattern. "Anything surprising" is the line that does the
work.

---

## When the leash chafes

After hitting too many approval prompts on routine edits, sharpen the leash
instead of bypassing it:

> I'm hitting too many approval prompts on routine CLAUDE.md edits. I don't want to bypass everything — that's how the brief-cleanup disaster happened. Tighten the allow list so file edits inside ~/work/ auto-approve, but keep deletions and anything outside ~/work/ asking. Show me the diff before you save.

Produces: `Edit(~/work/**)` and `Write(~/work/**)` added to `permissions.allow`.
This is the *final* state of `work/.claude/settings.json` in this folder. The
rule is always **promote the repetitive action to the allow list, don't demote
the mode.**

---

## The prompt grammar (keep this in your head)

> For the {tool / path / pattern}, I want Claude to {auto-approve | always ask | never run}. Update my allow / ask / deny list and show me the diff.

Substitute and the pattern reproduces. The audit hook is built once and never
re-prompted — from then on you just *read* it.

---

## Make it yours

### 1. Tighten for a sensitive project

> I'm about to start a project where I'll be reading client NDAs. Create `~/work/clients/{client}/.claude/settings.json` that overrides my global one — deny anything except read on this folder, deny all shell commands, and tag every audit log line with the client name.

Reference: `variants/sensitive-project/.claude/settings.json` +
`variants/sensitive-project/scripts/audit-log-client.sh`.

### 2. Loosen for a sandbox

> I'm experimenting with a throwaway script in `~/work/sandbox/`. Inside that folder only, set acceptEdits as the default and allow `Bash(*)` — but keep my global deny list intact.

Reference: `variants/sandbox/.claude/settings.json`.

### 3. Approve once, document why

> Whenever I approve a tool call manually, write a one-line note to `~/work/.claude/approvals.log` with what I approved and why I think I approved it. Use a Stop hook so it asks me at the end of each session.

Reference: `variants/approvals-journal/.claude/settings.json` +
`variants/approvals-journal/scripts/approvals-journal.sh`.

### 4. Read the trail

> Read my audit log for the last 24 hours and tell me: how many tool calls did Claude make, what was the most-used tool, and was there anything I had to approve more than three times in a row that should be on the allow list?

The Sunday log-summarizer prompt. Catches permission-fatigue patterns.

### 5. Audit the audit hook

> Read my `audit-log.sh` script and tell me: could it crash in a way that blocks Claude from running? Is there any input it doesn't sanitize? Make it bulletproof.

Run it through `shellcheck` while you're at it; ask Claude to fix any warnings.

---

## The lift — rotate the log when it grows

> Rotate my audit log monthly: rename audit.log to audit-{month}.log.gz, gzip it, start a fresh audit.log. Write it as a short script and give me the cron line to schedule it.

Reference: `variants/log-rotate/rotate-audit-log.sh` (includes the cron line).

---

## Test yourself in 60 seconds

Three prompts from the chapter close. If all three land, you're ready for Chapter 9.

1. > Confirm plan mode is on by default in this folder. Explain in one sentence what that changes about how you propose actions.
2. > Add npm install to my allow list. Then show me the line in my audit log that captured the change.
3. > Tail the last 20 lines of ~/work/.claude/audit.log and tell me what the most recent tool call was.

Stuck? Run:

> Audit my Chapter 8 setup against the chapter spec.
