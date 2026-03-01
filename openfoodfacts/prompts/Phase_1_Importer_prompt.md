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


#kif/ios/brain