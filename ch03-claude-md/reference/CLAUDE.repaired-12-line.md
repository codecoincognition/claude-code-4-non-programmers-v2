# CLAUDE.md — Maya's, repaired after the 47-line bloat
#
# The "When it goes wrong" section of Chapter 3: Maya grew her file to 47
# lines by copying Reddit templates, Claude got WORSE, and the litmus test
# cut it back down. 35 lines failed; 12 survived: the original 6 plus 6
# genuine additions that had been buried in the noise.
#
# The chapter names two of the six genuine additions verbatim (the diff
# rule and the dollar-source rule). The remaining four shown below are
# faithful, litmus-passing examples in Maya's situation — edit to fit yours.
# The point is the SIZE and the DISCIPLINE, not these exact extra lines.

# Behavioral (from forrestchang/andrej-karpathy-skills, ~60K stars)
1. Don't assume. Don't hide confusion. Surface tradeoffs.
2. Minimum code that solves the problem. Nothing speculative.
3. Touch only what you must. Clean up only your own mess.
4. Define success criteria. Loop until verified.

# Contextual (mine)
5. I run a small marketing consulting firm. My work folder is ~/work/. My finance data is in ~/work/finance/.
6. Never edit anything outside ~/work/. Never send a client email — only draft. If you're about to do something irreversible, ask first.

# Genuine additions that survived the litmus test (named in the chapter)
7. Never quote dollar amounts without their source.
8. Always show me a diff — a side-by-side of exactly what will change — before editing files in ~/work/finance/.

# Genuine additions (faithful examples — would each cause a real mistake if removed)
9. Vendor categories live in ~/work/vendor-categories.md — read it before categorizing, and append new rules there instead of asking me twice.
10. Dana is my co-founder; when a task involves her, treat shared finance files as jointly owned — don't move or rename them without asking.
11. Reconciliation output is one clean file per period — don't append a TL;DR or a "sources:" footer unless I ask.
12. When a number doesn't tie out, stop and tell me the gap — don't silently pick the figure that looks right.
