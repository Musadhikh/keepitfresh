# Rollback Runbook

## Immediate stop actions
1. Disable scheduled job (launchd/cron).
2. Disable uploads:
   - set `IMPORTER_UPLOADS_ENABLED=false`
3. Remove execute ack:
   - set `IMPORTER_EXECUTION_ACK=false`
4. Resume only in dry-run mode.

## Revert to safe mode
```bash
npm run import:products -- --dry-run --max-writes 500 --resume
```

## Checkpoint handling
- Keep checkpoint intact unless a rollback strategy requires replay from earlier line.
- If checkpoint must be reset, archive existing file first:
```bash
cp output/checkpoint.json output/checkpoint.backup.$(date +%s).json
```

## Quarantine strategy (manual policy)
If bad imports reached remote:
- identify documents by:
  - `source == importedFeed`
  - `attributes.importSource == open_food_facts`
  - time window from run report
- quarantine by status policy (`blocked` or `archived`) through controlled scripts/manual ops.
- Do not run blind mass updates without sample validation.

## Recovery checklist
1. Root-cause issue from run report + logs.
2. Patch importer rules/config.
3. Validate with dry-run and verify report.
4. Re-enable rollout from a lower cap.

