# # Codex Prompt — Phase 1: Canonical Product Storage Contract + Platform-Agnostic Specs (NO UPLOADS)

You are working in the KeepItFresh repo. Phase 0 scaffold exists at:
- `openfoodfacts/importer/`

## Goal (Phase 1)
Create a **platform-agnostic canonical storage contract** for Product data that all importers and all clients (iOS/Android/Web) can follow.

This contract is based on the iOS ProductModule Swift model and will define:
- canonical Firestore/JSON shape
- invariants & normalization rules
- provenance rules (including `open_food_facts`)
- category policy (curation-first)
- validation rules for active/draft/skip
- versioning/idempotency guidance

Do NOT upload anything to Firestore. Do NOT add Firestore code. Docs only in this phase.

---

## Inputs (canonical Swift model)
Use these files as the canonical source of truth:
- `/Users/musadhikhmuhammed/Projects/Personal/Github/KeepItFresh/keepitfresh/iOS/Packages/ProductModule/Sources/ProductDomain/Models/Product.swift`
- `/Users/musadhikhmuhammed/Projects/Personal/Github/KeepItFresh/keepitfresh/iOS/Packages/ProductModule/Sources/ProductDomain/Models/ProductDetails.swift`
- `/Users/musadhikhmuhammed/Projects/Personal/Github/KeepItFresh/keepitfresh/iOS/Packages/ProductModule/Sources/ProductDomain/Models/ProductSupportingTypes.swift`
- `/Users/musadhikhmuhammed/Projects/Personal/Github/KeepItFresh/keepitfresh/iOS/Packages/ProductModule/Sources/ProductDomain/Models/Barcode.swift`
- `/Users/musadhikhmuhammed/Projects/Personal/Github/KeepItFresh/keepitfresh/iOS/Packages/ProductModule/Sources/ProductDomain/Models/ProductCategory.swift`

If any of these paths differ in your workspace, locate them via repo search using filenames and module path hints above.

Also use this Swift model excerpt as a reference for intent (do not assume it is exhaustive; verify with source files):

[PASTE THE USER’S SWIFT SNIPPET HERE EXACTLY]

---

## Output location
Write documentation into:

openfoodfacts/importer/docs/

Create these new files:

1) `openfoodfacts/importer/docs/product_storage_contract_v1.md`
2) `openfoodfacts/importer/docs/product_storage_contract_v1.json`  (machine-readable schema snapshot)
3) `openfoodfacts/importer/docs/README.md` (how to use / change management)

---

## 1) product_storage_contract_v1.md (requirements)

### 1.1 Purpose + scope
- State this is the single source of truth for Firestore representation of Product records.
- Explicitly: platform-agnostic, used by importers + clients.

### 1.2 Canonical Firestore document layout
Define collections used by this pipeline (even if not implemented yet):
- `ProductCatalog` (products)
- `ProductCategories` (curated taxonomy)

For `ProductCatalog`, define the exact canonical JSON document shape corresponding to ProductModule.Product.

Include a section: **"Canonical JSON Field List"**
For each field include:
- name
- type
- required/optional
- constraints
- defaulting behavior if missing

### 1.3 Enum serialization rules
Specify how enums are stored as strings:
- ProductSource values
- ProductStatus values
- Barcode.Symbology
- ProductCategory.MainCategory
- ProductPackaging.Unit
- ProductImage.Kind

List exact allowed string values.

### 1.4 Union encoding for ProductDetails
Define one canonical JSON encoding for `ProductDetails` that is friendly to all platforms.

Choose ONE representation and document it clearly:

Option A (recommended):
```json
"productDetails": { "kind": "food", "value": { ... } }
```

Option B:
```json
"productDetails": { "food": { ... } }
```

Pick one, and use it consistently in all examples and in the JSON snapshot file.
Also document how nil optional associated values are represented (e.g. allow value to be null).
### 1.5 Identity + idempotency
Define:
* productId rules (preferred barcode; fallback stable source-prefixed)
* Firestore docId rule: docId == productId (recommended)
* dedup rules across sources
* “changed-only writes” strategy via stable content hash (to reduce writes)

⠀1.6 Provenance / source policy
Your Swift enum only has .importedFeed, so encode specific feed source as attributes:
* source = "importedFeed"
* attributes.importSource = "open_food_facts"

⠀Also define reserved attribute namespaces:
* off_* for Open Food Facts
* import_* for importer metadata
* x_* for experimental keys

⠀Define required provenance keys for imported products:
* attributes.importSource
* attributes.importerVersion
* attributes.importedAt
* attributes.off_code (if present) (If contract decides some are optional, document it.)

⠀1.7 Validation rules + status assignment
Define minimum acceptance criteria:
* what fields needed for status=active
* when to mark draft + needsManualReview=true
* when to skip/reject record

⠀Include a “Reject reasons” section (deterministic codes), e.g.
* missing_identity
* invalid_barcode
* missing_title_and_brand
* invalid_nutrition etc.

⠀1.8 Normalization rules
Define safe normalizations (deterministic):
* trimming/collapsing whitespace for strings
* brand/title normalization guidelines
* packaging parsing guidelines and unit mapping
* ingredients splitting rules (conservative)
* nutrition unit normalization (only where safe)

⠀1.9 Categories policy (curation-first)
Define the taxonomy structure for ProductCategories docs:
* id slug
* main/sub
* tags/synonyms/hierarchyPath
* sourceHints.openFoodFacts (tags/paths) Define mapping rules: how importer assigns Product.category.main/sub using curated categories, and fallback behavior.

⠀1.10 Quality signals policy
Define deterministic calculation rules for:
* completenessScore (if feed lacks, compute)
* hasFrontImage/hasIngredientImage/hasNutritionImage
* needsManualReview triggers

⠀1.11 Versioning policy
Define version meaning:
* record version vs schema version
* recommended bump rules on contract changes
* forward compatibility rules for clients

⠀1.12 Examples (must include 3)
Include JSON examples that match your chosen union encoding:
1. minimal valid product
2. full food product with nutrition + images
3. draft product missing barcode (or missing some required field) + needsManualReview

⠀Examples must align with the machine-readable schema snapshot.

### 2) product_storage_contract_v1.json (machine-readable snapshot)
Create a machine-readable file that a validator can consume later.
Format:
```json
{
"contractVersion": "1",
"updatedAt": "ISO-8601",
"productDetailsEncoding": "kind_value",
"collections": {
"ProductCatalog": { "fields": [ ... ] },
"ProductCategories": { "fields": [ ... ] }
},
"enums": { ... },
"constraints": { ... },
"examples": { ... }
}
```
* Under ProductCatalog.fields include full nested field definitions (name, type, optional, constraints).
* Include enum string values.
* Include example objects (same as the markdown examples).

⠀
# 3) docs/README.md
Write a short doc describing:
* what the contract is
* how importers should use it
* how clients should use it (Android/iOS)
* how to propose changes (v2 process)
* rule: never break clients; add fields in backward-compatible way

⠀
# Acceptance criteria
* The markdown contract matches actual Swift source files (validate field names and enum cases).
* The JSON snapshot is consistent with the markdown.
* No Firestore code changes are made.
* No upload logic is added.

⠀When complete:
* List the created files
* Provide cat/open commands to inspect them
* Provide a short “next step” note: Phase 1.5 will generate validators from the JSON snapshot.

⠀





#kif/ios/brain