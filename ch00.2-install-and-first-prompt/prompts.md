# First Three Prompts

These are the three prompts Chapter 0.2 walks you through after install. Run them inside `~/work/` (the directory you created with `mkdir -p ~/work && cd ~/work && git init`).

## Prompt 1 — Orient Claude in the folder

```
List the files in this folder and tell me what kind of project this looks like.
```

What this teaches: Claude Code can read your filesystem. It's not a chatbot in a box — it sees the same folder you see.

## Prompt 2 — Load a specific file into context with @file

Create a tiny note first:

```
echo "Buy oat milk. Email Priya. Draft Q3 plan." > todo.txt
```

Then in Claude Code:

```
Read @todo.txt and turn it into a checklist grouped by urgency.
```

What this teaches: `@file` is how you point Claude at a specific file instead of letting it guess. This is the single most important muscle in the book.

## Prompt 3 — Ask Claude to make a small change and show you the diff

```
Add a fourth line to @todo.txt that says "Call dentist." Show me the change before saving.
```

What this teaches: Claude will propose edits and wait for your approval. You're always in the loop — nothing writes to disk silently.

---

After these three, you're ready for Chapter 0.3 (the two safety habits) and then Chapter 1.
