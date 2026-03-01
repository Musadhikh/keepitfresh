#!/usr/bin/env bash
set -euo pipefail

# Prefer Node 20 via nvm when available.
if [[ -z "${NVM_DIR:-}" && -d "${HOME}/.nvm" ]]; then
  export NVM_DIR="${HOME}/.nvm"
fi
if [[ -n "${NVM_DIR:-}" && -s "${NVM_DIR}/nvm.sh" ]]; then
  # shellcheck disable=SC1090
  source "${NVM_DIR}/nvm.sh"
  nvm use 20 >/dev/null || true
fi

IMPORT_FILE="${IMPORT_FILE_PATH:-../../../openfoodfacts-products.jsonl}"
EXECUTE_MODE="false"
MAX_WRITES="${MAX_WRITES_PER_RUN:-10000}"
BATCH_SIZE="${BATCH_SIZE:-300}"
CHECKPOINT_MODE="${CHECKPOINT_MODE:-file}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --execute)
      EXECUTE_MODE="true"
      shift
      ;;
    --file)
      IMPORT_FILE="$2"
      shift 2
      ;;
    --max-writes)
      MAX_WRITES="$2"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

echo "== Importer Preflight =="
echo "Execute mode: ${EXECUTE_MODE}"
echo "Import file: ${IMPORT_FILE}"
echo "Max writes: ${MAX_WRITES}"
echo "Batch size: ${BATCH_SIZE}"
echo "Checkpoint mode: ${CHECKPOINT_MODE}"
echo "Uploads enabled: ${IMPORTER_UPLOADS_ENABLED:-false}"

NODE_MAJOR="$(node -v | sed -E 's/^v([0-9]+).*/\1/')"
if [[ -z "${NODE_MAJOR}" || "${NODE_MAJOR}" -lt 20 ]]; then
  echo "ERROR: Node.js >= 20 is required."
  exit 1
fi

if [[ ! -d "node_modules" || ! -x "node_modules/.bin/tsx" ]]; then
  echo "ERROR: Dependencies are missing. Run npm install."
  exit 1
fi

if [[ ! -r "${IMPORT_FILE}" ]]; then
  echo "ERROR: Import file is missing or unreadable: ${IMPORT_FILE}"
  exit 1
fi

if [[ "${EXECUTE_MODE}" == "true" ]]; then
  if [[ "${IMPORTER_UPLOADS_ENABLED:-false}" != "true" ]]; then
    echo "ERROR: Execute mode requires IMPORTER_UPLOADS_ENABLED=true"
    exit 1
  fi

  if [[ -z "${FIREBASE_PROJECT_ID:-}" ]]; then
    echo "ERROR: Execute mode requires FIREBASE_PROJECT_ID"
    exit 1
  fi

  if [[ -z "${FIREBASE_SERVICE_ACCOUNT_JSON:-}" && -z "${FIREBASE_SERVICE_ACCOUNT_PATH:-}" ]]; then
    echo "ERROR: Execute mode requires FIREBASE_SERVICE_ACCOUNT_JSON or FIREBASE_SERVICE_ACCOUNT_PATH"
    exit 1
  fi
fi

SYSTEM_TZ="${TZ:-system-default}"
if [[ "${SYSTEM_TZ}" != "Asia/Singapore" ]]; then
  echo "WARN: TZ is '${SYSTEM_TZ}'. Scheduling docs expect Asia/Singapore."
fi

echo "Preflight passed."
