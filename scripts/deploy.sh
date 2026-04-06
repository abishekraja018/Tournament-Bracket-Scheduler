#!/usr/bin/env bash
set -euo pipefail

DIST_DIR="$1"

if [[ ! -d "$DIST_DIR" ]]; then
  echo "Dist folder not found!"
  exit 1
fi

echo "Deploying locally on port 3000..."

# Kill previous app
fuser -k 3000/tcp || true

cd "$DIST_DIR"

# Use FULL PATH (critical fix)
nohup /usr/local/bin/http-server -p 3000 > app.log 2>&1 &

echo "App started successfully on port 3000"