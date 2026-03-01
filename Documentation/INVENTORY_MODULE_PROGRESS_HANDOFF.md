# Inventory Module Progress Handoff

Status date: 2026-03-01  
Branch at handoff: `task/homepage`  
Base commit at handoff: `c975eae`

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

### Delete mutation milestone (completed)
- Implemented inventory delete as soft-delete/archive with offline-first orchestration:
  - new use-case contract: `DeleteInventoryItemUseCase`
  - default implementation: `DefaultDeleteInventoryItemUseCase`
  - local-first state transition (`status = .archived`) with sync metadata (`operation = .delete`)
  - online remote upsert + metadata state transition (`pending` -> `synced` / `failed`)
  - idempotency support by request ID
- Wired delete use case across package facade exports, app service adapter, and DI container.
- Expanded mutation tests to cover delete paths:
  - offline pending + local archive persistence
  - online synced transition
  - online remote failure -> failed + retry increment
  - idempotency duplicate suppression
- Verification completed:
  - `swift test --package-path Packages/InventoryModule` (30 tests passed)
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

### Firestore remote gateway milestone (completed)
- Replaced temporary inventory remote gateway in app DI with a Firestore-backed adapter:
  - `FirestoreInventoryModuleRemoteGateway`
  - registered in composition root instead of `StubInventoryModuleRemoteGateway`
- Remote storage path is now household-scoped:
  - `Houses/{householdId}/Items/{inventoryItemId}`
- Remote behaviors implemented:
  - `upsert` writes batch/instance payloads to house-scoped inventory documents
  - `fetchActiveItems` reads only active items for a house (`status == "active"`)
  - write path respects `FirebaseWritePolicy.isMockWriteEnabled` in debug mode
  - mapping uses shared Firestore codable helpers for stable date/value normalization
- Verification completed:
  - `swift test --package-path Packages/InventoryModule` (30 tests passed)
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

### Adapter/composition smoke tests milestone (completed)
- Added app-layer infrastructure smoke tests:
  - `keepitfreshTests/InventoryModuleInfrastructureSmokeTests.swift`
- Coverage added:
  - Firestore house-scoped path assumption check (`Houses/{householdId}/Items`)
  - Firestore gateway guard behavior smoke checks:
    - blank household fetch returns empty
    - empty upsert payload is a no-op
  - DI composition resolution checks:
    - `inventoryModuleRemoteGateway` resolves to `FirestoreInventoryModuleRemoteGateway`
    - `inventoryModuleService` resolves to `AppInventoryModuleService`
  - Service invocation smoke check through DI:
    - invalid household validation path throws as expected
- Added small adapter test seam:
  - `FirestoreInventoryModuleRemoteGateway.houseItemsCollectionPath(householdId:)`
  - Keeps path assertion explicit without coupling tests to Firestore internals.
- Verification completed:
  - `swift test --package-path Packages/InventoryModule`
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build`

### Home inventory query migration milestone (completed)
- Migrated Home inventory read flow from legacy AddProduct inventory repository to InventoryModule query APIs.
- `HomeInventoryViewModel` now:
  - invokes one-time warm-up (`WarmExpiringInventoryWindow`) for next 14 days
  - reads `expired` and `expiring` sections via:
    - `getExpiredItems`
    - `getExpiringItems`
  - keeps local-first behavior through module orchestration (local snapshot + background refresh semantics)
- `HomeView` now renders InventoryModule-driven alert sections:
  - `Expired`
  - `Expiring in 14 days`
- Verification completed:
  - `swift test --package-path Packages/InventoryModule` (30 tests passed)
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

### Sync hardening milestone (completed)
- Hardened `DefaultSyncPendingInventoryUseCase` with retry/backoff and observability hooks:
  - Added pluggable retry policy contracts:
    - `InventorySyncRetryPolicy`
    - `DefaultInventorySyncRetryPolicy` (exponential backoff + deterministic jitter + retry cap)
  - Added pluggable observability contracts:
    - `InventorySyncObservability`
    - `InventorySyncEvent`
    - `InventorySyncFailureCategory`
    - `NoOpInventorySyncObservability`
  - Expanded coordinator behavior:
    - now retries eligible `.failed` sync metadata entries when backoff window is elapsed
    - skips non-eligible entries and records skip reasons for metrics
    - emits started/offline/skipped/synced/failed/completed events for instrumentation
- Expanded sync coordinator tests:
  - backoff skip behavior for failed entries
  - observability event emission across failure + retry-success paths
- Updated facade exports so app infrastructure can inject custom retry/observability implementations when needed.
- Verification completed:
  - `swift test --package-path Packages/InventoryModule` (32 tests passed)
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

### Sync contract parity milestone (completed)
- Expanded `SyncPendingInventory` API contract to match implementation-plan intent:
  - input now supports optional operation filters (`Set<InventorySyncOperation>`)
  - output now returns `failedItemIDs` for current sync execution
- Updated sync coordinator behavior:
  - applies operation filter before processing candidates
  - applies limit after filtering and ordering
  - surfaces deterministic failed IDs in output for app-side diagnostics/retry UX
- Expanded sync coordinator tests:
  - validates operation-filtered replay behavior
  - validates failed-item ID reporting on remote failures
- Verification completed:
  - `swift test --package-path Packages/InventoryModule` (33 tests passed)
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

### Delete semantics alignment milestone (completed)
- Finalized inventory delete contract as **archive-only**.
- Confirmed package API and implementation alignment:
  - `DeleteInventoryItemInput` remains `householdId + itemId + idempotencyRequestId`
  - no `hardDelete` option in module contracts
  - delete operation archives item locally and syncs archived state via remote upsert path
- Updated implementation-plan documentation to remove hard-delete-oriented repository/gateway API examples.
- Verification completed:
  - `swift test --package-path Packages/InventoryModule` (33 tests passed)
  - `xcodebuild -project keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

## 2) Immediate Next Step (Do This First)

Sync hardening app integration (future task).

Goal:
- Connect observability hooks to app telemetry/logging sinks.
- Tune retry policy thresholds in composition root based on production behavior.

Why this is next:
- Core module hardening and contract-parity milestones are complete and test-covered.
- Remaining work is operational wiring/tuning in app infrastructure.

## 3) Ordered Pending Steps

1. Sync hardening app integration (future task).
   - Wire `InventorySyncObservability` into app logging/metrics pipeline.
   - Configure `DefaultInventorySyncRetryPolicy` parameters from composition root policy.
   - Add conflict/sync-health dashboards or counters using emitted events.

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
- `Packages/InventoryModule/Sources/InventoryApplication/Policies/InventorySyncRetryPolicy.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/Policies/InventorySyncObservability.swift`
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
- `keepitfresh/Data/InventoryModule/Remote/FirestoreInventoryModuleRemoteGateway.swift`
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
