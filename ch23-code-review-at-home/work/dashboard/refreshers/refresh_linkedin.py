#!/usr/bin/env python3
"""refresh_linkedin.py — pull LinkedIn analytics into the dashboard cache.

POST-/batch version: try/except wrapper + sys.exit(1) on failure
(Python equivalent of `set -euo pipefail`, adapted by /batch in Ch 23).
"""
import sys


def main() -> None:
    try:
        # ... pull LinkedIn analytics, write to the dashboard cache ...
        print("LinkedIn data refreshed.")
    except Exception as exc:  # noqa: BLE001 — top-level guard
        print(f"error: LinkedIn refresh failed: {exc}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
