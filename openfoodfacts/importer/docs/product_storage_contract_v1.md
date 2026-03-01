# Product Storage Contract v1

## 1.1 Purpose + scope
This document is the single source of truth for Firestore/JSON representation of Product records in KeepItFresh.

- Platform-agnostic: shared by importers and clients (iOS/Android/Web).
- Based on canonical Swift source:
  - `iOS/Packages/ProductModule/Sources/ProductDomain/Models/Product.swift`
  - `ProductDetails.swift`, `ProductSupportingTypes.swift`, `Barcode.swift`, `ProductCategory.swift`
- Scope:
  - canonical JSON shape
  - normalization + invariants
  - provenance/source policy for imported feeds
  - category curation policy
  - validation and reject reasons
  - versioning and idempotency

## 1.2 Canonical Firestore document layout

Collections:
- `ProductCatalog`: product documents
- `ProductCategories`: curated taxonomy and mapping hints

Recommended ProductCatalog document id rule:
- `docId == productId`

### Canonical ProductCatalog JSON shape
```json
{
  "productId": "string",
  "barcode": {
    "value": "string",
    "symbology": "ean13|ean8|upc_a|upc_e|qr|code128|unknown"
  },
  "title": "string",
  "brand": "string",
  "shortDescription": "string",
  "storageInstructions": "string",
  "category": {
    "main": "food|beverage|household|personalCare|medicine|electronics|pet|other",
    "sub": "string"
  },
  "productDetails": {
    "kind": "food|beverage|household|personalCare|other",
    "value": {}
  },
  "packaging": {
    "quantity": 0,
    "unit": "g|kg|ml|l|oz|lb|count|unknown",
    "count": 0,
    "displayText": "string"
  },
  "size": "string",
  "images": [
    {
      "id": "string",
      "urlString": "string",
      "localAssetId": "string",
      "kind": "front|back|label|nutrition|ingredients|other",
      "width": 0,
      "height": 0
    }
  ],
  "attributes": {
    "importSource": "open_food_facts",
    "importerVersion": "string",
    "importedAt": "ISO-8601 datetime",
    "off_code": "string",
    "off_*": "string",
    "import_*": "string",
    "x_*": "string"
  },
  "extractionMetadata": {
    "extractedAt": "ISO-8601 datetime",
    "extractorVersion": "string",
    "fieldConfidence": {
      "field": 0.0
    },
    "rawSnippets": ["string"]
  },
  "qualitySignals": {
    "completenessScore": 0.0,
    "needsManualReview": false,
    "hasFrontImage": false,
    "hasIngredientImage": false,
    "hasNutritionImage": false
  },
  "compliance": {
    "marketCountries": ["string"],
    "restrictedFlags": ["string"],
    "certifications": ["string"]
  },
  "source": "manual|barcodeLookup|aiExtraction|importedFeed|merged",
  "status": "active|draft|archived|blocked",
  "createdAt": "ISO-8601 datetime",
  "updatedAt": "ISO-8601 datetime",
  "version": 1
}
```

### Canonical JSON Field List

| Field | Type | Required | Constraints | Default if missing |
|---|---|---:|---|---|
| `productId` | string | Yes | non-empty, trimmed, stable | reject (`missing_identity`) |
| `barcode` | object | No | if present: `value` + `symbology` | omit |
| `barcode.value` | string | No | uppercase alphanumeric | omit |
| `barcode.symbology` | enum string | No | allowed enum values only | `unknown` if `barcode` exists but value invalid |
| `title` | string | No | trimmed | omit |
| `brand` | string | No | trimmed | omit |
| `shortDescription` | string | No | trimmed | omit |
| `storageInstructions` | string | No | trimmed | omit |
| `category` | object | No | `main` enum, optional `sub` | omit |
| `productDetails` | object | No | tagged union (`kind`,`value`) | omit |
| `packaging` | object | No | numeric bounds and unit enum | omit |
| `size` | string | No | trimmed | omit |
| `images` | array | Yes | canonical image objects; no nulls | `[]` |
| `attributes` | map<string,string> | Yes | reserved namespaces policy | `{}` |
| `extractionMetadata` | object | No | confidence values in [0,1] | omit |
| `qualitySignals` | object | No | deterministic computation policy | omit |
| `compliance` | object | No | arrays of strings | omit |
| `source` | enum string | Yes | allowed source values | importer default `importedFeed` for OFF |
| `status` | enum string | Yes | allowed status values | `draft` during uncertain imports |
| `createdAt` | ISO datetime | Yes | immutable create time | import time |
| `updatedAt` | ISO datetime | Yes | monotonic update time | import/write time |
| `version` | integer | Yes | >=1; monotonic | 1 |

## 1.3 Enum serialization rules
All enums are serialized as strings.

### ProductSource
- `manual`
- `barcodeLookup`
- `aiExtraction`
- `importedFeed`
- `merged`

### ProductStatus
- `active`
- `draft`
- `archived`
- `blocked`

### Barcode.Symbology
- `ean13`
- `ean8`
- `upc_a`
- `upc_e`
- `qr`
- `code128`
- `unknown`

### ProductCategory.MainCategory
- `food`
- `beverage`
- `household`
- `personalCare`
- `medicine`
- `electronics`
- `pet`
- `other`

### ProductPackaging.Unit
- `g`
- `kg`
- `ml`
- `l`
- `oz`
- `lb`
- `count`
- `unknown`

### ProductImage.Kind
- `front`
- `back`
- `label`
- `nutrition`
- `ingredients`
- `other`

## 1.4 Union encoding for ProductDetails
Chosen representation: **kind/value** (Option A)

```json
"productDetails": { "kind": "food", "value": { "ingredients": ["water"] } }
```

- `kind` is required when `productDetails` is present.
- `value` can be `null` (maps to optional associated value in Swift enum case).
- `kind` to payload:
  - `food` / `beverage` -> `FoodDetails`
  - `household` -> `HouseholdDetails`
  - `personalCare` -> `PersonalCareDetails`
  - `other` -> `UnknownDetails`

## 1.5 Identity + idempotency

### productId rules
Priority:
1. normalized barcode value (preferred)
2. stable source-prefixed fallback: `off:<off_code>`
3. if neither exists -> reject

### dedup across sources
- Deduplicate by `productId`.
- Keep latest canonical fields by merge policy.
- Preserve source-specific payloads under `attributes` namespaces.

### changed-only writes strategy
- Compute stable content hash from canonical payload.
- Store hash in `attributes.import_contentHash`.
- If incoming hash equals stored hash, skip write.

## 1.6 Provenance / source policy
For Open Food Facts imports:
- `source = "importedFeed"`
- `attributes.importSource = "open_food_facts"`

Reserved attributes namespaces:
- `off_*`: Open Food Facts raw/carried metadata
- `import_*`: importer metadata and control fields
- `x_*`: experimental/non-contract keys

Required provenance keys for imported products:
- `attributes.importSource`
- `attributes.importerVersion`
- `attributes.importedAt`
- `attributes.off_code` (if OFF code present upstream)

## 1.7 Validation rules + status assignment

### status = active
Minimum:
- valid identity (`productId`)
- valid enums
- at least one of:
  - `title`, or
  - `barcode`

### status = draft + qualitySignals.needsManualReview = true
Use when record is structurally valid but confidence/completeness is low:
- missing both `title` and `brand`
- sparse key fields
- uncertain category mapping

### skip/reject (not persisted)
Reject reasons (deterministic codes):
- `missing_identity`
- `invalid_barcode`
- `missing_title_and_brand`
- `invalid_enum_value`
- `invalid_nutrition`
- `invalid_payload_shape`

## 1.8 Normalization rules
Deterministic and safe only:
- Strings: trim, collapse internal repeated whitespace.
- `title`/`brand`: preserve original casing; do not title-case aggressively.
- Packaging:
  - parse obvious number+unit patterns only
  - map units to canonical enum (`g`,`kg`,`ml`,`l`,`oz`,`lb`,`count`)
  - unknown/ambiguous -> `unit=unknown`
- Ingredients splitting:
  - split only on safe delimiters (`;`, `,`) when unambiguous
  - otherwise keep as single string in details/attributes
- Nutrition normalization:
  - normalize known units where explicit and safe
  - never infer unsupported unit conversions

## 1.9 Categories policy (curation-first)
Do not trust raw OFF category strings directly.

### ProductCategories document structure
```json
{
  "id": "slug-string",
  "main": "food|beverage|household|personalCare|medicine|electronics|pet|other",
  "sub": "string",
  "tags": ["string"],
  "synonyms": ["string"],
  "hierarchyPath": "string",
  "sourceHints": {
    "openFoodFacts": {
      "tags": ["string"],
      "paths": ["string"]
    }
  }
}
```

Mapping behavior:
1. match curated `ProductCategories` entries
2. set `category.main/sub` from curated match
3. fallback: `main=other`, `sub=nil`
4. retain raw OFF category signals in `attributes.off_*`

## 1.10 Quality signals policy
Deterministic rules:
- `hasFrontImage`: true if any image `kind=front` or mapped front image candidate exists.
- `hasIngredientImage`: true if image kind or field mapping indicates ingredient image.
- `hasNutritionImage`: true if image kind or field mapping indicates nutrition image.
- `completenessScore`: simple weighted score in [0,1] using presence of key fields:
  - identity, title/brand, category, details, images
- `needsManualReview=true` triggers:
  - status draft
  - ambiguous category
  - conflicting identity fields

## 1.11 Versioning policy
- `contractVersion` (schema version) is separate from record `version`.
- Record `version` increments on accepted product mutations.
- Backward-compatible contract changes:
  - add optional fields
  - widen non-breaking parsing rules
- Breaking changes require `v2` contract files.

## 1.12 Examples

### Example 1: minimal valid product
```json
{
  "productId": "7622210449283",
  "barcode": { "value": "7622210449283", "symbology": "ean13" },
  "title": "Chocolate Bar",
  "images": [],
  "attributes": {
    "importSource": "open_food_facts",
    "importerVersion": "1.0.0",
    "importedAt": "2026-03-01T10:00:00.000Z",
    "off_code": "7622210449283",
    "import_contentHash": "sha256:abc123"
  },
  "source": "importedFeed",
  "status": "active",
  "createdAt": "2026-03-01T10:00:00.000Z",
  "updatedAt": "2026-03-01T10:00:00.000Z",
  "version": 1
}
```

### Example 2: full food product
```json
{
  "productId": "off:3017620422003",
  "barcode": { "value": "3017620422003", "symbology": "ean13" },
  "title": "Hazelnut Spread",
  "brand": "Ferrero",
  "shortDescription": "Cocoa and hazelnut spread",
  "storageInstructions": "Store in a cool dry place",
  "category": { "main": "food", "sub": "spread" },
  "productDetails": {
    "kind": "food",
    "value": {
      "ingredients": ["sugar", "palm oil", "hazelnuts", "cocoa"],
      "allergens": ["nuts"],
      "servingSize": "15 g",
      "nutritionPer100gOrMl": {
        "energyKcal": 539,
        "proteinG": 6.3,
        "fatG": 30.9,
        "saturatedFatG": 10.6,
        "carbsG": 57.5,
        "sugarsG": 56.3,
        "sodiumMg": 42
      },
      "quantityText": "350g",
      "numberOfItemsText": null
    }
  },
  "packaging": { "quantity": 350, "unit": "g", "count": 1, "displayText": "350 g jar" },
  "size": "350 g",
  "images": [
    {
      "id": "front_1",
      "urlString": "https://example.com/front.jpg",
      "localAssetId": null,
      "kind": "front",
      "width": 800,
      "height": 1200
    },
    {
      "id": "nutrition_1",
      "urlString": "https://example.com/nutrition.jpg",
      "localAssetId": null,
      "kind": "nutrition",
      "width": 800,
      "height": 1200
    }
  ],
  "attributes": {
    "importSource": "open_food_facts",
    "importerVersion": "1.0.0",
    "importedAt": "2026-03-01T10:05:00.000Z",
    "off_code": "3017620422003",
    "off_categories_tags": "en:spreads,en:hazelnut-spreads",
    "import_contentHash": "sha256:def456"
  },
  "qualitySignals": {
    "completenessScore": 0.92,
    "needsManualReview": false,
    "hasFrontImage": true,
    "hasIngredientImage": false,
    "hasNutritionImage": true
  },
  "source": "importedFeed",
  "status": "active",
  "createdAt": "2026-03-01T10:05:00.000Z",
  "updatedAt": "2026-03-01T10:05:00.000Z",
  "version": 1
}
```

### Example 3: draft product requiring review
```json
{
  "productId": "off:missing-barcode-abc",
  "title": null,
  "brand": null,
  "images": [],
  "attributes": {
    "importSource": "open_food_facts",
    "importerVersion": "1.0.0",
    "importedAt": "2026-03-01T10:10:00.000Z",
    "off_code": "missing-barcode-abc",
    "import_rejectHint": "missing_title_and_brand",
    "import_contentHash": "sha256:ghi789"
  },
  "qualitySignals": {
    "completenessScore": 0.2,
    "needsManualReview": true,
    "hasFrontImage": false,
    "hasIngredientImage": false,
    "hasNutritionImage": false
  },
  "source": "importedFeed",
  "status": "draft",
  "createdAt": "2026-03-01T10:10:00.000Z",
  "updatedAt": "2026-03-01T10:10:00.000Z",
  "version": 1
}
```
