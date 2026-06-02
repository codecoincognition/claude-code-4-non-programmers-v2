# Appendix C — Plugin and Skills marketplace rubric

Companion artifacts for Appendix C of *Claude Code for Non-Programmers*.

The marketplaces (plugins, skills, MCP servers) change fast; *how you evaluate an
entry* changes slowly. This folder is the reusable, paste-ready version of the
appendix's rubric and diagnostic prompt — so you don't have to retype it.

## Files

| File | What it is |
|---|---|
| `evaluate-marketplace-entry.md` | The diagnostic prompt to paste into a fresh `claude` session, plus the 7-point rubric and skills-specific shortcut. |

## How to use it

1. **Assign a trust tier first** (the report only means something against a tier):

   | Tier | Author | Default action |
   |---|---|---|
   | 1 | Anthropic-official | Install. Run the rubric on permissions only. |
   | 2 | Known community author, real GitHub identity, 6+ months of public artifacts | Run the full rubric, then install if it passes. **Pin the version.** |
   | 3 | Unknown author, fresh account, no public footprint | Default no. If you install anyway: rubric + scoped permission profile + revoke-after-one-week reminder. |

2. **Run the prompt** from `evaluate-marketplace-entry.md` with the entry's URL
   or path filled in.

3. **Read the one-page report.** If a point is flagged, ask Claude for the exact
   manifest line behind the answer.

4. For Tier 2 installs, **pin the reviewed version** and note the pin in your
   `settings.json` annotation file (see Appendix F).

## Cross-links

- Authoring your own: Ch 13 (MCP), Ch 14 (skill).
- Scoped permission profiles for Tier 3: the named profiles from Ch 8;
  Appendix F shows the shape.
- Signature verification is complementary, not a substitute — signatures don't
  catch an authentic plugin whose author added telemetry in a later version.
