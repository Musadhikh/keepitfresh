# Firestore Index/Rules Verification Pass

Status date: 2026-03-01  
Scope: Firestore usage in `keepitfresh` app adapters with focus on Product + Inventory backend paths.

## 1) Artifacts Added

- `firebase.json`
- `firestore.rules`
- `firestore.indexes.json`

These are added at the app project root (`keepitfresh/`) for Firebase CLI deploy/emulator workflows.

## 2) Rules Coverage Matrix

| Collection Path | Query/Operation Source | Access Rule | Status |
|---|---|---|---|
| `AppMetadata/{doc}` | `AppMetadataService.getAppMetadata()` | Public read, no write | Covered |
| `Profiles/{userId}` | `ProfileFirebaseService` get/create/update/delete | User can only read/write own doc | Covered |
| `Houses/{houseId}` | `HouseFirebaseService` get/getMany/create | House members read/update/delete; create requires owner == auth and owner in members | Covered |
| `Houses/{houseId}/Purchases/{itemId}` | `FirestoreInventoryModuleRemoteGateway` upsert/fetch | House members read/write | Covered |
| `ProductCatalog/{productId}` | `FirestoreCatalogRepository` find/query/upsert | Authenticated read/write | Covered |
| `OpenFoodFactsProducts/{id}` | Reference data | Public read, no write | Covered |
| `OpenFoodFactsCategories/{id}` | Reference data | Public read, no write | Covered |

## 3) Index Coverage Matrix

### 3.1 Active query shapes in code

1. `ProductCatalog.where(barcode == value).limit(1)`  
2. `ProductCatalog.where(barcode > "")` (has-barcode filter) + optional sort  
3. `ProductCatalog.where(status == value)` + optional sort  
4. `ProductCatalog.where(brand == value)` + optional sort  
5. `ProductCatalog.where(source == value)` + optional sort  
6. `ProductCatalog.where(categories array-contains value)` + optional sort  
7. `ProductCatalog.orderBy(updatedAt|createdAt|title|brand)`
8. `Houses/{houseId}/Purchases.where(status == "active")`
9. `Houses/{houseId}/Purchases` full snapshot read
10. `Houses.where(documentId in batch)`

### 3.2 Index decisions

| Query shape | Composite index needed | Status |
|---|---|---|
| `ProductCatalog` filter + sort combinations | Yes (for many combinations) | Added baseline composites in `firestore.indexes.json` |
| `ProductCatalog` single equality + no order | No | Auto/single-field |
| `ProductCatalog` pure `orderBy` | No (single-field) | Auto/single-field |
| `Purchases.where(status == "active")` | No (single-field) | Auto/single-field |
| `Purchases` collection reads with no order/filter mix | No | Auto |
| `Houses.where(documentId in [...])` | No extra composite | Auto |

## 4) Important Notes / Tradeoffs

- `ProductCatalog` query API supports multiple dynamic filter+sort combinations. A finite baseline index set is added for current high-probability combinations.
- If product queries start using additional sort directions or multi-filter mixes not in `firestore.indexes.json`, Firestore will return index links; those must be promoted into the index file.
- Current rule for `ProductCatalog` allows authenticated client writes because Add Product uses client-side upsert. If catalog writes should be server-only, migrate write path to Cloud Functions/Admin and tighten this rule.

## 5) Emulator Validation Commands (recommended)

From `keepitfresh/`:

```bash
firebase emulators:start --only firestore
```

Optional rule unit tests (if added later):

```bash
firebase emulators:exec --only firestore "npm test"
```

## 6) Follow-up Checklist

1. Run this config in Firebase Emulator Suite and validate allow/deny matrix with auth contexts.
2. Perform staging smoke tests for Product query filter/sort variants and collect missing-index errors.
3. Promote any missing index links from staging logs into `firestore.indexes.json`.
4. Revisit `ProductCatalog` write policy once server-authoritative product sync is in place.

