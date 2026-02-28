# Inventory Module Progress Handoff

Status date: 2026-02-28  
Branch at handoff: `task/inventory-module`  
Base commit at handoff: `101d4f8`

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
- Verification completed:
  - `swift build --package-path keepitfresh/Packages/InventoryModule` (`BUILD SUCCEEDED`)
  - `swift test --package-path keepitfresh/Packages/InventoryModule` (12 tests passed)
  - `xcodebuild -project keepitfresh/keepitfresh.xcodeproj -scheme keepitfresh -configuration Debug -destination 'generic/platform=iOS' build` (`BUILD SUCCEEDED`)

## 2) Immediate Next Step (Do This First)

Implement `ConsumeInventory` with FEFO and offline-first mutation sync.

Goal:
- Implement FEFO consumption against active batches:
  - Sort by earliest expiry first (`nil` expiry last, `createdAt` tie-breaker).
  - Support partial consume across multiple batches.
  - Transition zero-quantity batches to terminal status (`consumed`/`archived` per policy).
- Reuse local-first + sync-state flow from add:
  - persist local mutation first
  - track sync metadata state (`pending/synced/failed`)
  - sync remote when online
- Add focused tests:
  - FEFO ordering across dated + nil-expiry batches
  - partial consume across multiple batches
  - zero-quantity status transition
  - offline pending state and online synced state

Why this is next:
- It enforces the highest-risk inventory business rule after merge logic.
- It unlocks safe decrement flows for Home and inventory detail actions.

## 3) Ordered Pending Steps

1. Implement `ConsumeInventory` use-case behavior.
   - FEFO selection (dated first, nil expiry last, createdAt tie-breaker).
   - Partial consume and terminal status transitions (`consumed`/`archived` policy).
   - Same local-first + sync-state strategy as add/update/delete.

2. Implement remaining application-layer use-case behavior.
   - `AddInventoryItem`, `ConsumeInventory`, `MoveInventoryItemLocation`, `UpdateInventoryItemDates`.
   - `DeleteInventoryItem`, `GetExpiredItems`, `GetExpiringItems`, `GetInventorySummaryByProduct`.
   - `SyncPendingInventory`, `WarmExpiringInventoryWindow`.
   - Ensure timezone-safe day boundary logic for expiry classification.

3. Add data-layer storage-agnostic adapters and mappers.
   - Generic local records/index strategy for expiry and household-scoped queries.
   - Repository implementations plus mapping boundaries to domain entities.
   - Keep concrete backend adapters (Realm/Firestore/etc.) in app infrastructure layer.
   - Add remote gateway + sync-state store adapters at app layer.

4. Add tests in stages.
   - Domain: merge/FEFO/date classification rules.
   - Application: offline-first orchestration, transactional behavior, idempotency.
   - Data: query correctness and mapper round-trip.
   - Sync: pending->synced/failed transitions.
   - Home warm-up: one-time-per-launch next-14-days refresh behavior.

5. Wire package into app composition root.
   - Register adapters/use cases in Factory at app composition root.
   - Keep UI integration outside package.
   - Trigger `WarmExpiringInventoryWindow` once on Home launch per app run.

6. Follow-up sync hardening (future task).
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
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultGetExpiredItemsUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/UseCases/DefaultGetExpiringItemsUseCase.swift`
- `Packages/InventoryModule/Sources/InventoryApplication/Policies/FEFOSelectionPolicy.swift`
- `Packages/InventoryModule/Sources/InventoryData/Repositories/InMemoryInventoryRepository.swift`
- `Packages/InventoryModule/Sources/InventoryData/Repositories/InMemoryInventoryRemoteGateway.swift`
- `Packages/InventoryModule/Sources/InventoryData/Repositories/InMemoryInventorySyncStateStore.swift`
- `Packages/InventoryModule/Sources/InventoryModule/InventoryModuleExports.swift`
- `Packages/InventoryModule/Tests/InventoryDomainTests/InventoryDomainScaffoldTests.swift`
- `Packages/InventoryModule/Tests/InventoryApplicationTests/InventoryApplicationScaffoldTests.swift`
- `Packages/InventoryModule/Tests/InventoryDataTests/InventoryDataScaffoldTests.swift`

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
- Maintain one-way dependency direction:
  - Inventory references Product identity/read models.
  - Product module remains inventory-agnostic.
- Prefer actor-backed repository implementations and structured concurrency for transactional use cases.
- Prioritize test coverage for merge policy, FEFO ordering, and timezone-boundary expiry queries (Asia/Singapore).
- Home screen should render local inventory data; warm-up sync only refreshes local cache in the background once per launch.
