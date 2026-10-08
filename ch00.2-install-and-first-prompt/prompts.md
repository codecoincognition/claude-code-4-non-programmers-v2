# First Three Prompts

These are the prompts Chapter 0.2 walks you through, verbatim and in book order: the install, the three first conversations, the five make-it-yours prompts, and the 60-second self-test.

## Install — paste one command, then type the word

Mac:

```
curl -fsSL https://claude.ai/install.sh | bash
```

Windows (PowerShell):

```
irm https://claude.ai/install.ps1 | iex
```

Then launch Claude and sign in:

```
claude
```

If the install steps have changed, Anthropic's setup guide at `code.claude.com/docs/en/setup` has the current ones.

## Prompt 1 — Make the work folder

```
Make me a folder at ~/work and confirm it's there. From now on this is where I'll keep everything we do together. Once it exists, turn it into a git repository so I have an undo button forever.
```

What this teaches: Claude asks permission before touching your filesystem. Read the path (`~/work`) and the verbs (`mkdir`, `cd`, `git init`), then type `y`.

## Prompt 2 — Claude reads a folder

```
Read everything in my Documents folder. Tell me in plain English what's in there: the kinds of files, anything that looks important, anything that looks like junk. Don't move anything yet, just describe.
```

What this teaches: you did not paste anything. Claude used its Read tool on your actual folder.

## Prompt 3 — Hand Claude a single file with @

```
@~/Downloads/the-real-doc-you-picked.pdf — tell me what this document is in two paragraphs and what it wants me to do.
```

What this teaches: the `@` prefix points Claude at exactly one file. Tip: type `@`, then drag the file from Finder or File Explorer onto the terminal window to drop in its path. If you don't know the path, ask: *"find the document in my downloads called 'something-acme'"*.

---

## Make it yours — five real prompts on real files

```
Read everything in my ~/Desktop folder and tell me what kinds of things are there. Don't move anything yet.
```

```
@~/Downloads/the-PDF-you've-been-meaning-to-read.pdf. Summarize what it is, who sent it, and what it's asking me to do.
```

```
Look at my ~/Documents/ folder. Find every file with the word 'invoice' or 'receipt' in the name. List them with dates and approximate amounts if you can read them.
```

```
Read my last 10 most-recently-modified files in ~/Documents/. Tell me what I've been working on this week.
```

```
@~/the-spreadsheet-you-saved-somewhere.xlsx. Tell me what's in this spreadsheet in plain English: who, what, how many, anything that looks weird.
```

## Test yourself in 60 seconds

```
Confirm you're running in ~/work/ and tell me what's in this folder right now.
```

```
@~/Documents/{any-file-you-have}. Tell me what's in this file in plain English.
```

```
Show me the git log for ~/work/ — confirm this folder is tracked by git and tell me when it was created.
```

Stuck?

```
audit my Chapter 0.2 setup against the chapter spec
```

---

After these, you're ready for Chapter 0.3 (the two safety habits) and then Chapter 1.
