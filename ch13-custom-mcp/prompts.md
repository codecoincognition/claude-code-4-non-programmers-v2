# Chapter 13 — prompts, verbatim and in order

Every prompt the chapter has you run, copy-paste ready.

## Half one — read one before you write one

### Step 1 — Look at the source for a small, real MCP

```
Open the source for Anthropic's official filesystem MCP server — the reference one — and show me the file tree.
```

### Step 2 — Annotate the manifest and save the annotation

```
Walk me through the package.json — what's it telling Claude Code about this MCP? Annotate every line in plain English and save the annotated version to ~/work/notes/filesystem-mcp-annotated.md so I can come back to it.
```

### Step 3 — Walk through one tool handler

```
Show me one of the tool functions — pick the simplest one. Annotate it plainly: what does it take in, what does it send back?
```

## Half two — write your own

### Step 4 — Scaffold the personal-data MCP

```
OK — I've read one. Now I want to scaffold my own. Make a new MCP server at ~/work/mcp-servers/personal-data/ that reads a CSV at ~/work/data/campaigns.csv and exposes three tools: list_records (returns all rows), find_record (takes a campaign name, returns one row), summarize_records (returns count + date range + a one-line stat). Mirror the structure of the filesystem MCP — same files, same shape, smaller scope. Make it runnable. Three tool functions, plus a README.
```

### Step 5 — Recognize the shapes from what you just read

```
Read me back what you wrote — show me the manifest first, then the three tool handlers one at a time. I want to recognize the shapes from the filesystem MCP we just read.
```

### Step 6 — Install your MCP with claude mcp add

```
Install personal-data. Use claude mcp add to register it from this folder.
```

```
Show me the MCP list now.
```

### Step 7 — Prove it works

```
Use the personal-data MCP to summarize my campaigns CSV.
```

## When it goes wrong

```
Calling summarize_records returns no records, but the CSV has 47 rows in it — I just opened it. Run the server and show me what it's actually doing — what path is it trying to read? Then fix the path handling so ~ resolves to my home directory inside the handler.
```

### Step 8 — Forward-pointer to the newsroom

```
Tell me, in one sentence, what the newsroom in Chapter 15 will be able to do with this MCP that it couldn't do without it.
```

## Make it yours — five follow-ups

**1. A fourth tool.**

```
Add a fourth tool to my personal-data MCP: find_records_by_tag that takes a tag string and returns all matching rows. Mirror the shape of find_record.
```

**2. CSV to SQLite.**

```
Convert my personal-data MCP from CSV to SQLite — same three tools, same shape, different storage. Walk me through the migration.
```

**3. Wrap your notes folder.**

```
Wrap my ~/work/notes/ folder as an MCP — three tools: list_notes, read_note, append_to_note. Mirror the personal-data structure. Use the read-then-write pattern: read the filesystem MCP again first, then scaffold.
```

**4. Audit your security.**

```
Audit my custom MCP for security — what's the failure surface if Claude calls a tool with malicious input? Add input validation where it's missing.
```

**5. Compare manifests.**

```
Show me, side by side, the manifest of my personal-data MCP and the manifest of @modelcontextprotocol/server-filesystem. What's the same, what's different, why.
```

## Test yourself (chapter-end)

```
Run claude mcp list and confirm personal-data shows up alongside the five from Chapter 5.
```

```
Summarize my campaigns. (Confirm Claude routes through personal-data without you naming it.)
```

```
Open ~/work/mcp-servers/personal-data/package.json and explain what each top-level field does in one phrase.
```

```
Audit my Chapter 13 setup against the chapter spec.
```
