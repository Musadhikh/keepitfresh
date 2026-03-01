# Backend Integration Progress Handoff

Status date: 2026-03-01  
Branch at handoff: `task/inventory-add`  
Latest commit at handoff: `35c234d`

This handoff covers Firebase backend integration work across Product + Inventory and the recent root refactor.

## 1) Completed

### Root architecture refactor
- Added a dedicated root container view:
  - `keepitfresh/Presentation/Root/RootView.swift`
- Moved app-state routing, environment wiring, deep-link handling, and lifecycle sync triggering out of `KeepItFreshApp` and into `RootView`.
- Kept `KeepItFreshApp` focused on bootstrap only (Firebase config, Google Sign-In config, Firestore cache settings).
- Extracted root sync triggers into dedicated files:
  - `keepitfresh/Presentation/Root/ProductPendingSyncTrigger.swift`
  - `keepitfresh/Presentation/Root/InventoryPendingSyncTrigger.swift`

### Firebase dependency policy
- Removed `#if canImport(FirebaseFirestore)` guards from app Firestore adapters so Firebase is now a hard compile-time dependency for these paths:
  - `keepitfresh/Data/AddProduct/Remote/FirestoreCatalogRepository.swift`
  - `keepitfresh/Data/AddProduct/Remote/FirestoreInventoryRepository.swift`
  - `keepitfresh/Data/InventoryModule/Remote/FirestoreInventoryModuleRemoteGateway.swift`

### Product backend progress (P0 started)
- Upgraded `FirestoreCatalogRepository` from stub toward real remote behavior:
  - implemented remote barcode lookup in `ProductCatalog`
  - implemented remote upsert with mock-write guard support
  - added resilient field mapping fallbacks (`title/name`, `description/shortDescription`, `images/imageUrl`, etc.)

### Inventory backend path alignment
- Updated inventory Firestore path to your required structure:
  - `Houses/{householdId}/Purchases/{inventoryItemId}`
- Updated constants:
  - `FirebaseConstants.Collections.purchases`
  - `FirebaseConstants.Collections.productCatalog`
- Updated infrastructure smoke assertion:
  - `keepitfreshTests/InventoryModuleInfrastructureSmokeTests.swift`

### Integration planning docs
- Added consolidated backend status + plan:
  - `Documentation/FIREBASE_BACKEND_INTEGRATION_STATUS_AND_PLAN.md`

## 2) Build Verification

Verified after the above changes:

```bash
xcodebuild -project keepitfresh/keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build
```

Result: `BUILD SUCCEEDED`

## 3) Remaining P0 Items

1. Finish Product remote integration for query path.
- Current gap: `CatalogProductRemoteGateway.query(_:)` still returns empty page.
- Implement real remote query behavior backed by Firestore `ProductCatalog` (or define explicit constraints and fallback strategy).

2. Migrate Add Product inventory flow to InventoryModule APIs.
- Current gap: `AddProductFlowUseCase` still writes/reads via legacy `Domain/AddProduct/Repositories/InventoryRepository`.
- Target: route save/read operations through `InventoryModuleServicing` (`addInventoryItem`, query/read equivalents) to avoid split architecture.

3. Inventory remote reconciliation strategy.
- Current behavior refreshes by fetching active items and upserting local.
- Gap: no explicit tombstone/deletion reconciliation for cross-device archive/delete state convergence.

## 4) Recommended Next Step (Immediate)

Start with **P0 #2** (Add Product migration) to remove split inventory write paths:
- Keep UI unchanged.
- Replace only backend orchestration layer in `AddProductFlowUseCase` and its assembler dependencies.
- Ensure add flow continues local-first and sync-aware via InventoryModule.

## 5) Key Files to Open First

- `keepitfresh/Presentation/Root/RootView.swift`
- `keepitfresh/App/KeepItFreshApp.swift`
- `keepitfresh/Data/AddProduct/Remote/FirestoreCatalogRepository.swift`
- `keepitfresh/Data/ProductModule/Remote/CatalogProductRemoteGateway.swift`
- `keepitfresh/Domain/AddProduct/UseCases/AddProductFlowUseCase.swift`
- `keepitfresh/Presentation/Product/AddProduct/AddProductModuleAssembler.swift`
- `keepitfresh/Data/InventoryModule/Adapters/AppInventoryModuleService.swift`
- `keepitfresh/Documentation/FIREBASE_BACKEND_INTEGRATION_STATUS_AND_PLAN.md`

## 6) Resume Commands

```bash
git checkout task/inventory-add
git pull

xcodebuild -project keepitfresh/keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build
```

