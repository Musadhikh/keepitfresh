#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "${ROOT_DIR}"

KEEP_DAYS="${1:-30}"
RUN_REPORTS_DIR="output/run_reports"

if [[ ! -d "${RUN_REPORTS_DIR}" ]]; then
  echo "No run_reports directory found. Nothing to rotate."
  exit 0
fi

echo "Rotating logs under ${RUN_REPORTS_DIR}; keeping last ${KEEP_DAYS} days."
find "${RUN_REPORTS_DIR}" -mindepth 1 -maxdepth 1 -type d -mtime +"${KEEP_DAYS}" -print -exec rm -rf {} +
echo "Log rotation complete."

