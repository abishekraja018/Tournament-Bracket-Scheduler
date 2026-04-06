#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <dist-folder>" >&2
    exit 1
fi

DIST_DIR="$1"

if [[ ! -d "${DIST_DIR}" ]]; then
    echo "Deploy folder not found: ${DIST_DIR}" >&2
    exit 1
fi

: "${DEPLOY_HOST:?DEPLOY_HOST is required}"
: "${DEPLOY_USER:?DEPLOY_USER is required}"
: "${DEPLOY_PATH:?DEPLOY_PATH is required}"

SSH_PORT="${SSH_PORT:-22}"

SSH_TARGET="${DEPLOY_USER}@${DEPLOY_HOST}"

ssh -p "${SSH_PORT}" -o StrictHostKeyChecking=no "${SSH_TARGET}" "mkdir -p '${DEPLOY_PATH}'"
tar -C "${DIST_DIR}" -czf - . | ssh -p "${SSH_PORT}" -o StrictHostKeyChecking=no "${SSH_TARGET}" "tar -xzf - -C '${DEPLOY_PATH}'"

echo "Deployment complete: ${SSH_TARGET}:${DEPLOY_PATH}"