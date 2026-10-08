# Chapter 0.2 — Install + your first three prompts

This chapter walks you from zero to a working Claude Code install, then through your first three prompts. It is install-focused — there is almost nothing to clone here, because the artifacts you produce live in your own `~/work/` directory, not in this repo.

## What the chapter has you do on disk

1. Open a terminal and paste Anthropic's one-line install command for your OS (see [`prompts.md`](./prompts.md)).
2. Type `claude` and sign in with your Anthropic account.
3. Prompt 1: ask Claude to make `~/work`, then turn it into a git repository. Claude proposes `mkdir ~/work && cd ~/work && git init`; you approve.
4. Prompts 2 and 3: Claude reads your Documents folder, then reads a single file you hand it with `@`.

That's the entire on-disk footprint of Chapter 0.2: an empty `~/work/` folder, tracked by git. Claude creates it; you approve.

## What's in this folder

- [`prompts.md`](./prompts.md) — the install commands, the three first prompts (including the one that uses `@` to load a file into context), the five make-it-yours prompts, and the 60-second self-test.

## Where to go next

- Chapter 0.3 — your first `settings.local.json` (the floor of safety).
- Chapter 1 — the first full chapter with a clone-able worked example.
