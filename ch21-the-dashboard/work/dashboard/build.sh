#!/usr/bin/env bash
# Nightly dashboard build. Refresh six sources, regenerate
# index.html, deploy to Vercel.

cd ~/work/dashboard
LOG=~/work/dashboard/dashboard-deploy.log
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "" >> $LOG
echo "==== build $TS ====" >> $LOG

# Run each refresher; on failure, keep the last snapshot and log.
for src in stripe ga linkedin bank notion nps; do
  if ! bash refreshers/$src.sh 2>>$LOG; then
    echo "$src ✗ ERROR — using last snapshot" >> $LOG
  fi
done

# Regenerate index.html from the six JSON snapshots.
# claude --print runs a one-shot prompt: read the template, read
# each snapshot, fill the template, write index.html.
claude --print --no-interactive < templates/build-prompt.md \
  > index.html 2>>$LOG

# Deploy to Vercel. Capture the deploy URL into the log.
vercel deploy --prod --yes >> $LOG 2>&1

echo "build done $TS" >> $LOG
