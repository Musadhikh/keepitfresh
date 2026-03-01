# # Codex Prompt — Phase 3: Category Curation Pipeline (Curate FIRST, NO FIRESTORE WRITES)

You are working in the KeepItFresh repo under:
- `openfoodfacts/importer/`

Phase 2 already generates:
- `output/off_sample_100.json`
- `output/off_schema_summary.json`
- `output/off_schema_summary.md`
- `output/off_to_product_mapping.md`

Phase 1 contract exists:
- `docs/product_storage_contract_v1.json`

Now implement Phase 3: **curate Product Categories first** from the OpenFoodFacts JSONL feed.
This phase MUST NOT write to Firestore yet. It only builds category signals, a curated taxonomy preview, and editable mapping rules.

## Hard constraints
- Do NOT write to Firestore.
- Must stream-read the huge JSONL safely (67GB).
- Must be deterministic and reproducible.
- Must generate outputs to `openfoodfacts/importer/output/` and docs to `openfoodfacts/importer/docs/`.

---

## Inputs
- JSONL file path via `--file` or env `IMPORT_FILE_PATH`
- Contract: `docs/product_storage_contract_v1.json`
- Schema probe: `output/off_schema_summary.json` (use it to find actual category-related keys; do not guess)
- Optional: `--max-lines` to cap scanning (default 200000 lines, configurable)

---

## Outputs (create these files)
### Signals & analysis (output/)
1) `output/category_signals.json`
2) `output/category_signals.md`

### Curated taxonomy preview (output/)
3) `output/categories_preview.json`
4) `output/categories_preview.md`

### Editable mapping rules (docs/)
5) `docs/category_taxonomy_v1.md`
6) `docs/category_mapping_rules_v1.json`  (machine-readable rules + overrides)

All Phase 3 commands must be runnable via npm scripts and CLI.

---

## 3.1 Discover category fields (from schema probe)
Create `src/categories/discovery.ts`:
- Input: `output/off_schema_summary.json`
- Output: a list of candidate OFF field paths that are category-related, using heuristics:
  - key contains: category, categories, tags, hierarchy, group, label, department, aisle
- Prefer keys with high presence frequency.
- Store selected paths in-memory and include them in reports.

---

## 3.2 Extract category signals (stream JSONL, command: categories:signals)
Create a new CLI command:
- `src/cli/commands/categorySignals.ts`
- Add to CLI as `categories:signals`
- Add npm script: `categories:signals`

Args:
- `--file` (default env IMPORT_FILE_PATH)
- `--max-lines` default 200000
- `--min-count` default 10 (only keep signals seen >= this many times)
- `--out` default `output/category_signals.json`

Behavior:
- Stream through JSONL up to max-lines
- For each record:
  - Extract category-like values from the discovered field paths
  - Normalize each signal:
    - lowercase
    - trim
    - collapse whitespace
    - replace separators with `/` where appropriate
  - Collect counts:
    - raw tag counts
    - hierarchy/path counts (if present)
    - co-occurrence (optional but useful): (tagA, tagB) frequency
- Track how many records contributed any categories.

Write `output/category_signals.json` with structure like:
```json
{
  "scannedLines": 200000,
  "recordsWithCategoryData": 123456,
  "discoveredFieldPaths": ["categories_tags", "categories_hierarchy", ...],
  "signals": {
    "tags": [{ "value": "beverages", "count": 12345 }, ...],
    "paths": [{ "value": "food/beverages/tea", "count": 2345 }, ...]
  },
  "notes": { "truncated": true/false }
}
```

Write output/category_signals.md summarizing:
* scan config + stats
* discovered field paths
* top 50 tags
* top 50 hierarchy paths
* “messy signals” section (very long values, language variants)
* recommended next steps

⠀
# 3.3 Build curated taxonomy preview (command: categories:build)
Create:
* src/cli/commands/buildCategories.ts (replace placeholder from Phase 0; make it real)
* Add npm script: categories:build

⠀Inputs:
* output/category_signals.json
* docs/product_storage_contract_v1.json (for allowed MainCategory enum values)

⠀Args:
* --min-count default 50 (categories below this stay as “candidates” list)
* --out default output/categories_preview.json

⠀Behavior:
* Produce a curated list of ProductCategories documents for Firestore.
* Canonical doc shape (must match contract + your earlier plan):
  * id (slug, stable)
  * main (one of: food, beverage, household, personalCare, medicine, electronics, pet, other)
  * sub (string)
  * tags (string[])
  * synonyms (string[])
  * hierarchyPath (string[])
  * sourceHints:
    * openFoodFacts:
      * tags (string[])
      * paths (string[])
  * version (int, start 1)
  * createdAt / updatedAt (ISO strings in preview)
* Deterministic slugging rules:
  * id = "<main>/<sub-slug>" OR <main>/<group>/<sub-slug> if you choose 3-level paths
  * Use safe ASCII slug (kebab-case), no random IDs.

⠀How to assign main and sub (Phase 3 heuristic)
You will not have perfect mapping yet. Implement a **rules-based first pass**:
* Determine main from keywords in tags/paths:
  * beverage: contains "beverages", "drinks", "tea", "coffee", "juice", "soda", "water"
  * food: contains "foods", "snacks", "meals", "bread", "dairy", "meat", "fruits", "vegetables"
  * household: contains "cleaning", "detergent", "laundry", "home-care"
  * personalCare: contains "cosmetics", "skin-care", "shampoo", "toothpaste"
  * pet: contains "pet", "cat", "dog"
  * medicine: contains "supplement", "vitamin", "medicine" (be conservative)
  * electronics: contains "battery", "charger" (rare in OFF)
* Otherwise other.

⠀Pick sub from the most specific stable leaf in a hierarchy path when available, else from the tag itself.
Important:
* Keep this mapping transparent and editable (next step).

⠀Write output/categories_preview.md:
* Buckets by main
* Top proposed subcategories
* Coverage estimate (% of scanned records mapped)
* “Unmapped/messy” list
* Recommended manual edits

⠀
# 3.4 Generate editable mapping rules (docs/category_mapping_rules_v1.json)
Create docs/category_mapping_rules_v1.json that will be used later by the product mapper:
Structure:
```json
{
"version": 1,
"mainCategoryRules": [
{ "matchAny": ["beverages", "drinks", "tea"], "main": "beverage" },
{ "matchAny": ["foods", "snacks", "dairy"], "main": "food" }
],
"subCategoryOverrides": [
{ "offTag": "black-teas", "sub": "Tea" },
{ "offPath": "en:beverages/en:tea", "sub": "Tea" }
],
"synonyms": [
{ "value": "soft-drinks", "synonyms": ["soda", "pop"] }
],
"fallback": { "main": "other", "sub": null }
}
```
Also write docs/category_taxonomy_v1.md:
* describes how to edit mapping rules
* defines slug rules
* explains how categories_preview is generated
* explains how importer will use curated categories + mapping rules

⠀
# 3.5 Wire commands
Update src/cli/index.ts to include:
* categories:signals
* categories:build

⠀Update package.json scripts:
* categories:signals
* categories:build
* phase3 that runs signals then build:
  * npm run categories:signals -- --file ... --max-lines 200000
  * npm run categories:build

⠀
# Acceptance criteria
* Phase 3 runs without Firestore.
* Category signals are derived from **observed** OFF schema keys (via Phase 2 schema probe), not hardcoded guesses.
* Categories preview is deterministic.
* Mapping rules are generated and are editable.
* Outputs and docs are created exactly at required paths.

⠀When done, print:
* commands to run Phase 3
* list of generated files
* short note for next phase: Phase 4 (OFF -> Product transformer using curated categories + contract).


#kif/ios/brain