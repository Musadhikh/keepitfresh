# # Codex Prompt — Add Storage Type Prediction (Phase 4 enhancement, NO FIRESTORE)

You are working in the KeepItFresh repo under:
- `openfoodfacts/importer/`

Context:
- Canonical Product contract: `docs/product_storage_contract_v1.md` + `.json`
- Category curation artifacts: `docs/category_mapping_rules_v1.json`, `output/categories_preview.json`
- OFF → Product transformer: `src/mapping/off_to_product.ts`
- Phase 4 transform command: `transform:sample` produces `output/product_sample_100.json`

## Goal
Add a deterministic **storage type prediction** to the transformer output, based on:
- curated category (main/sub)
- OFF text signals (storage instructions, product name, categories)
- optional packaging hints

Store the predicted storage type in:
- `Product.attributes["storageType"]`
- `Product.attributes["storageTypeConfidence"]` (high|medium|low)
- (optional) `Product.attributes["storageTypeReason"]` (short reason, capped length)

Do NOT add new Swift model fields. Do NOT write to Firestore.

---

## Step 1 — Extend contract docs (platform-agnostic)
Update:
- `openfoodfacts/importer/docs/product_storage_contract_v1.md`
- `openfoodfacts/importer/docs/product_storage_contract_v1.json`

Add a section: **Derived Operational Attributes**
Document that these keys may appear in `attributes`:
- `storageType`: one of `fridge | freezer | shelf | pantry | room_temp | unknown`
- `storageTypeConfidence`: `high | medium | low`
- `storageTypeReason`: short string (<= 120 chars)

Also add to the JSON contract snapshot under constraints/attributesAllowlist:
- allow keys: `storageType`, `storageTypeConfidence`, `storageTypeReason`

Ensure these keys comply with the attributes policy (bounded, query-friendly).

---

## Step 2 — Add rules file for storage prediction (editable)
Create:
- `openfoodfacts/importer/docs/storage_prediction_rules_v1.json`
- `openfoodfacts/importer/docs/storage_prediction_rules_v1.md`

### storage_prediction_rules_v1.json format
```json
{
  "version": 1,
  "storageTypes": ["fridge","freezer","shelf","pantry","room_temp","unknown"],
  "confidenceLevels": ["high","medium","low"],
  "categoryRules": [
    { "matchSubContains": ["frozen"], "storageType": "freezer", "confidence": "high", "reason": "subcategory contains 'frozen'" },
    { "matchSubAny": ["Ice Cream"], "storageType": "freezer", "confidence": "high", "reason": "ice cream is freezer item" },
    { "matchSubAny": ["Meat","Poultry","Seafood","Dairy"], "storageType": "fridge", "confidence": "medium", "reason": "typical refrigerated category" },
    { "matchSubAny": ["Grains","Pasta","Rice","Canned Goods","Snacks","Condiments"], "storageType": "shelf", "confidence": "medium", "reason": "typical shelf-stable category" }
  ],
  "textRules": {
    "freezer": {
      "high": ["keep frozen", "store frozen", "store below -18", "-18°", "frozen"],
      "medium": ["freeze", "freezer"]
    },
    "fridge": {
      "high": ["keep refrigerated", "refrigerate", "store at 4", "store between 0", "chilled"],
      "medium": ["refrigerated", "fridge"]
    },
    "shelf": {
      "high": ["cool dry place", "store in a cool dry place", "room temperature", "ambient"],
      "medium": ["store cool", "keep in a dry place"]
    }
  },
  "fallback": { "storageType": "unknown", "confidence": "low", "reason": "no rule matched" },
  "limits": { "reasonMaxLength": 120 }
}
```


### storage_prediction_rules_v1.md
Explain:
* rule precedence order
* how to tune keywords
* examples
* caution: some fruits/veg may not be fridge (keep simple v1)

⠀
# Step 3 — Implement predictor module
Create:
* openfoodfacts/importer/src/mapping/storage_predictor.ts

⠀Export:
* predictStorageType(input: { product: ProductJson; off?: any; normalizedText?: string }, rules: StorageRules): { storageType: string; confidence: string; reason: string }

⠀Rules precedence (deterministic):
1. **Text rules (high confidence)**:
   * If any high-confidence freezer phrases match → freezer/high
   * Else high-confidence fridge → fridge/high
   * Else high-confidence shelf → shelf/high
2. **Category rules**:
   * If sub contains "frozen" → freezer/high
   * Else match explicit sub lists → medium
3. **Text rules (medium confidence)** (if still unknown)
4. **Fallback** unknown/low

⠀Text sources to scan (concatenate, normalized):
* product.storageInstructions (if any)
* product.title + product.brand
* category signals extracted from OFF (if provided in transformer context)
* optional OFF raw fields that are already used for mapping (only those already extracted; do NOT store raw)

⠀Text normalization:
* lowercase
* collapse whitespace
* remove repeated punctuation
* keep it simple and deterministic

⠀Reason:
* store a short reason from matched rule, truncated to limits.reasonMaxLength

⠀
# Step 4 — Wire into OFF → Product transformer
Update:
* openfoodfacts/importer/src/mapping/off_to_product.ts

⠀After computing:
* title/brand
* category
* storageInstructions (if mapped) Call predictor with:
* product (partial OK as long as title/category/storageInstructions exist)
* off (optional)
* normalizedText built from known extracted strings (do not invent new fields)

⠀Then set:
* product.attributes["storageType"]
* product.attributes["storageTypeConfidence"]
* product.attributes["storageTypeReason"] (optional but recommended)

⠀Ensure:
* attributes remain string->string
* reason is capped
* never overwrite user-provided storageType if it already exists (for future merged flows):
  * only set if attributes["storageType"] is missing OR importer is in "force" mode (not needed now; add TODO)

⠀
# Step 5 — Add tests (lightweight)
Create:
* openfoodfacts/importer/tests/storage_predictor.test.ts

⠀Test cases:
1. title contains "frozen" → freezer/high
2. storage instructions contains "keep refrigerated" → fridge/high
3. subcategory "Frozen Vegetables" → freezer/high
4. subcategory "Pasta" → shelf/medium
5. no signals → unknown/low

⠀Run via your existing test runner (if none, add a minimal one like vitest or node --test). Keep it simple and deterministic.

# Step 6 — Update Phase 4 outputs (reports)
Update transform:sample stats/report generation:
* include distribution counts by storageType
* include % high/medium/low confidence Write to:
* output/product_transform_stats.json (extend)
* output/mapping_warnings.md (add note if storageType unknown)

⠀
# Acceptance criteria
* npm run typecheck passes
* npm run transform:sample includes storageType attributes for most records (based on rules)
* No Firestore code changes
* Contract docs updated to include storageType keys
* Rules are editable via docs/storage_prediction_rules_v1.json
* Tests exist and pass

⠀Do not run uploads. Return once code + docs + tests are created.




#kif/ios/brain