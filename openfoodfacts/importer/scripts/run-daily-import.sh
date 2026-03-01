#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "${ROOT_DIR}"

# Prefer Node 20 via nvm when available.
if [[ -z "${NVM_DIR:-}" && -d "${HOME}/.nvm" ]]; then
  export NVM_DIR="${HOME}/.nvm"
fi
if [[ -n "${NVM_DIR:-}" && -s "${NVM_DIR}/nvm.sh" ]]; then
  # shellcheck disable=SC1090
  source "${NVM_DIR}/nvm.sh"
  nvm use 20 >/dev/null || true
fi

if [[ -f ".env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source ".env"
  set +a
fi

EXECUTE_MODE="false"
MAX_WRITES="${MAX_WRITES_PER_RUN:-10000}"
IMPORT_FILE="${IMPORT_FILE_PATH:-../../../openfoodfacts-products.jsonl}"
MAX_LINES=""
RESUME_FLAG="--resume"
LOCK_PATH="${DAILY_LOCK_FILE_PATH:-output/daily_run.lock}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --execute)
      EXECUTE_MODE="true"
      shift
      ;;
    --max-writes)
      MAX_WRITES="$2"
      shift 2
      ;;
    --file)
      IMPORT_FILE="$2"
      shift 2
      ;;
    --max-lines)
      MAX_LINES="$2"
      shift 2
      ;;
    --resume)
      RESUME_FLAG="--resume"
      shift
      ;;
    --no-resume)
      RESUME_FLAG=""
      shift
      ;;
    *)
      echo "Unknown arg: $1"
      exit 1
      ;;
  esac
done

RUN_DAY="$(TZ=Asia/Singapore date +%F)"
RUN_DIR="output/run_reports/${RUN_DAY}"
LOG_PATH="${RUN_DIR}/daily_run.log"
mkdir -p "${RUN_DIR}"

"${ROOT_DIR}/scripts/preflight.sh" \
  $( [[ "${EXECUTE_MODE}" == "true" ]] && echo "--execute" ) \
  --file "${IMPORT_FILE}" \
  --max-writes "${MAX_WRITES}"

if ( set -o noclobber; > "${LOCK_PATH}" ) 2>/dev/null; then
  cat > "${LOCK_PATH}" <<EOF
pid=$$
startedAt=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
command=$0 $*
hostname=$(hostname)
EOF
else
  echo "ERROR: Lock already exists at ${LOCK_PATH}" | tee -a "${LOG_PATH}"
  exit 1
fi

cleanup() {
  rm -f "${LOCK_PATH}"
}
trap cleanup EXIT INT TERM

CMD=(npm run import:products -- --file "${IMPORT_FILE}" --max-writes "${MAX_WRITES}")
if [[ -n "${MAX_LINES}" ]]; then
  CMD+=(--max-lines "${MAX_LINES}")
fi
if [[ -n "${RESUME_FLAG}" ]]; then
  CMD+=("${RESUME_FLAG}")
fi
if [[ "${EXECUTE_MODE}" == "true" ]]; then
  CMD+=(--execute)
else
  CMD+=(--dry-run)
fi

{
  echo "=== Daily Import Run ==="
  echo "Started: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo "Execute mode: ${EXECUTE_MODE}"
  echo "Import file: ${IMPORT_FILE}"
  echo "Max writes: ${MAX_WRITES}"
  echo "Max lines: ${MAX_LINES:-none}"
  echo "Resume: ${RESUME_FLAG:-disabled}"
  echo "Lock path: ${LOCK_PATH}"
  echo "Command: ${CMD[*]}"
  "${CMD[@]}"
  echo "Finished: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
} >> "${LOG_PATH}" 2>&1

echo "Daily run completed. Log: ${LOG_PATH}"
