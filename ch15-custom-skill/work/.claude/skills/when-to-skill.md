# When to skill, when to command, when to subagent, when to just prompt

A decision tree for the wrap-as-a-construct moment. When you find
yourself prompting Claude the same way a fourth time, ask which
kind of repetition it is:

- **Skill** — a *behavior pattern* (how to do a kind of work).
  Lives in `.claude/skills/{name}.md`. Auto-loads when its
  description matches the prompt.

- **Slash command** — a *named task* you invoke explicitly. Lives
  in `.claude/commands/{name}.md`. Fires when Claude picks
  `/{name}` from your plain-English request.

- **Subagent** — a *bounded piece of work* needing isolation.
  Lives in `.claude/agents/{name}.md`. Fires when the main
  session delegates to it.

- **Just prompt** — a *one-off* prompted once, maybe twice.
  Lives nowhere; keep it conversational. Fires when you type it.

The four-line rule for promotion: if you've prompted the same
thing four times, it's a wrap candidate. Below four, the cost of
authoring exceeds the benefit. At four or more, the wrap pays
for itself within two weeks.
