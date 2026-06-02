# Chapter 25 — prompts, verbatim and in order

Every prompt the chapter has you give Claude, in the order they appear.

---

## Step 1 — Scaffold the brain

Open Claude in your work folder:

```
cd ~/work && claude
```

Then:

```
Scaffold a Markdown knowledge base at ~/work/brain/. Create:

- projects/ with one seeded sub-folder: projects/dashboard/ (the Ch 21 dashboard), containing README.md, decisions/, runbooks/, debug-log.md
- concepts/ (empty for now)
- patterns/ (empty for now)
- README.md at brain/ root explaining the system

In projects/dashboard/README.md, write a one-paragraph project summary based on what we built in Chapter 21 — what it shows, where the data comes from, how often it refreshes.

In projects/dashboard/decisions/, scaffold one ADR using the template: date, status, context, decision, consequences, and a [[links]] block. Use a real decision from the dashboard build (e.g., why we picked Chart.js over D3).

In projects/dashboard/runbooks/, scaffold one runbook: how the daily refresh actually runs, what to check if it fails.

In projects/dashboard/debug-log.md, scaffold the format with one example entry from a real glitch the dashboard hit during build.

In every file you write, add [[wikilinks]] to other entries you know about — Obsidian will render the graph view from them.

Show me the plan first.
```

---

## Step 3 — Log the first real decision

```
Log this decision as an ADR in brain/projects/{project}/decisions/. Date is today. Status: accepted.

Context: [paste the situation — 2-3 sentences]
Decision: [what you chose]
Consequences: [what you gave up, what you won]

Add [[wikilinks]] to any other brain entries this connects to — patterns, concepts, runbooks, other decisions. If the project folder doesn't exist yet, ask before creating it.
```

---

## When it goes wrong — orphan entries (recovery prompt)

```
Read every file in ~/work/brain/. For each orphan (a file with no incoming or outgoing [[wikilinks]]), suggest 2-3 relevant entries it should link to and propose the wikilinks to add. Show me the plan; don't edit yet.
```

Wrong-folder fix:

```
move this to brain/projects/{right-project}/decisions/; preserve the wikilinks; update any inbound links from other entries.
```

---

## The lift — prompt grammar

```
Log this as a {decision | runbook | pattern | concept} in brain/{path}. Add [[wikilinks]] to related entries you know about. Show me the file before saving.
```

---

## Make it yours — five variations

**1. Add a research/ folder for articles you've read.**

```
Add ~/work/brain/research/ for articles I've read. When I drop a PDF or paste an article URL, save it as Markdown with a header (date, source, why I'm keeping it, three tags). Add [[wikilinks]] to relevant concepts/ and patterns/. If the article belongs to a specific project, link from that project's README too.
```

**2. Reshape projects/ for a consulting practice.**

```
Rename projects/ to clients/. Each client is a folder with README, decisions/, deliverables/, runbooks/. Use Acme (Ch 18 deck client) and my own consulting site (Ch 19) as the seed clients. Migrate the dashboard entry from projects/ into clients/{your-firm}/.
```

**3. The Sunday review (optional hook).**

```
Add a SessionStart hook in ~/work/.claude/settings.json that fires only on Sundays. When it fires, list three brain entries from this week that gained the most new [[wikilinks]], and one entry that hasn't been linked to anything yet (so I can either link it or delete it).
```

**4. Backlink-aware writing.**

```
Whenever I open Claude in ~/work/, before answering anything else, glance at brain/ for entries with [[wikilinks]] pointing to the topic in my prompt. Use them as context. Don't paste their contents into your response; just consult them.
```

**5. Publish a public subset.**

```
Add a publish-public skill: when I tag an entry with public-ok, copy a sanitized version (strip client names, people identifiers) to ~/work/website/posts/. The Chapter 19 website rebuild hook picks it up automatically. The brain stays private; the deliberate subset becomes blog posts.
```

---

## Test yourself in 60 seconds

```
Log a decision I made this week as an ADR in brain/projects/{project}/decisions/. Add [[wikilinks]] to anything relevant.
```

```
Open Obsidian, switch to graph view, and verify the new ADR is connected to at least one other node.
```

```
Scan brain/ for orphan files and propose [[wikilinks]] to fix them.
```

Stuck?

```
audit my Chapter 25 setup against the chapter spec
```
