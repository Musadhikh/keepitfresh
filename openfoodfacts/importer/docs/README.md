# OpenFoodFacts Importer Docs

## Contract files
- `product_storage_contract_v1.md`: human-readable canonical Product storage contract.
- `product_storage_contract_v1.json`: machine-readable snapshot for validators/tooling.

## Category curation files
- `category_taxonomy_v1.md`: curation-first taxonomy policy.
- `category_mapping_rules_v1.json`: editable mapping rules and overrides.
- `storage_prediction_rules_v1.json`: deterministic storage type prediction rules.
- `storage_prediction_rules_v1.md`: storage prediction precedence and tuning notes.
- `operations_runbook.md`: daily importer operations and failure handling.
- `scheduling.md`: launchd/cron setup at 07:00 Asia/Singapore.
- `go_live_runbook.md`: execute-mode rollout and verification checklist.
- `rollback_runbook.md`: stop, quarantine, and safe recovery workflow.

## Who uses this
- Importers: shape payloads, normalize safely, apply validation/reject codes, and enforce idempotency.
- Clients (iOS/Android/Web): parse a stable cross-platform schema and enum values.

## Usage expectations
- Importers must follow contract field names and enum strings exactly.
- Clients must be forward-compatible for newly added optional fields.
- Breaking schema changes require a new contract version (`v2`).

## Change process (v2 proposal)
1. Propose change with rationale + compatibility analysis.
2. Add new files (`product_storage_contract_v2.md` + `.json`).
3. Keep v1 intact for migration period.
4. Update importer/client rollout plan and deprecation timeline.

Rule: never break existing clients with in-place incompatible changes.

## Commands
```bash
cd openfoodfacts/importer
npm run sample -- --file ../../../openfoodfacts-products.jsonl --count 100 --max-lines 5000
npm run schema:probe
npm run compare:contract
npm run phase2 -- --file ../../../openfoodfacts-products.jsonl --count 3000 --max-lines 300000

npm run categories:signals -- --file ../../../openfoodfacts-products.jsonl --max-lines 300000 --min-count 10
npm run categories:build -- --min-count 50 --out output/categories_preview.json
npm run phase3 -- --file ../../../openfoodfacts-products.jsonl --max-lines 300000 --min-count 10

npm run transform:sample -- --in output/off_sample_100.json --out output/product_sample_100.json
npm run validate:products -- --in output/product_sample_100.json --out output/validation_report.md
npm run phase4 -- --in output/off_sample_100.json --out output/product_sample_100.json
```
