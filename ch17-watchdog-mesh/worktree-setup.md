# Worktree setup for the watchdog mesh

The chapter's callout points here for the details. A git worktree is a
separate working folder for the same git repo, so a long-running agent
doesn't pollute your main `~/work/` session. Same git history, different
files on disk, different `.claude/` session.

## Create it

The chapter prompt:

> Set up a git worktree at `~/work/worktrees/watchdog-mesh/` from the
> current branch. The watchdog mesh will run inside it so its activity
> doesn't pollute my main `~/work/` session.

What Claude runs underneath:

```bash
git worktree add -b watchdog-mesh ~/work/worktrees/watchdog-mesh main
```

The `-b watchdog-mesh` flag creates a **new branch** called
`watchdog-mesh` rooted at `main` and checks it out into the new worktree.
Without `-b`, git would try to check out `main` itself in the second
worktree — and git refuses to have the same branch checked out in two
places at once, so `git worktree add ~/work/worktrees/watchdog-mesh main`
errors with *"main is already checked out at ~/work"*. Giving the
worktree its own branch sidesteps that.

Verify:

```bash
git worktree list
#   /Users/maya/work                           4a8c2f1 [main]
#   /Users/maya/work/worktrees/watchdog-mesh   4a8c2f1 [watchdog-mesh]
```

Same commit (`4a8c2f1`), two branches, two folders. The mesh now has
its own room and its own branch — commits inside
`~/work/worktrees/watchdog-mesh/` land on `watchdog-mesh`, not `main`,
until you deliberately merge them.

## Why a worktree for the mesh

The mesh runs continuously in the background, may modify state, and has a
scheduled job firing every fifteen minutes. Running it inside `~/work/`
directly would mean its activity competes with whatever you're doing
interactively in `~/work/`. A worktree gives the mesh its own room — and,
crucially, its own `.claude/` configuration. When the scheduled
orchestrator wakes up at 11:48 PM, it reads its own
`.claude/agents/watchdog/` files, not the ones in your interactive
session.

## The boundary gotcha (from "The lift")

> Over time you'll find you've installed agents in the worktree but
> reference them in the main session and they don't load.

Fix: commit the agent files to git so both worktrees see them, or symlink
them — but be deliberate about which side of the boundary lives where.

## Remove it (retiring the mesh)

One-line prompt:

> Remove the watchdog-mesh worktree at `~/work/worktrees/watchdog-mesh/`.

Underneath:

```bash
git worktree remove ~/work/worktrees/watchdog-mesh
git branch -D watchdog-mesh    # optional: delete the branch too
```
