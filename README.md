# Claude Code for Non-Programmers (2nd Edition) — Companion Repo

# Claude Code for Non-Programmers (2nd Edition)
### From First Prompt to AI Operator — by Vikas Sah

[![Available on Amazon](https://img.shields.io/badge/Amazon-Get_the_Book-orange?logo=amazon)](https://www.amazon.com/Claude-Code-Non-Programmers-2nd-Comprehensive/dp/B0H4HCR368/)

This is the official companion repository for
**[*Claude Code for Non-Programmers (2nd Edition)*](https://www.amazon.com/Claude-Code-Non-Programmers-2nd-Comprehensive/dp/B0H4HCR368/)** —
the comprehensive, jargon-free guide to building AI agents without writing code.

Follow Maya, an everyday marketer, as she goes from her first prompt to running
a fleet of AI agents — an inbox router, a bookkeeper, a watchdog, and more —
that work while she sleeps.

📘 **[Get the book on Amazon →](https://www.amazon.com/Claude-Code-Non-Programmers-2nd-Comprehensive/dp/B0H4HCR368/)**

**The book is self-contained.** Every prompt, every artifact, and every step you need is printed in *Claude Code for Non-Programmers (2nd Edition)* by Vikas Sah — you can read it cover to cover and build everything without ever opening this repository. This repo is **extras**: ready-to-clone copies of the files each chapter has you create, plus richer variants, fixtures, and recovery artifacts so you can skip the typing, dry-run safely, or check your work against a known-good copy. Think of it as the answer key and the parts bin, not the textbook.

## How to use this repo

Each `chNN-*` folder mirrors exactly what that chapter builds. The convention is the same throughout:

- **`work/`** — the contents that belong in *your* working folder. Copy them into your `~/work/` (preserving the layout). This is where the carried-forward `.claude/` configuration, output files, and scaffolding live. Many artifacts are load-bearing across chapters (Chapter 1's subscription table is still being read in Chapter 20), so keep the folder structure and filenames intact.
- **`work/.claude/`** — the project-level Claude Code configuration (settings, agents, skills, commands, hooks) for that chapter. Copy this into your project's `.claude/` directory to start from the chapter's end-state instead of building it prompt by prompt.
- **`fixtures/`** — safe synthetic stand-in data so you can dry-run a prompt before pointing Claude at your real Gmail, Downloads, or finances. The chapters read *your* private data; fixtures let you rehearse without it.
- **`prompts.md`** — every prompt from the chapter, verbatim and in order (main steps, the "when it goes wrong" recovery prompts, and the make-it-yours variations).
- **`variants/` / `extras/`** — alternate versions and reader options referenced in the chapter.

Workflow: read the chapter, then `git clone` this repo, copy the matching `chNN-*/work/` contents into your `~/work/`, and the chapter's `.claude/` into your project. From there, follow the prompts in the book (or in that folder's `prompts.md`).

## Chapters

| Chapter | What it builds | Folder |
|---|---|---|
| 1 — Read the folder you've been ignoring | Point Claude at a messy folder; get a categorized report, a subscription-leak table, and a duplicate list written to disk (describe pass before move pass). | [`ch01-read-the-folder`](./ch01-read-the-folder) |
| 2 — Reconcile money | Reconcile expenses, customers, and finances across files in your work folder. | [`ch02-reconcile-money`](./ch02-reconcile-money) |
| 3 — Give Claude a memory it actually uses | The six-line `CLAUDE.md` Claude reads at the top of every session, plus the `.claude/` folder anatomy. | [`ch03-claude-md`](./ch03-claude-md) |
| 4 — The three verbs | The core read/write/run verbs and your first slash commands (with frontmatter). | [`ch04-three-verbs`](./ch04-three-verbs) |
| 5 — Wire Claude into your stack | Install five MCPs (Gmail, Calendar, Notion, Slack, Buffer) by plain-English prompt, then a cross-system priorities brief. | [`ch05-mcps`](./ch05-mcps) |
| 6 — Hire your first staff member | Author your first subagent and your first skill by prompting. | [`ch06-subagents-and-skills`](./ch06-subagents-and-skills) |
| 7 — Hooks and scheduling | Two primitives that make Claude work when you're not at the keyboard. | [`ch07-hooks-and-scheduling`](./ch07-hooks-and-scheduling) |
| 8 — Operating safely | The leash you put on before hiring any staff: deny/allow lists and safety guardrails. | [`ch08-operating-safely`](./ch08-operating-safely) |
| 9 — Iris, your inbox-to-system router | A named subagent that reads Gmail + Calendar each morning and routes threads to Notion, drafts, or archive — never sending mail. | [`ch09-iris-inbox-router`](./ch09-iris-inbox-router) |
| 10 — Atlas, your watch on the world | A world-watcher subagent that monitors external signals on a schedule. | [`ch10-atlas-world-watcher`](./ch10-atlas-world-watcher) |
| 11 — Reuben, the bookkeeper | A bookkeeper hire showing how scheduled, data-driven agents are wired together. | [`ch11-reuben-bookkeeper`](./ch11-reuben-bookkeeper) |
| 12 — Echo, the CRM hygienist | A daily CRM-hygiene agent — the fourth staff member of Part III. | [`ch12-echo-crm-hygienist`](./ch12-echo-crm-hygienist) |
| 13 — Your first custom MCP server | Cross from installing other people's MCPs to writing your own. | [`ch13-custom-mcp`](./ch13-custom-mcp) |
| 14 — Your first custom skill | Turn your writing voice into a reusable skill file from three of your own samples. | [`ch14-custom-skill`](./ch14-custom-skill) |
| 15 — The newsroom | A four-agent newsroom: a parent orchestrator coordinating specialist subagents. | [`ch15-newsroom`](./ch15-newsroom) |
| 16 — The launch crew | A five-agent crew under one parent folder that ships a launch. | [`ch16-launch-crew`](./ch16-launch-crew) |
| 17 — The watchdog mesh | A reactive orchestrator that runs on a schedule and dispatches watchdogs. | [`ch17-watchdog-mesh`](./ch17-watchdog-mesh) |
| 18 — The deck your boss asked for | A multi-source deck composer: Claude reads inputs and assembles a presentation. | [`ch18-the-deck`](./ch18-the-deck) |
| 19 — The landing page that converts | A webinar-registration landing page built as two layers. | [`ch19-the-website`](./ch19-the-website) |
| 20 — Browser and computer use | Claude drives a real browser (Claude-in-Chrome MCP) and falls back to computer use. | [`ch20-browser-and-computer-use`](./ch20-browser-and-computer-use) |
| 21 — The dashboard that replaced six browser tabs | A self-refreshing stakeholder dashboard from one static HTML file. | [`ch21-the-dashboard`](./ch21-the-dashboard) |
| 22 — Session mastery and the latest surface | The session command surface: eleven commands and one mindset. | [`ch22-session-mastery`](./ch22-session-mastery) |
| 23 — Code review at home | A personal code-review surface built on top of Claude. | [`ch23-code-review-at-home`](./ch23-code-review-at-home) |
| 24 — Self-improving and the SDK | A self-improving automation loop, a meta-judge agent, and moving scheduled work into CI via the Agent SDK. | [`ch24-self-improving-and-sdk`](./ch24-self-improving-and-sdk) |
| 25 — Your second brain | An llm-wiki: a plain-Markdown knowledge base with Obsidian as the visualizer and Claude as the writer. | [`ch25-second-brain`](./ch25-second-brain) |
| 26 — The Sunday-night governance hour | The closing chapter — no new primitives. Two practices (the weekly governance hour, the three-question rubric for firing an agent) and the two artifacts they produce. | [`ch26-coda`](./ch26-coda) |

A [`cheatsheet`](./cheatsheet) folder collects the quick-reference material.

## Appendices

| Appendix | What it ships | Folder |
|---|---|---|
| A — Prompt library | The 30-prompt library from Appendix A, in copy-pasteable form. | [`appendix-a-prompt-library`](./appendix-a-prompt-library) |
| B — Cost and safety | Reference scripts and configuration for the cost-monitoring and safety conventions in Appendix B. | [`appendix-b-cost-safety`](./appendix-b-cost-safety) |
| C — Plugin marketplace rubric | The Tier 1 / Tier 2 / Tier 3 rubric from Appendix C, as a checklist file. | [`appendix-c-marketplace-rubric`](./appendix-c-marketplace-rubric) |
| F — `settings.json` | One operator's working `~/.claude/settings.json`, comment-free and valid strict JSON, with the annotated walkthrough in Appendix F as its source of truth. | [`appendix-f-settings`](./appendix-f-settings) |

## If you wandered in here as an engineer

This book is written for non-programmers, but the artifacts are real, inspectable code and configuration. For per-chapter detail, read that chapter's own `README.md` — each one documents the files it ships, what's load-bearing across chapters, and where state lives (registry entries and auth tokens deliberately stay out of the repo, in `~/.claude.json` and your OS Keychain). For the architecture view across all 26 chapters — the five extension layers, the three-layer architecture from Ch 24, permission and plan-mode semantics — read [`ENGINEER-GUIDE.md`](./ENGINEER-GUIDE.md) at the root of this repo.

## License

Use freely. The contents of this repo are released under an MIT-style "do what you want, no warranty" grant — copy, adapt, and build on them in your own work.

Attribution: Vikas Sah / Code Coin Cognition LLC.
