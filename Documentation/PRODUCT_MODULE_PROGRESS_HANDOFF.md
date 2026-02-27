# Product Module Progress Handoff

Status date: 2026-02-27  
Branch at handoff: `task/product-add-2`  
Base commit at handoff: `5d8ec89`

This document captures:
- What is completed
- The immediate next step
- Ordered pending steps
- References and commands to continue from another machine

## 1) Completed So Far

### Planning and scope
- Product package extraction plan is documented with boundaries, architecture, and diagrams.
- Identity invariant finalized: `productId` is unique primary key, and when barcode exists, `productId == normalized(barcode)`.
- Product structure aligned with ImageData extraction model patterns while excluding inventory-only fields.

References:
- `Documentation/PRODUCT_MODULE_PACKAGE_PLAN.md`

### ProductModule package scaffold
- Created Swift package: `Packages/ProductModule`.
- Internal targets split by responsibility:
  - `ProductDomain`
  - `ProductApplication`
  - `ProductModule` (facade)
- Public import ergonomics completed: consumers import only `ProductModule`.
- Offline-first service implemented: `DefaultProductModuleService`.
- Connectivity behavior improved to throw explicit module errors for UI messaging.
- Package tests added for identity and offline connectivity paths.
- Package README added with architecture and quick-start guide.

References:
- `Packages/ProductModule/Package.swift`
- `Packages/ProductModule/Sources/ProductModule/ProductModuleExports.swift`
- `Packages/ProductModule/Sources/ProductApplication/DefaultProductModuleService.swift`
- `Packages/ProductModule/Sources/ProductApplication/ProductModuleError.swift`
- `Packages/ProductModule/Tests/ProductModuleTests/ProductModuleScaffoldTests.swift`
- `Packages/ProductModule/README.md`

### Existing app behavior (outside ProductModule)
- Add Product local persistence is Realm-backed through existing AddProduct repositories.
- Barcode resolution order in Add Product flow is inventory local first, then catalog local, before remote attempts.
- Home screen now lists local Realm inventory.
- Home has "Show Products" route to a product list screen backed by local Realm catalog cache.

References:
- `keepitfresh/Data/AddProduct/Local/RealmInventoryRepository.swift`
- `keepitfresh/Data/AddProduct/Local/RealmCatalogRepository.swift`
- `keepitfresh/Domain/AddProduct/UseCases/AddProductFlowUseCase.swift`
- `keepitfresh/Presentation/Home/HomeView.swift`
- `keepitfresh/Presentation/Home/HomeInventoryViewModel.swift`
- `keepitfresh/Presentation/Home/ProductsListScreen.swift`
- `keepitfresh/Presentation/Home/ProductsListViewModel.swift`

## 2) Immediate Next Step (Do This First)

Implement app-side infrastructure adapters for ProductModule ports and wire them in Factory DI.

Goal:
- Keep ProductModule clean and unaware of concrete infra.
- Reuse existing Realm/remote infrastructure by adapting it to:
  - `ProductLocalStore`
  - `ProductRemoteGateway`
  - `ProductSyncStateStore`
  - `ConnectivityProviding`

Why this is next:
- ProductModule is currently isolated and tested, but not yet used by app flows.
- App code still depends on AddProduct-specific catalog contracts for product retrieval/listing.

## 3) Ordered Pending Steps

1. Add ProductModule adapter layer in app/infrastructure.
   - Build Realm adapter for `ProductLocalStore`.
   - Build sync metadata storage adapter for `ProductSyncStateStore`.
   - Build remote adapter for `ProductRemoteGateway` (using current remote services or stub path).
   - Build connectivity adapter for `ConnectivityProviding`.

2. Register ProductModule dependencies in Factory.
   - Add factories for adapters and a singleton `ProductModule` or `ProductModuleServicing`.
   - Keep registration centralized in `keepitfresh/App/DIContainer.swift`.

3. Migrate Add Product flow to ProductModule for product/catalog retrieval and upsert.
   - Keep inventory operations in current inventory repo for now.
   - Replace direct catalog repository orchestration where ProductModule should own it.
   - Preserve current UX/state machine behavior in `AddProductFlowUseCase`.

4. Migrate Home products list screen to ProductModule query.
   - Replace direct `CatalogRepository.fetchAllLocal()` call with `retrieveProducts(query:)`.
   - Keep current sorting/filtering behavior equivalent during migration.

5. Introduce periodic/manual sync trigger path using `syncPending(limit:)`.
   - Add app trigger point (foreground launch, pull-to-refresh, or dedicated sync action).
   - Ensure sync errors are surfaced as user-friendly messages.

6. Expand tests after integration.
   - Adapter-level tests (Realm mapping + sync metadata behavior).
   - Integration tests for offline-first flows from app entry points.
   - Regression checks for barcode lookup semantics and identity invariant enforcement.

7. Follow-up module extraction (future task).
   - Extract Inventory into separate package/module.
   - Keep Product -> Inventory dependency direction one-way (`Inventory` references `productId`).

## 4) Resume References (Another Machine)

### Core docs to open first
- `Documentation/PRODUCT_MODULE_PACKAGE_PLAN.md`
- `Documentation/PRODUCT_MODULE_PROGRESS_HANDOFF.md` (this file)
- `Packages/ProductModule/README.md`

### ProductModule core code
- `Packages/ProductModule/Sources/ProductDomain/Ports/ProductLocalStore.swift`
- `Packages/ProductModule/Sources/ProductDomain/Ports/ProductRemoteGateway.swift`
- `Packages/ProductModule/Sources/ProductDomain/Ports/ProductSyncStateStore.swift`
- `Packages/ProductModule/Sources/ProductDomain/Ports/RuntimeDependencies.swift`
- `Packages/ProductModule/Sources/ProductApplication/DefaultProductModuleService.swift`

### Current app integration points to migrate
- `keepitfresh/App/DIContainer.swift`
- `keepitfresh/Presentation/Product/AddProduct/AddProductModuleAssembler.swift`
- `keepitfresh/Domain/AddProduct/UseCases/AddProductFlowUseCase.swift`
- `keepitfresh/Presentation/Home/ProductsListViewModel.swift`
- `keepitfresh/Data/AddProduct/Local/RealmCatalogRepository.swift`
- `keepitfresh/Data/AddProduct/Local/RealmInventoryRepository.swift`

## 5) Resume Commands

Use these after cloning/checking out the branch on another machine:

```bash
git checkout task/product-add-2
git pull

swift build --package-path Packages/ProductModule
swift test --package-path Packages/ProductModule

xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build
```

## 6) Working Notes

- ProductModule delete flow is intentionally not implemented yet; only scale-ready contracts exist.
- Connectivity failures in ProductModule now throw explicit errors for UI toasts/messages:
  - `.connectivityUnavailable(operation: .retrieveProduct)`
  - `.connectivityUnavailable(operation: .retrieveProducts)`
  - `.connectivityUnavailable(operation: .syncPending)`
- Keep ProductModule independent of Factory. DI remains at app composition root only.
