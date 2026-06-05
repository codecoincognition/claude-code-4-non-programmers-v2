# Chapter 0.2 — Install and First Prompt

This chapter walks you from zero to a working Claude Code install, then through your first three prompts. It is install-focused — there is almost nothing to clone here, because the artifacts you produce live in your own `~/work/` directory, not in this repo.

## What the chapter has you do on disk

1. Install Claude Code (per the official install instructions for your OS).
2. Create a working directory: `mkdir -p ~/work && cd ~/work`.
3. Run `git init` inside it so every later chapter has a versioned home.
4. Run the three first prompts (see [`prompts.md`](./prompts.md)).

That's the entire on-disk footprint of Chapter 0.2. The only file you actually create yourself is the `.git/` directory from `git init`.

## What's in this folder

- [`prompts.md`](./prompts.md) — the three first prompts the chapter teaches, including the one that uses `@file` to load a file into context.

## Where to go next

- Chapter 0.3 — your first `settings.local.json` (the floor of safety).
- Chapter 1 — the first full chapter with a clone-able worked example.
