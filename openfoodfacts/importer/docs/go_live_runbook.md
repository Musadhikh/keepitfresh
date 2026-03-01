# Go-live Runbook

## Preconditions
1. Phase 5 dry-run checks pass on representative data.
2. Rollout plan is generated and reviewed.
3. Firestore credentials are valid.
4. Scheduling is configured but uploads are still disabled.

## Required execute gates
All must be true:
1. CLI `--execute`
2. `IMPORTER_UPLOADS_ENABLED=true`
3. `IMPORTER_EXECUTION_ACK=true`

## One-time categories import (rare)
Run only when taxonomy changed:
```bash
IMPORTER_UPLOADS_ENABLED=true IMPORTER_EXECUTION_ACK=true \
npm run import:categories -- --execute --i-know-what-im-doing
```

## Rollout activation
1. Generate plan:
```bash
npm run rollout:plan -- --activate-from YYYY-MM-DD
```
2. Day 1 dry-run with rollout cap:
```bash
npm run import:products -- --dry-run --rollout --activate-from YYYY-MM-DD --resume
```
3. Day 1 execute (200 writes by default rollout stage):
```bash
IMPORTER_UPLOADS_ENABLED=true IMPORTER_EXECUTION_ACK=true \
FIREBASE_PROJECT_ID=... FIREBASE_SERVICE_ACCOUNT_PATH=... \
npm run import:products -- --execute --rollout --activate-from YYYY-MM-DD --resume
```

## Monitoring after each run
1. Read run report:
   - `output/run_reports/YYYY-MM-DD/run_report.json`
2. Verify checkpoint progression:
   - `output/checkpoint.json` or Firestore checkpoint
3. Run read-only verification:
```bash
npm run verify:run -- --sample-size 10
```

## DO NOT
- Do not keep `IMPORTER_UPLOADS_ENABLED=true` on shared machines by default.
- Do not jump directly to high write caps without ramp.
- Do not run categories execute daily.

