# Chapter 0.3 — Two Safety Habits

This chapter sets up the **floor of safety** for everything that follows in the book. It's two habits:

1. A 3-rule deny block in `settings.local.json` that blocks the three commands most likely to ruin your day.
2. The habit of always reading proposed changes before approving them.

This folder ships the file from habit #1.

## What's in this folder

- [`work/.claude/settings.local.json`](./work/.claude/settings.local.json) — the canonical 3-rule deny block. Copy this into your own `~/work/.claude/settings.local.json`.

## The 3-rule deny block

```json
{
  "permissions": {
    "deny": [
      "Bash(rm -rf *)",
      "Bash(rm * ~/work/**)",
      "Bash(sudo *)"
    ]
  }
}
```

Three rules, in plain English:

- `Bash(rm -rf *)` — block the classic "delete everything recursively" command.
- `Bash(rm * ~/work/**)` — block any `rm` that targets anything inside `~/work/`.
- `Bash(sudo *)` — block anything that asks for admin privileges.

Note the **space before `*`** in each rule. That spacing matters — it's a pattern match, not a glob, and the leading space is part of the canonical form.

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
