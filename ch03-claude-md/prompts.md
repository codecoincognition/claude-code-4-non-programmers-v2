# Chapter 3 prompts — copy-paste, in order

Every prompt below is reproduced verbatim from the chapter. This is the chapter
where the **badge** — the one-line "who I am, where the fences are" preamble you've
been retyping since Chapter 1 — moves permanently into `CLAUDE.md`, so you never
retype it again.

Open Claude in your work folder first:

    cd ~/work && claude

---

## Step 1 — Look at what's already in `.claude/`

    What's in my ~/work/.claude/ folder right now? Show me the file tree and explain each entry in one sentence.

---

## Step 2 — See the destination (the full `.claude/` anatomy), then create the placeholders

    Show me the canonical .claude/ folder anatomy — the full destination shape — with one phrase per entry. I want to see the map of where I'm going by Chapter 7.

Then create the empty placeholder folders so the map matches the disk:

    Create empty directories for ~/work/.claude/commands/, ~/work/.claude/agents/, and ~/work/.claude/skills/ so the anatomy map has real folders to point at. Don't put anything in them — they're placeholders.

---

## Step 3 — Pull the standing-context out of the badge you keep retyping

    I've been retyping a badge sentence at the top of every prompt for two weeks: "I run a small marketing consulting firm; my work folder is ~/work/; my finance data is ~/work/finance/; my vendor-categories file is at ~/work/vendor-categories.md; never edit anything outside ~/work/." Pull just the standing-context part out — the stable stuff that's true every session, not per-task — and show it to me as a draft CLAUDE.md.

---

## Step 4 — Append the four behavioral lines from the Karpathy skills repo

    I read that the four behavioral lines from Karpathy's skills repo (forrestchang/andrej-karpathy-skills, ~60K stars) are the universal starter for any CLAUDE.md. Fetch them from the repo and append them at the top of ~/work/CLAUDE.md. Show me what landed.

The fetch the chapter shows under the hood:

    curl -o ~/work/CLAUDE.md https://raw.githubusercontent.com/forrestchang/andrej-karpathy-skills/main/CLAUDE.md

---

## Step 5 — Add your two contextual lines

    Now add two more lines to ~/work/CLAUDE.md, just for me — one line saying who I am and what this folder is, and one line saying what's off-limits. Pull from the badge sentence I keep retyping, but boil it down to the two sentences that genuinely change how you act. Keep it tight.

The resulting six-line file (the one you'd hand to a friend):

    # CLAUDE.md
    1. Don't assume. Don't hide confusion. Surface tradeoffs.
    2. Minimum code that solves the problem. Nothing speculative.
    3. Touch only what you must. Clean up only your own mess.
    4. Define success criteria. Loop until verified.
    5. I run a small marketing consulting firm. My work folder is ~/work/. My finance data is in ~/work/finance/.
    6. Never edit anything outside ~/work/. Never send a client email — only draft. If you're about to do something irreversible, ask first.

---

## Step 6 — Quit and restart Claude, verify the file loaded

    /exit

Then:

    cd ~/work && claude

Confirm it loaded:

    What's the first thing you now know about me that you didn't know yesterday?

---

## Step 7 — Apply the litmus test, verify the file is as small as it can be

    Run the litmus test on every line of ~/work/CLAUDE.md: would removing this line cause you to make a mistake? Cut anything that fails. Show me what's left.

---

## When it goes wrong — the day you add 30 more rules

    My CLAUDE.md is now 47 lines. Things are getting worse, not better. Claude is ignoring rules and hallucinating ones I didn't write. Apply the litmus test to every single line: would removing this cause you to make an actual mistake? Cut everything that fails. Show me what's left and explain what I broke by adding too much.

---

## Make it yours — five variations

Same four behavioral lines, different two contextual lines. The full copyable blocks
live in `variants/` (rename the one closest to you to `CLAUDE.md` and edit the
contextual lines). The five readers are: the consultant (Maya's), the PhD researcher,
the startup founder, the in-house recruiter (GDPR fences — three contextual lines),
and the content creator.

Bonus periodic-maintenance prompt — run once a quarter:

    Look at my CLAUDE.md and tell me the one line that's doing the most work — the one I'd most regret losing. Tell me which line is doing the least, and what I'd give up by removing it.

---

## Test yourself in 60 seconds

    Read ~/work/CLAUDE.md and tell me the two contextual lines I wrote — confirm they're mine, not borrowed.

    Show me the .claude/ anatomy and tell me which chapter fills each slot (commands, agents, skills, settings).

    Apply the litmus test to every line of my CLAUDE.md — would removing this line cause you to make an actual mistake? Tell me what would survive a cut.

If you get stuck:

    audit my Chapter 3 setup against the chapter spec
