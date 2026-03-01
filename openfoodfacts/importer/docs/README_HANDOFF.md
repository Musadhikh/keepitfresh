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
