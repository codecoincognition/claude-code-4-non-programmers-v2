# Evaluate-a-marketplace-entry prompt

Paste this into a fresh `claude` session before installing any plugin, skill, or
third-party MCP server. Fill in the bracketed slot with the entry's repo URL or
local path. Claude reads the artifact; you read Claude's one-page report.

---

```
I'm evaluating this before installing it: [PLUGIN / SKILL / MCP URL OR PATH].

Read its manifest, hooks, scripts, and any MCP server config. Produce a report
structured as the 7-point rubric from Appendix C of "Claude Code for
Non-Programmers":

1. Permissions requested (and any wildcard or wide-scope flags)
2. External services or MCPs it calls (with URLs)
3. Hooks installed (event + what they do)
4. Whether it modifies CLAUDE.md or settings.json outside its own folder
5. Update mechanism (auto-update / pinned / unclear)
6. Failure mode if the author's account or repo disappears
7. Whether the core function could be a 30-line local skill instead

Close with: would you install this on your own machine? If no, why not. Be specific.
```

---

## After the report comes back

- The output is one page. You read the report, not the code.
- If any rubric point is flagged, paste that point back to Claude and ask for the
  exact line in the manifest that produced the answer. You should be able to
  verify any concerning answer down to a specific line — without reading the
  surrounding code yourself.
- Cross-check the report against the trust tier you assigned (see `README.md`).

## The 7-point rubric (what each point is really asking)

1. **Permissions.** Network calls? File-system reads/writes? Shell exec? Writes
   outside `.claude/`? A permissive `Bash(*)` (rather than
   `Bash(specific-command:*)`) earns scrutiny.
2. **External services / MCPs.** Names and URLs. A weather plugin calling
   `weather.com` is fine; one also calling `analytics.<unfamiliar-domain>.com`
   is not.
3. **Hooks.** Especially: any `PreToolUse` hook on `Bash`, any `SessionStart`
   hook with network calls, any `Stop` hook that ships session content off-box.
4. **CLAUDE.md / settings.json edits outside its own folder.** Marketplace
   entries should stay in their lane. Out-of-scope edits require deliberate
   consent.
5. **Update mechanism.** Auto-update means the code can change after you trust
   it. Pinned means the bytes you reviewed are the bytes that run.
6. **Failure mode if the author disappears.** Vendors everything locally → fails
   closed. Pulls assets from a remote at runtime → fails open in someone else's
   hands.
7. **Could a 30-line local skill replace it?** Retires more installs than the
   other six combined. Follow-up: *"could you write me the same thing in 30
   lines as a local skill?"*

## Skills-specific shortcut

For a single-file skill, two points carry the weight:

- **Point 1 (permissions):** a skill requesting `Bash` at all is rare — ask why.
- **Point 7:** if it is already a ~30-line skill you can read top-to-bottom, copy
  it straight into `~/work/.claude/skills/` and skip the marketplace layer.

Rule of thumb: under 100 lines and you can name what it does after one read →
install. Sprawls across multiple files with shell scripts → treat as a plugin and
run the full rubric.
