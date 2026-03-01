# Importer Handoff Runbook

## Prerequisites
- Node.js 20+
- Access to `openfoodfacts-products.jsonl`
- Local `.env` from `.env.example`
- For execute mode only:
  - `IMPORTER_UPLOADS_ENABLED=true`
  - `FIREBASE_PROJECT_ID`
  - `FIREBASE_SERVICE_ACCOUNT_JSON` or `FIREBASE_SERVICE_ACCOUNT_PATH`

## Core commands
- `npm run typecheck`
- `npm run phase2 -- --file ../../../openfoodfacts-products.jsonl --count 3000 --max-lines 300000`
- `npm run phase3 -- --file ../../../openfoodfacts-products.jsonl --max-lines 300000 --min-count 10`
- `npm run phase4 -- --in output/off_sample_100.json --out output/product_sample_100.json`
  - Phase 4 includes deterministic storage type prediction in `attributes` when possible.

## Phase 5 dry-run usage
- Categories:
  - `npm run import:categories -- --in output/categories_preview.json --dry-run`
- Products:
  - `npm run import:products -- --file ../../../openfoodfacts-products.jsonl --dry-run --max-lines 5000 --max-writes 1000 --resume`
- Shortcut:
  - `npm run phase5:dryrun`

## Execute mode (manual gate)
Run only when both are true:
1. CLI uses `--execute`
2. env has `IMPORTER_UPLOADS_ENABLED=true`

Examples:
- `IMPORTER_UPLOADS_ENABLED=true npm run import:categories -- --execute`
- `IMPORTER_UPLOADS_ENABLED=true npm run import:products -- --file ../../../openfoodfacts-products.jsonl --execute --max-writes 10000 --resume`

## Checkpoint behavior
- Default mode: file checkpoint at `output/checkpoint.json`
- Optional mode: firestore checkpoint via `CHECKPOINT_MODE=firestore`
- Resume behavior:
  - importer loads checkpoint
  - skips to saved line number
  - saves periodic and final checkpoints

## Run reports
Per-run reports are written to:
- `output/run_reports/YYYY-MM-DD/run_report.json`
- `output/run_reports/YYYY-MM-DD/run_report.md`
- `output/run_reports/YYYY-MM-DD/warnings.json` (when warnings exist)

Phase 4 artifacts also include:
- `output/product_transform_stats.json` with storage type/confidence distributions
- `output/mapping_warnings.md` with unpredicted storage note

## Troubleshooting
- If execute mode fails immediately, verify upload gate + Firebase creds env values.
- If importer stops early, check `stopReason` in run report (budget or max-lines).
- For long runs, use `--resume` with checkpoint file/firestore mode.

## Phase 6 scheduling + operations
- Daily runner script:
  - `scripts/run-daily-import.sh` (dry-run default)
- Preflight checks:
  - `scripts/preflight.sh`
- Log maintenance:
  - `scripts/rotate-logs.sh`
- Schedule templates:
  - macOS: `schedule/macos/com.keepitfresh.openfoodfacts.importer.plist`
  - Linux: `schedule/linux/cron.sample`

## Handoff essentials
- Checkpoint location:
  - file mode: `output/checkpoint.json`
  - firestore mode: `ImportCheckpoints/{CHECKPOINT_DOC_ID}`
- Run reports:
  - `output/run_reports/YYYY-MM-DD/run_report.json`
  - `output/run_reports/YYYY-MM-DD/run_report.md`
  - `output/run_reports/YYYY-MM-DD/daily_run.log` (runner logs)
- Progress tracker:
  - `output/progress/progress_state.json`
  - `output/progress/progress_card.md`
- If failures occur:
  1. inspect run report `stopReason` + warning counts
  2. inspect lock file `output/import.lock`
  3. rerun with smaller `--max-writes` and `--resume`

## Phase 7 rollout + safety
- Rollout plan preview:
  - `npm run rollout:plan -- --activate-from YYYY-MM-DD`
  - outputs:
    - `output/rollout/rollout_plan.json`
    - `output/rollout/rollout_plan.md`
- Rollout-enforced import:
  - `npm run import:products -- --dry-run --rollout --activate-from YYYY-MM-DD --resume`
- Execute mode now needs 3 gates:
  1. CLI `--execute`
  2. `IMPORTER_UPLOADS_ENABLED=true`
  3. `IMPORTER_EXECUTION_ACK=true`
- Read-only verification:
  - `npm run verify:run -- --sample-size 10`
