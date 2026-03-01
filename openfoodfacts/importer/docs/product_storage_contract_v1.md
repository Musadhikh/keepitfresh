# Product Storage Contract v1

## 1. Purpose and scope
This document defines the single source of truth for Product storage representation used by KeepItFresh importers and clients (iOS/Android/Web).

- Canonical model source: `iOS/Packages/ProductModule/Sources/ProductDomain/Models/*`
- Storage target (logical): Firestore JSON documents
- Scope: product document shape, normalization/invariants, enum encoding, validation states, and version/idempotency rules
- Non-scope (Phase 1): upload implementation

## 2. Canonical Firestore document layout

### 2.1 Collections
- `ProductCatalog`
  - Product documents keyed by canonical `productId`
- `ProductCategories`
  - Curated taxonomy records used for importer mapping and UI filtering

### 2.2 Canonical ProductCatalog document shape
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
    "k": "v"
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
  "version": 1,
  "provenance": {
    "provider": "open_food_facts|manual|other",
    "providerProductId": "string",
    "importBatchId": "string",
    "importedAt": "ISO-8601 datetime",
    "payloadHash": "sha256-hex"
  }
}
```

## 3. Canonical JSON field list

| Field | Type | Required | Constraints | Default behavior |
|---|---|---:|---|---|
| `productId` | string | Yes | non-empty, trimmed, stable immutable identifier | reject if missing |
| `barcode.value` | string | No | uppercase + alphanumeric normalized | omit when absent |
| `barcode.symbology` | string enum | No | must be allowed value | `unknown` if value present but invalid |
| `title` | string | No | trimmed; recommended for `active` | omit |
| `brand` | string | No | trimmed | omit |
| `shortDescription` | string | No | trimmed | omit |
| `storageInstructions` | string | No | trimmed | omit |
| `category.main` | string enum | No | must be allowed main category | omit |
| `category.sub` | string | No | trimmed | omit |
| `productDetails` | union object | No | must follow union encoding in section 5 | omit |
| `packaging.quantity` | number | No | >= 0 when present | omit |
| `packaging.unit` | string enum | No | must be allowed unit | `unknown` when `packaging` exists and unit missing |
| `packaging.count` | int | No | >= 0 | omit |
| `packaging.displayText` | string | No | trimmed | omit |
| `size` | string | No | trimmed | omit |
| `images` | array<object> | Yes | array of canonical image object | `[]` |
| `attributes` | map<string,string> | Yes | string keys/values | `{}` |
| `extractionMetadata` | object | No | `fieldConfidence` values in [0,1] | omit |
| `qualitySignals` | object | No | booleans default false when object present | omit |
| `compliance` | object | No | arrays of strings | omit |
| `source` | string enum | Yes | allowed source values only | `manual` |
| `status` | string enum | Yes | allowed status values only | `active` |
| `createdAt` | ISO datetime | Yes | set once on create | now (ingest time) |
| `updatedAt` | ISO datetime | Yes | update on each write | now (write time) |
| `version` | int | Yes | >= 1 | `1` on first write |
| `provenance` | object | Recommended | provider + traceability metadata | omit for manual-only records |

## 4. Enum serialization rules
Store all enums as strings using exact values below.

### 4.1 ProductSource
- `manual`
- `barcodeLookup`
- `aiExtraction`
- `importedFeed`
- `merged`

### 4.2 ProductStatus
- `active`
- `draft`
- `archived`
- `blocked`

### 4.3 Barcode.Symbology
- `ean13`
- `ean8`
- `upc_a`
- `upc_e`
- `qr`
- `code128`
- `unknown`

### 4.4 ProductCategory.MainCategory
- `food`
- `beverage`
- `household`
- `personalCare`
- `medicine`
- `electronics`
- `pet`
- `other`

### 4.5 ProductPackaging.Unit
- `g`
- `kg`
- `ml`
- `l`
- `oz`
- `lb`
- `count`
- `unknown`

### 4.6 ProductImage.Kind
- `front`
- `back`
- `label`
- `nutrition`
- `ingredients`
- `other`

## 5. ProductDetails union encoding
Use one cross-platform encoding:

```json
"productDetails": {
  "kind": "food|beverage|household|personalCare|other",
  "value": { "...": "kind-specific payload" }
}
```

- `kind` is required when `productDetails` exists.
- `value` may be `null` to represent empty payload (`FoodDetails?`, etc).
- `kind` must align with payload type.

Kind payloads:
- `food` / `beverage`: `FoodDetails`
- `household`: `HouseholdDetails`
- `personalCare`: `PersonalCareDetails`
- `other`: `UnknownDetails`

## 6. Normalization and invariants
- `productId`: trim whitespace, never empty.
- `barcode.value`: trim, uppercase, keep alphanumeric characters only.
- all user-facing text fields: trim leading/trailing whitespace.
- arrays: no `null` members.
- `images[].id` must be stable per image.
- `createdAt <= updatedAt` invariant.
- `version` monotonic increment on accepted mutation.

## 7. Provenance rules
Every imported record should carry `provenance`.

For Open Food Facts imports:
- `provenance.provider = "open_food_facts"`
- `source = "importedFeed"` (or `merged` when combining sources)
- store upstream identity in `provenance.providerProductId`
- store deterministic content hash in `provenance.payloadHash`
- store ingest batch and timestamp

## 8. Category policy (curation-first)
- Importers must not blindly trust upstream category strings.
- `ProductCategories` is curated source for mapping raw categories -> canonical `main/sub`.
- If no mapping exists:
  - set `category.main = "other"`
  - optionally keep raw hints in `attributes` or `provenance` metadata
- Category mapping changes are additive and versioned in taxonomy workflow, not ad-hoc per importer run.

## 9. Validation states (active/draft/skip)
Importer decision model:
- `active`
  - minimum: valid `productId`, valid enum fields, and at least one useful identifier (`title` or `barcode`)
- `draft`
  - structurally valid but incomplete business content (for review)
- `skip` (not persisted)
  - invalid `productId`, unrecoverable schema/type errors, or explicit policy block

Notes:
- `skip` is pipeline-only state, not a `ProductStatus` enum value.
- persisted records use `status` from ProductStatus only.

## 10. Versioning and idempotency guidance
- Contract version: `v1`.
- Maintain `version` in each product document (application-level record version).
- Importer idempotency key:
  - `(productId, provenance.payloadHash)`
- If incoming hash == stored hash: no-op update.
- If hash differs: apply merge policy, update `updatedAt`, increment `version`.
- Backward-compatible changes:
  - add optional fields only
- Breaking changes:
  - require new contract version file (`product_storage_contract_v2.*`)

## 11. Change management
Any change to this contract must:
1. update `product_storage_contract_v1.md`
2. update `product_storage_contract_v1.json`
3. update `docs/README.md` changelog section
4. include migration note for client/parser impact
