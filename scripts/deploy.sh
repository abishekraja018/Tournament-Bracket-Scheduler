#!/usr/bin/env bash
set -euo pipefail

DIST_DIR="$1"

if [[ ! -d "$DIST_DIR" ]]; then
  echo "Dist folder not found!"
  exit 1
fi

echo "Deploying locally..."

# Kill previous app (if running)
pkill -f "node" || true

# Go to dist and start app
cd "$DIST_DIR"

# Install dependencies if needed
npm install

# Start app in background
nohup npm start > app.log 2>&1 &

echo "App started successfully"