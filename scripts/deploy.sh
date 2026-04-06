#!/usr/bin/env bash
set -euo pipefail

DIST_DIR="$1"

# Validate input
if [[ ! -d "$DIST_DIR" ]]; then
  echo "Dist folder not found!"
  exit 1
fi

echo "Deploying locally on port 3000..."

# Kill any existing app on port 3000
fuser -k 3000/tcp || true

# Move to build directory
cd "$DIST_DIR"

# Prevent Jenkins from killing the process
export BUILD_ID=dontKillMe

# Start server in background (fully detached)
nohup /usr/local/bin/http-server -p 3000 > app.log 2>&1 < /dev/null &

# Wait for server to start
sleep 3

# Verify server is running
if ss -tuln | grep -q ":3000"; then
  echo "App started successfully on port 3000"
else
  echo "ERROR: App failed to start"
  echo "---- Logs ----"
  cat app.log
  exit 1
fi