# Template fixtures — what the .pptx inputs look like

The chapter reads two PowerPoint files from this folder:

- `board-deck.pptx` — the **company template**. Claude reads it to
  extract slide masters, fonts, and the brand color palette, then
  renders the new deck against it.
- `board-deck-may-2026.pptx` — the **previous (May) board deck**.
  Built on the same template, 11 slides. Claude reads it for visual
  rhythm and for "same format as last time" cues.

We do **not** ship binary .pptx files in this repo — they are
specific to your company's brand. Instead, here is the shape Claude
reads so you can drop in your own.

## What Claude extracts from `board-deck.pptx`

```
6 slide masters detected:
  1. title master
  2. content master
  3. content + image master
  4. two-column comparison master   <- used for slide 7
  5. section-divider master
  6. title master (alt / thank-you)

Fonts:  Inter (heading) / Source Sans 3 (body)
Colors: #0F172A (primary)
        #2563EB (accent)
        #94A3B8 (mute)
```

## To use with your own brand

1. Drop your company's `.pptx` template into this folder as
   `board-deck.pptx`.
2. Drop your most recent prior deck as `board-deck-may-2026.pptx`
   (or rename the references in the prompts to match your file).
3. The `/deck` command at `../.claude/commands/deck.md` reads
   whatever is here — no code change needed.

## Charts

The chapter renders charts in **matplotlib** at 1920x1080 and
embeds them as PNG images (not native python-pptx chart objects),
so they render identically on every machine and honor the full
styling palette. The trade: you re-prompt Claude to edit a chart
rather than editing it inside PowerPoint.
