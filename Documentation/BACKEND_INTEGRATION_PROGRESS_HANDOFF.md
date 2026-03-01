# Backend Integration Progress Handoff

Status date: 2026-03-01  
Branch at handoff: `task/inventory-add`  
Latest commit at handoff: `52232f6`

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
- Implemented Firestore-backed Product remote query path:
  - `CatalogProductRemoteGateway.query(_:)` now delegates to Firestore adapter when available.
  - `FirestoreCatalogRepository.queryRemote(_:)` now executes remote list queries with filter/sort/paging mapping.

### Add Product migration progress (P0 in progress)
- `AddProductFlowUseCase` now requires InventoryModule dependencies and uses InventoryModule-backed read/write path only.
- `AddProductModuleAssembler` now injects mandatory InventoryModule dependencies via DI.
- Added default per-household storage-location bootstrap (`Pantry`) for add flow writes that require InventoryModule location invariants.

### Inventory reconciliation progress
- Added snapshot refresh capability to InventoryModule remote contract:
  - `InventoryRemoteGateway.fetchItemsSnapshot(householdId:)`
- Switched local-refresh read paths to snapshot-based reconciliation:
  - `DefaultGetExpiredItemsUseCase`
  - `DefaultGetExpiringItemsUseCase`
  - `DefaultWarmExpiringInventoryWindowUseCase`
- Updated remote adapters to provide full household snapshot (all statuses) for refresh:
  - `Packages/InventoryModule/.../InMemoryInventoryRemoteGateway.swift`
  - `keepitfresh/Data/InventoryModule/Remote/FirestoreInventoryModuleRemoteGateway.swift`
  - `keepitfresh/Data/InventoryModule/Remote/StubInventoryModuleRemoteGateway.swift`
- Added regression test coverage:
  - `localHitOnlineRefreshReconcilesRemoteArchivedStatus`

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

1. None open for the previously listed P0 set.
- Hard-delete policy is now locked as archive-first:
  - remote snapshot omission does not imply local hard-delete.
  - archive/status convergence is handled through snapshot upsert by item ID/status.
  - explicit hard-delete support is deferred until a tombstone/delta contract is introduced.

## 4) Recommended Next Step (Immediate)

Start with next phase items (P1/operational hardening), e.g.:
- Firestore index/rules verification pass.
- Emulator/staging end-to-end sync integration tests.
- Optional tombstone RFC only if remote hard-delete becomes a requirement.

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
