# Chapter 0.3 — Two Safety Habits

This chapter sets up the **floor of safety** for everything that follows in the book. It's two habits and one file:

1. **Read-before-running.** When Claude proposes an action, read the *path* and the *verb* before you say go. Two seconds.
2. **The pause reflex.** When Claude is about to delete, send, post, transfer, or pay, stop, breathe, re-read. Five verbs. The list doesn't grow.

The file is a 3-rule deny block in `settings.local.json` that catches the worst categories of accident while the habits become reflex. This folder ships that file.

## What's in this folder

- [`work/.claude/settings.local.json`](./work/.claude/settings.local.json) — the canonical 3-rule deny block. Copy this into your own `~/work/.claude/settings.local.json`.
- [`prompts.md`](./prompts.md) — every prompt from the chapter, in order.

## The 3-rule deny block

```json
{
  "permissions": {
    "deny": [
      "Bash(rm -rf *)",
      "Bash(rm -rf ~/work *)",
      "Bash(sudo *)"
    ]
  }
}
```

Three rules, in plain English:

- `Bash(rm -rf *)` — never run a command that recursively deletes.
- `Bash(rm -rf ~/work *)` — never recursively delete the work folder. This protects the staff files you'll build across the rest of the book.
- `Bash(sudo *)` — never run a command with administrator privileges. If something legitimately needs sudo, you type it yourself in the terminal.

One honest note from the chapter: Bash rules match the command string, not the file path, so a clever Bash pattern can't reliably fence a whole folder. The strongest path-based protection is the OS-level sandbox (Appendix B) and the audit hook in Chapter 8. The three rules are a useful floor, not the ceiling.

## This is the floor, not the ceiling

The 3-rule block is the minimum. You can add path-scoped Read denies on top of it as you build more sensitive habits — for example:

```json
"Read(~/.ssh/**)",
"Read(~/.aws/**)",
"Read(.env)"
```

Those keep Claude from peeking at credentials. Add them when you're ready. But never go below the 3-rule deny block — that's the line.

## How to install

```bash
mkdir -p ~/work/.claude
cp work/.claude/settings.local.json ~/work/.claude/settings.local.json
```

Then start Claude Code from inside `~/work/` and it'll pick up the rules automatically.
