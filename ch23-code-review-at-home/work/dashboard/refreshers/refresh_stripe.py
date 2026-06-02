#!/usr/bin/env python3
"""refresh_stripe.py — pull Stripe revenue into the dashboard cache.

POST-/batch version: try/except wrapper + sys.exit(1) on failure
(the Python equivalent of `set -euo pipefail`, adapted automatically
by the /batch classifier in Ch 23).
"""
import os
import sys


def main() -> None:
    api_key = os.environ.get("STRIPE_API_KEY")
    if not api_key:
        print("error: STRIPE_API_KEY not set", file=sys.stderr)
        sys.exit(1)

    try:
        # ... call the Stripe API, write to the dashboard cache ...
        # (placeholder for the real refresh logic)
        print("Stripe data refreshed.")
    except Exception as exc:  # noqa: BLE001 — top-level guard
        print(f"error: Stripe refresh failed: {exc}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
