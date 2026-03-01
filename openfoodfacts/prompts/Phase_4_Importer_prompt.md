# Codex Prompt — Phase 4: OFF → Canonical Product Transformer + Validation (NO FIRESTORE)

You are working in the KeepItFresh repo under:
- `openfoodfacts/importer/`

Phase 1 contract exists:
- `docs/product_storage_contract_v1.json`

Phase 2 created sample + schema probe:
- `output/off_sample_100.json`
- `output/off_schema_summary.json`
- `output/off_to_product_mapping.md`

Phase 3 created category artifacts:
- `output/categories_preview.json`
- `docs/category_mapping_rules_v1.json`
- `docs/category_taxonomy_v1.md`

Now implement Phase 4:
1) Build a deterministic OFF → Product transformer that outputs canonical Product JSON objects matching the contract.
2) Validate transformed objects using validators.
3) Produce reports of warnings/errors.
NO Firestore code and NO uploads.

---

## Hard constraints
- Do NOT write to Firestore.
- Must be deterministic and reproducible.
- Must not assume OFF field names beyond those observed (use schema probe + mapping docs).
- Must generate outputs to `openfoodfacts/importer/output/`.

---

## Inputs
- OFF sample: `output/off_sample_100.json`
- OFF schema: `output/off_schema_summary.json`
- Canonical contract: `docs/product_storage_contract_v1.json`
- Category mapping rules: `docs/category_mapping_rules_v1.json`
- Categories preview: `output/categories_preview.json` (used as lookup table for subcategory match)

If Phase 1.5 validators exist, use them:
- `src/validation/*`
If not present yet, implement minimal runtime validation in this phase based on the contract JSON (but prefer using the existing validators if they exist).

---

## Outputs (create these files)
1) `output/product_sample_100.json`                 (array of canonical Product JSON)
2) `output/mapping_warnings.md`                     (human readable)
3) `output/validation_report.md`                    (human readable)
4) `output/invalid_products.json`                   (array of {index, productId?, reasons[], offSnippet?})
5) `output/product_transform_stats.json`            (counts + distributions)

Also create source files:
- `src/mapping/off_to_product.ts`
- `src/mapping/off_extractors.ts`
- `src/mapping/off_paths.ts` (auto-derived field paths from schema summary)
- `src/mapping/category_matcher.ts`
- `src/cli/commands/transformSample.ts` (new command: `transform:sample`)

---

## 4.1 OFF field path discovery for mapping (no guessing)
Create `src/mapping/off_paths.ts` that:
- reads `output/off_schema_summary.json`
- extracts candidate field paths for:
  - barcode/code
  - title/product name
  - brand(s)
  - description/generic name
  - storage instructions
  - ingredients text + allergens
  - nutrition/nutriments per 100g/ml
  - serving size
  - quantity
  - images (front/ingredients/nutrition/others)
  - category tags/hierarchy
  - countries/labels/certifications
  - last modified / updated timestamp
- export a structure like:

```ts
export const OffFieldPaths = {
  barcode: ["code", ...],
  title: ["product_name", "product_name_en", ...],
  brands: ["brands", ...],
  ...
}
```


Only include paths that actually exist in the schema summary.
If multiple candidates exist, order by presence frequency (prefer the most common).

# 4.2 Implement OFF extractors (safe getters + parsing)
Create src/mapping/off_extractors.ts with:
* getFirstString(off, paths): string | undefined
* getFirstNumber(off, paths): number | undefined
* getStringArray(off, paths): string[] | undefined
* getNestedObject(off, paths): any | undefined
* getAtPath(off, "a.b.c") helper with safe traversal
* normalizeString(s) helper: trim + whitespace collapse
* parseBarcodeSymbology(value) based on length
* parseQuantityToPackaging(text) → { quantity?, unit?, count?, displayText } best-effort, deterministic
* parseIngredients(text) → string[] conservative split (commas/semicolons; keep phrases)
* parseAllergens(textOrTags) → string[] normalized
* extractNutrition(off):
  * map only what the iOS model supports into NutritionFacts
  * energyKcal, proteinG, fatG, saturatedFatG, carbsG, sugarsG, sodiumMg
  * use per100g/ml fields only when clearly present
  * keep deterministic conversions (e.g., sodium g→mg if source is g and contract allows conversion; otherwise store nothing and warn)

⠀All functions must be pure and testable.

# 4.3 Category matcher (use curated categories + mapping rules)
Create src/mapping/category_matcher.ts:
* Inputs:
  * OFF category signals extracted (tags/paths)
  * docs/category_mapping_rules_v1.json
  * output/categories_preview.json (lookup table)
* Output:
  * ProductCategory with:
    * main (enum string)
    * sub (string | null)
  * plus match metadata (for warnings), e.g. matchedRule, matchedCategoryId

⠀Matching algorithm (deterministic):
1. Apply mainCategoryRules to determine main from any matching tag/path tokens.
2. Determine sub:
   * if subCategoryOverrides match exact offTag/offPath, use that
   * else try to map to categories_preview by:
     * exact match on normalized leaf token
     * synonym match if provided
3. If none matched:
   * main from step 1 or fallback
   * sub = null
   * produce warning: category_unmapped

⠀
# 4.4 Implement main transformer OFF → Product
Create src/mapping/off_to_product.ts exporting:
* transformOffToProduct(off: any, ctx: TransformContext): { product?: ProductJson; warnings: Warning[]; errors: ErrorCode[] }

⠀Rules:
* Output must match the canonical contract (field names, union encoding, enums as strings).
* Populate:
  * productId (barcode preferred, else stable off-based id: off:<sha256(code|name|brand)>)
  * barcode (if present)
  * title, brand, shortDescription, storageInstructions
  * category via category_matcher
  * productDetails:
    * food or beverage when category.main indicates; else other unknown
    * Use union encoding exactly per contract
  * packaging from quantity/serving size when possible
  * images list from OFF image fields (kind mapping)
  * attributes:
    * must include importSource=open_food_facts
    * must include importerVersion=off-importer-v1
    * should include off_code if available
    * optionally include off_url if available
    * include only allowlisted keys and cap values
  * extractionMetadata:
    * extractedAt = now (ISO)
    * extractorVersion = "off-importer-v1"
    * rawSnippets: small snippets (title/brands/categories) NOT the full JSON
  * qualitySignals:
    * hasFrontImage / hasIngredientImage / hasNutritionImage derived from images
    * completenessScore computed deterministically (simple scoring: +points for barcode/title/brand/category/nutrition/images)
    * needsManualReview true if critical fields missing or category.sub missing
  * compliance:
    * marketCountries from OFF countries field if present
    * certifications from labels if present
    * restrictedFlags empty unless obvious signals exist
  * source = "importedFeed"
  * status:
    * "active" if passes minimum criteria
    * otherwise "draft"
  * createdAt/updatedAt:
    * createdAt = now
    * updatedAt = max(now, off last modified if parsed; else now)
  * version = 1

⠀Minimum criteria (deterministic; align with contract):
* active requires: productId + (title OR brand) + category.main not null
* else draft with needsManualReview, OR reject if no identity at all

⠀Produce errors for reject reasons; do not output product if rejected.

# 4.5 Create transform command (transform:sample)
Create src/cli/commands/transformSample.ts and add to CLI:
* Command: transform:sample
* Inputs:
  * --in default output/off_sample_100.json
  * --out default output/product_sample_100.json
* Behavior:
  * load OFF sample array
  * transform each entry
  * write valid products array to out
  * write warnings/errors reports:
    * output/mapping_warnings.md
    * output/product_transform_stats.json
    * output/invalid_products.json

⠀Stats should include:
* totalOffRecords
* transformedProducts
* rejectedProducts
* drafts
* actives
* warningCounts (by code)
* mostCommonMissingFields

⠀
# 4.6 Validation step (validate:products)
Add a CLI command validate:products:
* Input: output/product_sample_100.json
* Uses validators (preferred) or contract-based checks
* Output: output/validation_report.md
* Must list:
  * pass count
  * fail count
  * failures grouped by field
  * show up to 10 example failures (truncated)

⠀Update package.json scripts:
* transform:sample
* validate:products
* phase4 runs: transform:sample -> validate:products

⠀
# Acceptance criteria
* npm run phase4 produces all required outputs.
* Transformed products conform to contract (validated).
* Category mapping uses Phase 3 rules and produces warnings when unmapped.
* No Firestore dependencies or writes exist.
* Outputs are deterministic for a given input sample.

⠀When done, print:
* commands to run Phase 4
* list of generated files
* short note for next phase: Phase 5 (Firestore writer + checkpoint + budget, still dry-run by default).

⠀
#kif/ios/brain
