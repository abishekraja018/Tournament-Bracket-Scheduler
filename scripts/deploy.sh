#!/usr/bin/env bash
set -euo pipefail

DIST_DIR="$1"

if [[ ! -d "$DIST_DIR" ]]; then
  echo "Dist folder not found!"
  exit 1
fi

echo "Deploying locally on port 3000..."

# Kill previous app running on port 3000
fuser -k 3000/tcp || true

# Move into build folder
cd "$DIST_DIR"

# Install http-server globally if not installed
if ! command -v http-server &> /dev/null
then
  echo "Installing http-server..."
  sudo npm install -g http-server
fi

# Start server on port 3000 in background
nohup http-server -p 3000 > app.log 2>&1 &

echo "App started successfully on port 3000"