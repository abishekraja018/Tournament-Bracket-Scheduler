#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="${ROOT_DIR}/dist"

rm -rf "${DIST_DIR}"
mkdir -p "${DIST_DIR}"

shopt -s dotglob
for item in "${ROOT_DIR}"/*; do
    base_name="$(basename "${item}")"

    case "${base_name}" in
        dist|scripts|Jenkinsfile)
            continue
            ;;
    esac

    cp -R "${item}" "${DIST_DIR}/"
done

echo "Build complete: ${DIST_DIR}"