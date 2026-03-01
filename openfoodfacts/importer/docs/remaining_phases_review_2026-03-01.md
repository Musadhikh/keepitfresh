# Remaining Phase Review (as of 2026-03-01)

This document compares the remaining prompts (`Phase_6_Importer_prompt.md`, `Phase_7_Importer_prompt.md`) with the current importer state and proposes a safe implementation order.

## Current baseline snapshot

Implemented already:
- Phase 1-5 pipeline (sample/schema/compare/category build/transform/import flows).
- Firestore integration, batching, budget, checkpoint, run reports.
- Category refinement and canonical food/beverage mapping.
- Phase 4 enhancement: deterministic storage type prediction (`attributes.storageType*`), contract updates, predictor tests.

Not implemented yet:
- Scheduling assets and operational scripts from Phase 6.
- Concurrency lock utility and lock wiring in import commands.
- Phase 7 rollout plan command and rollout caps.
- Execute third-gate (`IMPORTER_EXECUTION_ACK`).
- Categories rare-run guard flag.
- Go-live/rollback runbooks.

## Prompt compatibility notes

## Phase 6 prompt compatibility

Safe to apply largely as-is, with these adjustments:

1. `src/firestore/README.md` is stale.
- It still says placeholders/stubs, but Firestore is real now.
- Update while implementing Phase 6 to avoid operational confusion.

2. CLI defaults in `src/cli/index.ts` still use `../openfoodfacts-products.jsonl` in some commands.
- Package scripts/env currently use `../../../openfoodfacts-products.jsonl`.
- Align defaults while doing Phase 6 (preflight + runner should use one canonical path source).

3. Phase 6 says "Do NOT run imports".
- Keep implementation-only in that phase branch; run smoke checks only for shell syntax/typecheck unless explicitly requested.

## Phase 7 prompt compatibility

Phase 7 needs targeted adjustments before implementation:

1. Execute gate count
- Prompt assumes two existing execute gates then adds a third.
- Current code already has:
  - `--execute` flag wiring
  - `IMPORTER_UPLOADS_ENABLED=true`
  - Firebase credential checks in execute mode
- Add `IMPORTER_EXECUTION_ACK=true` as an extra explicit approval gate (good and compatible).

2. Storage type wording in older prompts/examples
- Some older prompt text references `unknown` storage type fallback.
- Current agreed behavior is: if unpredicted, omit `storageType` fields entirely.
- Keep current behavior; do not reintroduce `unknown`.

3. Categories execute guard
- Add `--i-know-what-im-doing` for `importCategories --execute` exactly as prompt asks.
- This is compatible and recommended.

4. Verify run command
- Add read-only verify command, but keep it lightweight and sample-based (no full collection scans).
- Compatible with current report/checkpoint model.

## Safe execution order

1. **Phase 6 first (operations/scheduling/lock)**
- Add scripts, schedule templates, lock utility, docs.
- Wire lock into `importProducts` and `importCategories`.
- Update handoff docs and stale Firestore README.

2. **Phase 7 second (rollout + execute hardening)**
- Add rollout model + `rollout:plan` command.
- Add rollout flags/cap logic in `importProducts`.
- Add `IMPORTER_EXECUTION_ACK` gate.
- Add categories rare-run guard.
- Add go-live and rollback runbooks.

3. **Final consolidation pass**
- Align default file paths across CLI/env/scripts/docs.
- Ensure examples in docs use current no-unknown storage behavior.
- Re-run typecheck + tests + dry-run validation.

## Concrete pre-implementation checklist

- [ ] Add `IMPORTER_EXECUTION_ACK=false` to `.env.example`.
- [ ] Add/standardize `LOCK_FILE_PATH` config if needed (default `output/import.lock`).
- [ ] Ensure `run-daily-import.sh` defaults to dry-run and only passes `--execute` when explicit.
- [ ] Ensure lock release is in shell `trap` and Node command `finally`.
- [ ] Confirm all docs reference:
  - execute requires `--execute` + `IMPORTER_UPLOADS_ENABLED=true` + `IMPORTER_EXECUTION_ACK=true`
  - unpredicted storage => omit storage attributes.

## Suggested acceptance checks after both phases

1. `npm run typecheck`
2. `npm run test`
3. `npm run rollout:plan`
4. `npm run import:products -- --dry-run --rollout --activate-from YYYY-MM-DD --max-lines 5000`
5. Verify:
- lock blocks concurrent run
- rollout cap is logged and enforced
- run report + checkpoint written
- no execute path triggered unless all three gates are set

