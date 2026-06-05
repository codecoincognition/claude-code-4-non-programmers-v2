#!/usr/bin/env bash
#
# atlas-watch.sh — Atlas's nightly pass, scripted edition.
#
# This is the deterministic skeleton the Atlas agent wraps around.
# It walks ~/work/atlas/sources.md, fetches each source, saves a
# snapshot under ~/work/atlas/snapshots/{today}/, and writes a
# bare-bones signal file noting which sources changed against the
# snapshot from {today - 7}. The Atlas agent reads this output,
# applies the source-completeness check and the
# two-consecutive-confirmation rule, and writes the human-facing
# narrative on top.
#
# Why a script underneath an agent? The walk-fetch-diff loop is
# deterministic plumbing. The judgment ("is a 12% price cut a real
# signal or a captcha artifact?") is the agent's job. Separating
# them keeps the agent focused on judgment, and keeps the plumbing
# auditable in plain bash.
#
# Usage:
#   atlas-watch.sh                       # real run, today vs. today-7
#   atlas-watch.sh --use-fixtures DATE   # offline replay against the
#                                        # fixtures in snapshots/DATE/
#
set -uo pipefail

ATLAS_ROOT="${ATLAS_ROOT:-${HOME}/work/atlas}"
SOURCES="${ATLAS_ROOT}/sources.md"
TODAY="$(date +%Y-%m-%d)"
LAST_WEEK="$(date -v-7d +%Y-%m-%d 2>/dev/null || date -d '7 days ago' +%Y-%m-%d)"

# --use-fixtures lets the chapter walk-through reproduce the
# canonical 2026-05-14 diff without a live network round-trip.
USE_FIXTURES=""
if [[ "${1:-}" == "--use-fixtures" ]]; then
  USE_FIXTURES="${2:-2026-05-14}"
  TODAY="$USE_FIXTURES"
  LAST_WEEK="$(date -v-7d -j -f %Y-%m-%d "$USE_FIXTURES" +%Y-%m-%d 2>/dev/null \
               || date -d "$USE_FIXTURES -7 days" +%Y-%m-%d)"
fi

TODAY_DIR="${ATLAS_ROOT}/snapshots/${TODAY}"
LAST_DIR="${ATLAS_ROOT}/snapshots/${LAST_WEEK}"
SIGNAL_FILE="${ATLAS_ROOT}/signals-${TODAY}.md"

mkdir -p "$TODAY_DIR"

[[ -f "$SOURCES" ]] || { echo "Missing watchlist: $SOURCES" >&2; exit 1; }

# Slugify a name for use as a filename.
slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | tr -c '[:alnum:]' '-' | sed 's/-\{1,\}/-/g; s/^-//; s/-$//'
}

# Fetch a URL into a snapshot file. In a real run this uses curl;
# in --use-fixtures mode we skip the fetch and trust the existing
# file on disk.
fetch_url() {
  local url="$1" outfile="$2"
  if [[ -n "$USE_FIXTURES" ]]; then
    [[ -f "$outfile" ]] || echo "fixture missing: $outfile" >&2
    return 0
  fi
  curl --silent --show-error --max-time 30 \
       --user-agent "atlas-watch/1.0 (Maya's world-watcher)" \
       --output "$outfile" "$url" || {
    echo "fetch failed: $url" >&2
    return 1
  }
}

# Diff two snapshot files. Returns 0 if identical, 1 if different,
# 2 if last-week's file is missing (baseline run).
diff_snapshots() {
  local today_file="$1" last_file="$2"
  [[ -f "$last_file" ]] || return 2
  diff -q "$today_file" "$last_file" >/dev/null 2>&1 && return 0 || return 1
}

# Initialize the signal file.
{
  echo "# Atlas — ${TODAY}"
  echo ""
  if [[ ! -d "$LAST_DIR" ]]; then
    echo "Baseline run — no snapshot at ${LAST_WEEK} to diff against."
    echo "Next run will diff against ${TODAY}."
    echo ""
  fi
} > "$SIGNAL_FILE"

MOVED=0
QUIET=0
BASELINE=0

# Walk sources.md. Lines starting with "- " inside a section are
# entries. We accept three shapes:
#   - Pricing:  "- Acme | https://acme.example.com/pricing | ..."
#   - Releases: "- vercel/next.js | the framework our stack runs on"
#   - RSS:      "- Stratechery | https://stratechery.com/feed/"
SECTION=""
while IFS= read -r line; do
  case "$line" in
    "## Pricing pages") SECTION="pricing"; continue ;;
    "## Release feeds"*) SECTION="releases"; continue ;;
    "## RSS feeds") SECTION="rss"; continue ;;
  esac
  [[ "$line" == "- "* ]] || continue
  [[ -z "$SECTION" ]] && continue

  # Strip "- " prefix.
  entry="${line#- }"
  name="${entry%%|*}"; name="${name%"${name##*[![:space:]]}"}"
  rest="${entry#*|}"
  url="${rest%%|*}";   url="${url#"${url%%[![:space:]]*}"}"; url="${url%"${url##*[![:space:]]}"}"

  slug="$(slugify "$name")"
  case "$SECTION" in
    pricing)  ext="html"; target="${url}" ;;
    releases) ext="json"; slug="$(slugify "${name//\//-}")-releases"; target="https://api.github.com/repos/${name}/releases" ;;
    rss)      ext="xml";  slug="${slug}-feed"; target="${url}" ;;
  esac

  today_file="${TODAY_DIR}/${slug}.${ext}"
  last_file="${LAST_DIR}/${slug}.${ext}"

  fetch_url "$target" "$today_file" || { echo "- ${name}: fetch failed." >> "$SIGNAL_FILE"; continue; }

  diff_snapshots "$today_file" "$last_file"
  case $? in
    0) QUIET=$((QUIET+1));   echo "- ${name}: no change." >> "$SIGNAL_FILE" ;;
    1) MOVED=$((MOVED+1));   echo "- **${name}: moved** vs. ${LAST_WEEK}. (see ${today_file#${HOME}/}, ${last_file#${HOME}/})" >> "$SIGNAL_FILE" ;;
    2) BASELINE=$((BASELINE+1)); echo "- ${name}: baseline captured (no last-week snapshot)." >> "$SIGNAL_FILE" ;;
  esac
done < "$SOURCES"

# Summary footer.
{
  echo ""
  echo "## Run summary"
  echo "- moved:     $MOVED"
  echo "- quiet:     $QUIET"
  echo "- baseline:  $BASELINE"
} >> "$SIGNAL_FILE"

# The Atlas agent reads this file next and decides what (if
# anything) to escalate. The script never DMs anyone.
echo "Wrote ${SIGNAL_FILE}"
