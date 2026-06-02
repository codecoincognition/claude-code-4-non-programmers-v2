# When to skill, when to command, when to subagent, when to just prompt

A decision tree for the wrap-as-a-construct moment.

When you find yourself prompting Claude the same way a fourth time,
ask which kind of repetition it is:

| If the repeated thing is…                        | Wrap as…       | Lives in                    | Fires by                          |
|--------------------------------------------------|----------------|-----------------------------|-----------------------------------|
| A *behavior pattern* — how to do a kind of work  | **Skill**      | `.claude/skills/{name}.md`  | Auto-load when description matches |
| A *named task* you invoke explicitly             | **Slash cmd**  | `.claude/commands/{name}.md`| Claude picks `/{name}` from your plain-English request |
| A *bounded piece of work* needing isolation      | **Subagent**   | `.claude/agents/{name}.md`  | Main session delegates             |
| A *one-off* — prompted once, maybe twice          | **Just prompt**| (nowhere — keep it conversational) | You type the prompt          |

The four-line rule for promotion: if you've prompted the same thing
four times, it's a wrap candidate. Below four, the cost of authoring
exceeds the benefit. At four or more, the wrap pays for itself
within two weeks.
