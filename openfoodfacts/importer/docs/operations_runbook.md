# Operations Runbook

## Safety defaults
- Import commands are dry-run by default.
- Execute mode still requires explicit gates:
  - CLI: `--execute`
  - env: `IMPORTER_UPLOADS_ENABLED=true`
  - env: `IMPORTER_EXECUTION_ACK=true`
- Concurrency lock prevents overlapping runs via `output/import.lock`.

## Daily checklist
1. Confirm source file path is correct and readable.
2. Confirm checkpoint state (`output/checkpoint.json`) is expected.
3. Confirm no stale lock (`output/import.lock`).
4. Run preflight:
   - `./scripts/preflight.sh --file ../../../openfoodfacts-products.jsonl`
5. Run daily dry-run:
   - `./scripts/run-daily-import.sh`
6. Review run report:
   - `output/run_reports/YYYY-MM-DD/run_report.json`
   - `output/run_reports/YYYY-MM-DD/run_report.md`
   - `output/run_reports/YYYY-MM-DD/daily_run.log`

## Manual run commands

Dry-run:
```bash
./scripts/run-daily-import.sh --file ../../../openfoodfacts-products.jsonl --max-writes 10000 --resume
```

Execute (only when intended):
```bash
IMPORTER_UPLOADS_ENABLED=true \
IMPORTER_EXECUTION_ACK=true \
FIREBASE_PROJECT_ID=... \
FIREBASE_SERVICE_ACCOUNT_PATH=... \
./scripts/run-daily-import.sh --execute --file ../../../openfoodfacts-products.jsonl --max-writes 1000 --resume
```

## Interpreting reports
- `stopReason`:
  - `completed`: finished requested range.
  - `budget_reached`: write cap reached safely.
  - `max_lines_reached`: line cap reached.
- `warningCounts`: quality and mapping warnings.
- `checkpoint.lineNumber`: safe resume position.

## Common failure modes

1. Quota/resource exhaustion
- Symptoms: retryable Firestore errors in logs.
- Action: reduce `--max-writes`, retry with `--resume`.

2. Invalid credentials
- Symptoms: execute mode fails at startup.
- Action: verify `FIREBASE_PROJECT_ID` and service-account env vars.

3. JSONL parse anomalies
- Symptoms: parse/reject spikes.
- Action: inspect `output/invalid_products.json`, run smaller dry-run slice.

4. Lock file stuck
- Symptoms: command refuses to run due to existing lock.
- Action:
  1. verify no importer process is active
  2. remove stale lock: `rm -f output/import.lock`
  3. rerun command

## Resume safely
- Use `--resume` (default true).
- Verify checkpoint file/doc matches expected source file.
- Continue with capped writes before full volume.

## Stop a run
- Stop current process (`Ctrl+C` for foreground or kill PID).
- Confirm lock file is removed (daily script handles this via trap).

## Categories import policy
- Categories should be imported rarely (weekly/monthly) and only after taxonomy changes.
- Daily schedules should run products import only.
- Execute mode requires explicit acknowledgement flag:
  - `--i-know-what-im-doing`

## Phase 7 rollout mode
- Generate rollout plan:
```bash
npm run rollout:plan -- --activate-from YYYY-MM-DD
```
- Use rollout cap during import:
```bash
npm run import:products -- --dry-run --rollout --activate-from YYYY-MM-DD --resume
```
- See:
  - `docs/go_live_runbook.md`
  - `docs/rollback_runbook.md`

## Log retention
- Rotate logs periodically:
```bash
./scripts/rotate-logs.sh 30
```
