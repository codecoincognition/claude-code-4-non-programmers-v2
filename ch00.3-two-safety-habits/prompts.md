# Chapter 0.3 prompts — copy-paste, in order

Every prompt from the chapter, verbatim and in order. Open Claude in your work folder first:

    cd ~/work && claude

---

## Step 1 — Watch the two-second read in action

    I have a folder of screenshots in my Downloads I want to clean up. Group them by month and rename them so they make sense. Show me the plan first — don't move anything until I approve.

---

## Step 2 — The moment the second habit fires

    Now do the same thing for my Desktop folder. Show me the plan first.

---

## Step 3 — The recovery prompt

    Skip desktop-wallpaper.jpg — that's not a screenshot. Move only the files whose names start with "Screenshot".

---

## Step 4 — Install the safety net

    Create ~/work/.claude/settings.local.json with a deny list that blocks: any "rm -rf" command anywhere, any "rm" inside ~/work/ (so you never accidentally delete my staff files), and any command that runs with "sudo". Three rules, no more. Show me the file before you save it. JSON doesn't allow inline comments, so explain each rule in plain English alongside the file — not inside it.

The file Claude writes is in [`work/.claude/settings.local.json`](./work/.claude/settings.local.json).

Optional, from the reference panel — keep the file out of git:

    add .claude/settings.local.json to .gitignore so it never gets committed.

---

## When it goes wrong — the safety net catching a real move

    Yes — move them to ~/Downloads/archive/old/. I want to keep them, just out of sight. Show me the plan first.

---

## The lift — evolving the safety net

    Update my ~/work/.claude/settings.local.json to also block [the new move I just realized I never want]. Show me the new file before saving.

---

## Make it yours — three prompts and one habit experiment

### 1. Re-read the rules out loud

    Show me my ~/work/.claude/settings.local.json and explain each rule in one sentence. I want to make sure I still understand why each one is there.

### 2. Build the read-before-running habit explicitly

    For the next 24 hours, every time you propose an action, label it 'PATH: …' and 'VERB: …' on two separate lines at the top of your response. I'm building the read-before-running habit and I want the labels to make it impossible to skip.

### 3. Plant the seed for Chapter 7

    Once a week I want a summary of every action you took in this folder — what files moved, what messages sent, anything you changed. Just for my own peace of mind. Suggest the smallest version of this you can build now, before we meet hooks in Chapter 7.

The experiment: for the next three days, every time Claude proposes an action, say the path and the verb out loud before you type `y`.

---

## Test yourself in 60 seconds

    Read ~/work/.claude/settings.local.json and explain each rule in one sentence — what it blocks and why.

    Propose deleting a file in my home directory. I want to verify the deny list catches it before I approve.

    Tell me the irreversible five (delete, send, post, transfer, pay) and walk me through what should happen mentally before I type y on each one.

If you get stuck:

    audit my Chapter 0.3 setup against the chapter spec
