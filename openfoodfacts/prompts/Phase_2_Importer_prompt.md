# # Codex Prompt — Phase 2: OFF JSONL Sampling + Schema Probe + Model Comparison (NO FIRESTORE)

You are working in the KeepItFresh repo. Phase 0 importer scaffold exists at:
- `openfoodfacts/importer/`

Phase 1 created the canonical contract:
- `openfoodfacts/importer/docs/product_storage_contract_v1.md`
- `openfoodfacts/importer/docs/product_storage_contract_v1.json`

Now implement Phase 2: learn Open Food Facts JSONL structure safely, and produce comparison/mapping docs against the canonical Product contract.

## Hard constraints
- Do NOT write to Firestore.
- Do NOT add Firestore admin SDK.
- Must stream-read the JSONL (67GB) without loading into memory.
- Must be tolerant of invalid JSON lines (skip + count).
- Must produce deterministic outputs in `openfoodfacts/importer/output/`.

---

## Inputs
- JSONL file: `openfoodfacts/openfoodfacts-products.jsonl` (or configured via env/CLI)
- Canonical contract JSON: `openfoodfacts/importer/docs/product_storage_contract_v1.json`

If file path differs, support `--file` argument and env `IMPORT_FILE_PATH`.

---

## Outputs (create these files)
1) `openfoodfacts/importer/output/off_sample_100.json`
2) `openfoodfacts/importer/output/off_sample_stats.json`
3) `openfoodfacts/importer/output/off_schema_summary.md`
4) `openfoodfacts/importer/output/off_schema_summary.json`
5) `openfoodfacts/importer/output/model_diff.md`
6) `openfoodfacts/importer/output/off_to_product_mapping.md`

All Phase 2 commands must be runnable via npm scripts.

---

## 2.1 Implement streaming sampler (command: sample)
Enhance/verify `src/cli/commands/sample.ts`:

- Args:
  - `--file` (default from env IMPORT_FILE_PATH)
  - `--count` default 100
  - `--max-lines` optional safety cap (default unlimited)
  - `--out` default `output/off_sample_100.json`
- Behavior:
  - Stream through JSONL line-by-line
  - Parse JSON per line
  - Collect first N VALID objects
  - Write output as a JSON array

Also write stats to `output/off_sample_stats.json`:
- filePath
- totalLinesRead
- validObjects
- invalidLines
- emptyLines
- avgLineBytes
- maxLineBytes
- firstValidLineNumber
- lastValidLineNumber
- startedAt / finishedAt (ISO)
- durationMs

---

## 2.2 Implement schema probe (new command: schema:probe)
Create `src/cli/commands/schemaProbe.ts` (add to CLI and package.json as `schema:probe`)

Input: `output/off_sample_100.json`
Output:
- `output/off_schema_summary.json` (machine-readable)
- `output/off_schema_summary.md` (human-readable)

Schema probe requirements:
- For each top-level key:
  - presence count (out of N)
  - observed types (string/number/object/array/bool/null)
  - example values (at most 2 short samples, truncated)
- For nested objects:
  - recursively summarize keys up to depth 6
  - for arrays:
    - element type distribution
    - if array of objects, summarize object keys
- Include:
  - “Most common keys”
  - “Large fields likely expensive to store”
  - “Candidate category-related fields” (heuristic: keys containing 'category', 'categories', 'tags', 'hierarchy')
  - “Candidate nutrition fields” (heuristic: 'nutri', 'nutrition', 'nutriments')
  - “Candidate image fields” (heuristic: 'image', 'images', 'img')

Markdown should be clear and skimmable.

---

## 2.3 Generate model comparison + mapping docs (new command: compare:contract)
Create `src/cli/commands/compareContract.ts` (add to CLI and package.json as `compare:contract`)

Inputs:
- OFF schema summary: `output/off_schema_summary.json`
- Canonical contract: `docs/product_storage_contract_v1.json`
- OFF sample: `output/off_sample_100.json` (for examples)

Outputs:
- `output/model_diff.md`
- `output/off_to_product_mapping.md`

### model_diff.md requirements
Include sections:
1) Overview
2) Similarities (conceptual matches)
3) Differences / gaps
4) Canonical fields missing in OFF (suggest defaults or leave nil)
5) OFF fields not represented canonically (recommend: map to attributes, ignore, or consider contract update)
6) Risk areas (e.g., large blobs, multilingual, inconsistent tags)

### off_to_product_mapping.md requirements
A deterministic mapping spec structured like:
- Product.productId
- Product.barcode
- Product.title
- Product.brand
- Product.shortDescription
- Product.storageInstructions
- Product.category.main/sub (mention curation-first; fallback rules)
- Product.productDetails (food/beverage mapping; unknown fallback)
- Product.packaging
- Product.images
- Product.attributes (explicit allowlist proposal: `off_*`, `import_*`)
- Product.extractionMetadata
- Product.qualitySignals
- Product.compliance
- Product.source/status/createdAt/updatedAt/version

For each, include:
- candidate OFF field paths (based on schema probe)
- transformation/normalization rules
- fallback behavior
- examples from the sample (extract 1–2 representative snippets, truncated)

Important: DO NOT hardcode assumptions about OFF field names beyond what you observed in the schema probe. Use the schema probe’s keys as source of truth.

---

## 2.4 Wire commands
Update `src/cli/index.ts` to include:
- `schema:probe`
- `compare:contract`

Update `package.json` scripts:
- `schema:probe`
- `compare:contract`
- `phase2` that runs: sample -> schema:probe -> compare:contract

Example:
- `npm run phase2 -- --file ../openfoodfacts-products.jsonl --count 100`

---

## Acceptance criteria
- Phase 2 runs end-to-end without Firestore.
- Sampler uses streaming and works on huge JSONL.
- Schema probe produces both JSON + markdown.
- Mapping docs are generated using observed OFF schema keys (not guesses).
- Outputs land in `openfoodfacts/importer/output/`.

When done, print:
- commands to run Phase 2
- a list of generated output files
- a brief note on next phase: Phase 3 (category curation).

#kif/ios/brain