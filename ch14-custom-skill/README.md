# Chapter 14 — Your first custom skill

This chapter turns your writing voice into a file. You save three samples of your own
writing, have Claude extract the patterns, and let it author `your-tone.md` — a skill that
auto-loads on any writing request and applies your voice rules to every draft. You also
leave with a short `when-to-skill.md` decision tree (skill vs. slash command vs. subagent
vs. just-prompt), and — from the "when it goes wrong" recovery — a `/draft` slash command
that holds your writing *workflow* separately from your voice *behavior*. Every writing
agent the newsroom (Ch 15) and launch crew (Ch 16) hire inherits this one file.

## Files in this folder

```
ch14-custom-skill/
├── README.md                                  ← this file
├── prompts.md                                 ← every chapter prompt, verbatim, in order
└── work/                                      ← clone into your ~/work/
    ├── .claude/
    │   ├── skills/
    │   │   ├── your-tone.md                    ← the voice skill (4 sections, auto-loads on writing)
    │   │   └── when-to-skill.md               ← the decision-tree reference note (no frontmatter, never triggers)
    │   └── commands/
    │       └── draft.md                        ← the /draft workflow (from the recovery in "When it goes wrong")
    └── voice-samples/                          ← the three writing samples Claude reads to extract your voice
        ├── sample-email.md
        ├── sample-linkedin-post.md
        └── sample-campaign-brief.md
```

| File | What it is |
|---|---|
| `work/.claude/skills/your-tone.md` | The chapter's main artifact. YAML frontmatter (`name`, behavior-keyed `description`) plus four body sections: signature moves, what to never write, rhythm rules, and email-specific rules. Auto-loads whenever a writing/editing prompt arrives. |
| `work/.claude/skills/when-to-skill.md` | A 15-line decision tree. Deliberately has **no frontmatter** — it's a reference note that lives in the skills folder but never triggers as a skill. |
| `work/.claude/commands/draft.md` | A slash command for the full 5-step writing routine (outline → draft → cut → add imagery → read aloud). This is the *workflow* that the chapter shows you should NOT jam into the voice skill. Loads `your-tone.md` internally for the voice rules. |
| `work/voice-samples/*.md` | Three synthetic writing samples (email, LinkedIn post, campaign brief) demonstrating the voice the skill extracts. Replace these with three real samples of your own before authoring your own tone skill. |

## How to use

1. Copy the `work/` contents into your own `~/work/` (the `.claude/` artifacts and the
   `voice-samples/` folder). If you already have a `~/work/.claude/skills/` from earlier
   chapters, just drop `your-tone.md` and `when-to-skill.md` alongside `debugging.md`.
2. Replace the three files in `voice-samples/` with three real samples of *your* writing —
   one email, one short post, one longer piece. The skill is only as good as the samples.
3. Confirm the skill is registered: `claude skills list` should show `your-tone`.
4. Trigger it: ask Claude to "Write me a 100-word LinkedIn post announcing my new hire…"
   You don't name the skill — Claude matches the `description` and loads it automatically.
5. To run the full 5-step writing routine instead of a one-shot draft, ask Claude for the
   "full draft process" — it picks `/draft` under the hood, which loads `your-tone.md` for
   the voice rules.
6. As you notice gaps, edit `your-tone.md` — add a section, narrow a rule. Skills evolve;
   they just shouldn't sprawl. Keep the body under ~6,000 characters.

The book is self-contained — these files are ready-to-clone copies of what Chapter 14
walks you through building.
