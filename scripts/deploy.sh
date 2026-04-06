#!/usr/bin/env bash
set -euo pipefail

DIST_DIR="$1"

if [[ ! -d "$DIST_DIR" ]]; then
  echo "Dist folder not found!"
  exit 1
fi

echo "Deploying locally on port 3000..."

# Kill previous process
fuser -k 3000/tcp || true

cd "$DIST_DIR"

# Start server properly detached
nohup /usr/local/bin/http-server -p 3000 > app.log 2>&1 < /dev/null &

# Wait for startup
sleep 3

# Verify server started
if ! ss -tuln | grep -q 3000; then
  echo "ERROR: App failed to start"
  cat app.log
  exit 1
fi

echo "App started successfully on port 3000"