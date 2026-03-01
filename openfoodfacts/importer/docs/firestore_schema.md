# Firestore Schema (Phase 5)

## Collections

### ProductCatalog
- Document ID: `productId`
- Upsert mode: `set(..., { merge: true })`
- Payload: canonical Product JSON from `product_storage_contract_v1.json`

### ProductCategories
- Document ID: category slug (`<main>/<sub-slug>`)
- Upsert mode: `set(..., { merge: true })`
- Payload fields:
  - `id`
  - `main`
  - `sub`
  - `tags`
  - `synonyms`
  - `hierarchyPath`
  - `sourceHints.openFoodFacts.tags`
  - `sourceHints.openFoodFacts.paths`
  - `version`
  - `createdAt`
  - `updatedAt`

### ImportCheckpoints (optional, CHECKPOINT_MODE=firestore)
- Document ID: `CHECKPOINT_DOC_ID` (default `off_import_checkpoint`)
- Payload:
  - `filePath`
  - `updatedAt`
  - `mode` (`products` or `categories`)
  - `lineNumber`
  - `bytesOffset` (optional)
  - `lastProductId` (optional)
  - `totals.scanned`
  - `totals.written`
  - `totals.skipped`
  - `totals.rejected`

### ImportRuns (planned)
- Not written in Phase 5 by default.
- Local run reports are currently primary source under `output/run_reports/YYYY-MM-DD/`.
- Future remote report doc (`ImportRuns/{yyyy-mm-dd}`) should mirror local run report schema.
