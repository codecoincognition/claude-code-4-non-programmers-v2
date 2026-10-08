# Confirmation PDFs — fixtures note

The chapter files one confirmation PDF per cancellation in this dated folder:

```
hulu-confirmation.pdf
notion-pro-extra-seat-confirmation.pdf
calendly-premium-confirmation.pdf
instacart-express-confirmation.pdf
doordash-dashpass-confirmation.pdf
spotify-family-confirmation.pdf   (replaces the incorrect free-month capture)
adobe-confirmation.pdf            (captured via computer use, not browser MCP)
```

These cannot be shipped in the companion repo: each PDF is a live capture of a
real, logged-in confirmation page from your own account on the day you run the
audit (Hulu, DoorDash, Instacart, etc.). They contain account-specific text and
would be fabricated private data if we synthesized them.

When you run `cancel-leak`, Claude produces them for you:
- Browser-use path: Claude captures the confirmation page as a PDF directly.
- Computer-use path: Claude screenshots (Cmd+Shift+4), opens in Preview, exports PDF.

Each PDF should show the service's "your subscription has been cancelled / will
not renew" page — the evidence that the terminal state is genuinely a cancel and
not a paused/discounted/free-month state.

The two `.md` ledgers and `permissions.log` in this folder ARE shipped, because
they contain only the audit narrative, not private confirmation-page content.
