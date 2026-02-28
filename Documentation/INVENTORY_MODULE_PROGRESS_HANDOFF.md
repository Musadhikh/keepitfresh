# Inventory Module Progress Handoff

Status date: 2026-02-28  
Branch at handoff: `task/inventory-module`  
Base commit at handoff: `7ca0590`

This document captures:
- What is completed
- The immediate next step
- Ordered pending steps
- References and commands to continue from another machine

## 1) Completed So Far

### Planning and scope
- Inventory module implementation plan is documented with strict business-logic-only package boundaries.
- Module scope is explicitly `Domain / Application / Data`; no UI or Presentation target inside the package.
- Module scope is also concrete-backend agnostic: no tight references to technologies like Realm/Firestore in module contracts or type naming.
- Core inventory rules are locked in:
  - Inventory is instance/batch based.
  - Multiple batches can reference the same `productId`.
  - Merge policy is strict-key based (`productId`, expiry, openedAt, location, lot).
  - Consumption policy is FEFO.
  - Inventory must not mutate Product catalog data.
  - Offline-first strategy:
    - Add/Update/Delete write local first, then remote sync with tracked sync state.
    - Retrieve is local-first with remote fallback/refresh.
    - Home launch performs one-time expiring-next-2-weeks warm-up sync into local cache.

References:
- `Documentation/INVENTORY_MODULE_IMPLEMENTATION_PLAN.md`

### Documentation/journal alignment
- Journal updated to record Inventory module architecture planning and later scope correction to business-logic-only package.
- Journal updated with scaffold implementation and verification outcomes.

References:
- `JOURNAL.md`

### Implementation status snapshot
- Created `Packages/InventoryModule` scaffold with compile-ready targets:
  - `InventoryDomain`
  - `InventoryApplication`
  - `InventoryData`
  - `InventoryModule` facade
- Added baseline domain/application/data contracts and stubs:
  - Domain models (`InventoryItem`, `StorageLocation`, quantity/date/status, merge key)
  - Repository ports (`InventoryRepository`, `LocationRepository`, `ProductReadRepository`)
  - Application use-case contracts and policy utilities (`FEFOSelectionPolicy`, `InventoryMergePolicyEvaluator`)
  - Data DTO/mapping scaffolding and actor-backed in-memory repositories
  - Facade exports for single-import consumer ergonomics
- Added baseline package tests:
  - `InventoryDomainTests`
  - `InventoryApplicationTests`
  - `InventoryDataTests`
- Implemented concrete offline-first `AddInventoryItem` use case:
  - `DefaultAddInventoryItemUseCase` added in `InventoryApplication`.
  - Enforces merge-or-create policy with strict key matching.
  - Validates household/product/location/quantity and location ownership.
  - Persists local first, records sync metadata, then attempts remote upsert when online.
  - Tracks mutation sync state transitions (`pending`, `synced`, `failed`) and supports idempotency by request ID.
- Added in-memory sync test infrastructure:
  - `InMemoryInventoryRemoteGateway`
  - `InMemoryInventorySyncStateStore`
- Expanded application tests for add flow:
  - merge exact match
  - no merge for location mismatch
  - no merge for expiry mismatch
  - offline pending sync state
  - online synced state
  - idempotency duplicate suppression
- Implemented offline-first retrieval use cases:
  - `DefaultGetExpiredItemsUseCase`
  - `DefaultGetExpiringItemsUseCase`
  - Local-first read behavior:
    - local miss + online -> fetch from remote and backfill local cache
    - local hit + online -> return local snapshot and refresh local cache from remote
    - offline -> deterministic local-only return path
- Expanded retrieval tests:
  - local miss -> remote hit -> local cache populated
  - local hit returns existing local snapshot
  - local hit + online refresh updates local cache
  - offline local miss avoids remote fetch and returns empty
- Implemented offline-first consumption use case:
  - `DefaultConsumeInventoryUseCase`
  - FEFO batch selection (`expiry asc`, nil expiry last, `createdAt` tie-breaker)
  - Supports partial consume across multiple active batches
  - Transitions depleted batches to `consumed` with `consumedAt`
  - Persists local first, then applies remote upsert when online, with sync state tracking (`pending`/`synced`/`failed`)
- Expanded consume tests:
  - FEFO consumes earliest expiry first
  - nil-expiry batches ordered after dated batches
  - full consume transitions batch status to `consumed`
  - offline consume keeps pending sync without remote write
  - online consume transitions sync metadata to synced
- Implemented remaining offline-first mutation use cases:
  - `DefaultMoveInventoryItemLocationUseCase`
  - `DefaultUpdateInventoryItemDatesUseCase`
  - Both follow local-first write then online remote sync with metadata state tracking (`pending`/`synced`/`failed`)
  - Both support idempotency request IDs for duplicate submission resilience
- Expanded mutation tests:
  - move location offline pending + local persistence
  - move location online synced transition
  - move location idempotency duplicate suppression
  - update dates offline pending + date persistence
  - update dates confidence validation (`invalidDateConfidence`)
- Implemented summary + sync coordination use cases:
  - `DefaultGetInventorySummaryByProductUseCase`
  - `DefaultSyncPendingInventoryUseCase`
  - `DefaultWarmExpiringInventoryWindowUseCase`
  - Added storage-agnostic contracts for coordinator/warm-up:
    - `InventorySyncStateStore.fetchByState(...)`
    - `InventoryWarmupRunStore`
  - Added in-memory warm-up tracker:
    - `InMemoryInventoryWarmupRunStore`
- Expanded coordinator/warm-up tests:
  - summary reflects active batch totals + earliest expiry
  - sync coordinator `pending -> synced` success path
  - sync coordinator remote failure -> `failed` with retry increment
  - warm-up runs once per launch and skips second invocation
- Verification completed:
  - `swift build --package-path keepitfresh/Packages/InventoryModule` (`BUILD SUCCEEDED`)
  - `swift test --package-path keepitfresh/Packages/InventoryModule` (26 tests passed)
  - `xcodebuild -project keepitfresh/keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

### App integration milestone (completed)
- Added app-layer adapters (outside package) for InventoryModule contracts:
  - local repository adapter
  - location repository adapter
  - sync-state store adapter
  - warm-up run store adapter
  - temporary remote gateway adapter
  - connectivity bridge conformance
- Added app service adapter to expose InventoryModule use cases through one app-facing service.
- Wired full InventoryModule dependency graph in `DIContainer` (repositories, stores, gateway, use cases, service).
- Integrated one-time-per-launch warm-up trigger into Home inventory loading flow.
- Added namespaced facade exports (`InventoryModuleTypes`) to avoid module/type symbol collisions in app target wiring.
- Added ProductModule namespaced aliases for DI disambiguation where both packages expose similarly named runtime types.
- Verification completed after integration:
  - `swift test --package-path Packages/InventoryModule` (26 tests passed)
  - `swift test --package-path Packages/ProductModule` (5 tests passed)
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

## 2) Immediate Next Step (Do This First)

Implement `DeleteInventoryItem` end-to-end with the same offline-first contract and sync-state semantics as other inventory mutations.

Goal:
- Add `DeleteInventoryItemUseCase` contract + default implementation in `InventoryApplication`.
- Behavior contract:
  - local-first mutation (`active -> archived` or soft-delete status path; no hard delete by default)
  - sync metadata transition tracking (`pending` -> `synced`/`failed`)
  - online remote upsert/delete operation depending on gateway contract
  - idempotency request ID support
- Export the use case via `InventoryModule` facade and wire it into app service/DI.
- Add focused tests for delete flow:
  - offline pending behavior
  - online success transition
  - remote failure transition to failed + retry metadata
  - idempotency duplicate suppression

Why this is next:
- It is the main remaining core mutation missing from the inventory business API.
- Completing it keeps mutation semantics consistent across add/consume/move/update/delete.

## 3) Ordered Pending Steps

1. Implement `DeleteInventoryItem` use case + tests + facade export + app wiring.
   - Match local-first + sync-state + idempotency pattern used by other mutations.
   - Keep soft-delete/archival semantics explicit.

2. Replace temporary remote adapter with production-grade inventory remote gateway.
   - Keep mapping boundary in app infrastructure.
   - Preserve backend-agnostic module contracts.

3. Add adapter and composition smoke tests at app layer.
   - Repository/store mapper round-trip sanity checks.
   - DI resolution and service invocation smoke tests.

4. Migrate Home inventory reads to InventoryModule service queries.
   - Home should consume module query API directly for expired/expiring sections.
   - Preserve local-first UX while warm-up sync refreshes cache in background.

5. Follow-up sync hardening (future task).
   - Add retry policy/backoff tuning, observability, and conflict resolution metrics.

## 4) Resume References (Another Machine)

### Core docs to open first
- `Documentation/INVENTORY_MODULE_IMPLEMENTATION_PLAN.md`
- `Documentation/INVENTORY_MODULE_PROGRESS_HANDOFF.md` (this file)
- `Documentation/PRODUCT_MODULE_PACKAGE_PLAN.md` (for module pattern parity)
- `Packages/InventoryModule/README.md`

### InventoryModule package scaffold (new)
- `Packages/InventoryModule/Package.swift`
- `Packages/InventoryModule/Sources/InventoryDomain/Entities/InventoryItem.swift`
- `Packages/InventoryModule/Sources/InventoryDomain/Ports/InventoryRepository.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/AddInventoryItemUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultAddInventoryItemUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultConsumeInventoryUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultMoveInventoryItemLocationUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultUpdateInventoryItemDatesUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultGetExpiredItemsUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultGetExpiringItemsUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultGetInventorySummaryByProductUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultSyncPendingInventoryUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultWarmExpiringInventoryWindowUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/Policies/FEFOSelectionPolicy.swift`
- `Packages/InventoryModule/Sources/InventoryData/Repositories/InMemoryInventoryRepository.swift`
- `Packages/InventoryModule/Sources/InventoryData/Repositories/InMemoryInventoryRemoteGateway.swift`
- `Packages/InventoryModule/Sources/InventoryData/Repositories/InMemoryInventorySyncStateStore.swift`
- `Packages/InventoryModule/Sources/InventoryModule/InventoryModuleExports.swift`
- `Packages/InventoryModule/Tests/InventoryDomainTests/InventoryDomainScaffoldTests.swift`
- `Packages/InventoryModule/Tests/InventoryApplicationTests/InventoryApplicationScaffoldTests.swift`
- `Packages/InventoryModule/Tests/InventoryDataTests/InventoryDataScaffoldTests.swift`

### App-side InventoryModule integration (completed)
- `keepitfresh/Data/InventoryModule/Adapters/AppInventoryModuleService.swift`
- `keepitfresh/Data/InventoryModule/Local/RealmInventoryModuleRepository.swift`
- `keepitfresh/Data/InventoryModule/Local/RealmInventoryModuleLocationRepository.swift`
- `keepitfresh/Data/InventoryModule/Sync/RealmInventoryModuleSyncStateStore.swift`
- `keepitfresh/Data/InventoryModule/Sync/RealmInventoryModuleWarmupRunStore.swift`
- `keepitfresh/Data/InventoryModule/Remote/StubInventoryModuleRemoteGateway.swift`
- `keepitfresh/Data/InventoryModule/Runtime/AppConnectivityProvider+InventoryModule.swift`
- `keepitfresh/App/DIContainer.swift`
- `keepitfresh/Presentation/Home/HomeInventoryViewModel.swift`

### Existing related app code (current inventory behavior)
- `keepitfresh/Domain/Models/Inventory/InventoryItem.swift`
- `keepitfresh/Domain/Models/Inventory/InventoryBatch.swift`
- `keepitfresh/Domain/AddProduct/Repositories/InventoryRepository.swift`
- `keepitfresh/Data/AddProduct/Local/RealmInventoryRepository.swift`
- `keepitfresh/Data/AddProduct/Remote/FirestoreInventoryRepository.swift`
- `keepitfresh/Data/AddProduct/Local/InMemoryInventoryRepository.swift`

### Product module references (read-only dependency pattern)
- `Packages/ProductModule/Package.swift`
- `Packages/ProductModule/Sources/ProductDomain/Ports`
- `Packages/ProductModule/Sources/ProductApplication`
- `Packages/ProductModule/Sources/ProductModule/ProductModuleExports.swift`

## 5) Resume Commands

Use these after cloning/checking out the branch on another machine:

```bash
git checkout task/inventory-module
git pull

swift build --package-path Packages/InventoryModule
swift test --package-path Packages/InventoryModule

# app verification after package wiring:
xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build
```

## 6) Working Notes

- Inventory module scope is business logic only; no SwiftUI/Presentation in package targets.
- Keep module independent of Factory and app runtime types; DI remains in app composition root.
- Keep module concrete-backend agnostic: no Realm/Firestore-specific references in module contracts, models, or naming.
- Concrete persistence/remote frameworks remain app-layer adapter concerns (outside package targets).
- Maintain one-way dependency direction:
  - Inventory references Product identity/read models.
  - Product module remains inventory-agnostic.
- Prefer actor-backed repository implementations and structured concurrency for transactional use cases.
- Prioritize test coverage for merge policy, FEFO ordering, and timezone-boundary expiry queries (Asia/Singapore).
- Home screen should render local inventory data; warm-up sync only refreshes local cache in the background once per launch.
