# Full JSONL Category + Storage Review (2026-03-01)

## Run scope
- Source: `openfoodfacts-products.jsonl`
- Mode: offline analysis only (no Firestore writes)
- Total rows in file: `4,290,376`
- Rows iterated: `4,290,376`
- Rows pending: `0`

## Core outcomes
- Rows with category data: `4,290,064`
- Rows matched to curated category: `4,284,801` (`99.87%` of iterated)
- Rows with predicted storage type: `663,302` (`15.46%` of iterated)

## Top category observations
- Most mapped volume is currently under `food/produce` (`58.81%`) and `food/other-food` (`16.10%`).
- Non-inventory-safe semantic/label categories are still present in the taxonomy output (examples: `other/no-gluten`, `other/vegan`, `other/no-gmos`).
- This indicates we should separate **attribute labels** from **inventory category taxonomy** in the next cleanup pass.

## Storage prediction observations
- Predicted storage coverage is concentrated in:
  - `fridge`: `286,467`
  - `shelf`: `153,119`
  - `pantry`: `129,696`
  - `freezer`: `94,020`
- `room_temp` currently has no significant prediction coverage in this run.
- Large portion of rows remain without predicted storage type by design (no fallback to unknown/other).

## Artifacts generated for review
- JSON report: `keepitfresh/openfoodfacts/importer/output/category_storage_audit_full.json`
- Markdown report: `keepitfresh/openfoodfacts/importer/output/category_storage_audit_full.md`

## Suggested next cleanup pass
1. Remove or demote dietary/compliance labels (`vegan`, `no-gluten`, `no-gmos`, etc.) from category candidate sets.
2. Add canonical category routing for high-volume `food/other-food` signals.
3. Expand storage rules to improve coverage for shelf/room-temp candidates without introducing guessed fallbacks.
4. Re-run this same full-file offline audit to compare before/after deltas.
