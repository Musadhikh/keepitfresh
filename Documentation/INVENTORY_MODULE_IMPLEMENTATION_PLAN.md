# Inventory Module Implementation Plan

Status: Draft (planning only, no implementation in this document)  
Date: 2026-02-28  
Owner: keepitfresh app team

## 1) Objective

Design and stage implementation of an `InventoryModule` for KeepItFresh using:
- iOS 26+, Swift 6 concurrency.
- Clean Architecture (`Domain` / `Application` / `Data`).
- Household-scoped, instance-based inventory.
- FEFO consumption and expiry-driven home surfaces.
- Offline-first synchronization semantics for add/retrieve/update/delete.

Hard constraints:
- Inventory is batch/instance based, not one-row-per-product.
- Multiple inventory items can reference the same `productId`.
- Inventory never mutates Product catalog data.
- Local-first storage with sync-ready boundaries.
- This Swift package contains business logic only (no SwiftUI views, view models, routes, or navigation code).
- This Swift package must remain persistence-technology agnostic: no concrete backend references (for example Realm/Firestore) in module contracts, models, or type names.
- Write strategy:
  - Add/Update/Delete inventory: persist locally first, then sync remotely.
  - Keep explicit sync state per item/mutation and provide sync APIs to converge local + remote state.
- Read strategy:
  - Retrieve inventory from local first.
  - If local miss: fetch remote, persist locally, return remote result.
  - If local hit: return local immediately and refresh/sync in background when policy allows.

## 2) A) Module Boundaries + Folder Structure

Suggested package shape (matching ProductModule style):

```text
Packages/InventoryModule/
  Package.swift
  Sources/
    InventoryDomain/
      Entities/
        InventoryItem.swift
        StorageLocation.swift
      ValueObjects/
        InventoryItemStatus.swift
        Quantity.swift
        InventoryDateInfo.swift
        ProductRef.swift
        MergePolicy.swift
      Errors/
        InventoryDomainError.swift
      Ports/
        InventoryRepository.swift
        LocationRepository.swift
        ProductReadRepository.swift
    InventoryApplication/
      UseCases/
        AddInventoryItemUseCase.swift
        ConsumeInventoryUseCase.swift
        MoveInventoryItemLocationUseCase.swift
        UpdateInventoryItemDatesUseCase.swift
        DeleteInventoryItemUseCase.swift
        GetExpiredItemsUseCase.swift
        GetExpiringItemsUseCase.swift
        GetInventorySummaryByProductUseCase.swift
        SyncPendingInventoryUseCase.swift
        WarmExpiringInventoryWindowUseCase.swift
      Policies/
        FEFOSelectionPolicy.swift
        InventoryMergePolicyEvaluator.swift
    InventoryData/
      DTOs/
        InventoryItemDTO.swift
        StorageLocationDTO.swift
      Persistence/
        InventoryItemRecord.swift
        StorageLocationRecord.swift
      Mappers/
        InventoryItemMapper.swift
        StorageLocationMapper.swift
      Repositories/
        LocalInventoryRepositoryAdapter.swift
        LocalLocationRepositoryAdapter.swift
        ProductReadRepositoryAdapter.swift
        RemoteInventoryGatewayAdapter.swift
        InventorySyncStateStoreAdapter.swift
    InventoryModule/
      InventoryModuleExports.swift
      InventoryModuleAssembler.swift
  Tests/
    InventoryDomainTests/
    InventoryApplicationTests/
    InventoryDataTests/
```

Layer ownership:
- `Domain`: business invariants and policies (merge logic, FEFO, expiry classification).
- `Application`: use-case orchestration and transactional business workflows.
- `Data`: persistence, mapping, query optimization, repo implementations.

## 3) B) Domain Model Definitions (Swift Sketches)

```swift
import Foundation

public enum InventoryItemStatus: String, Sendable, Codable, Equatable, Hashable {
    case active
    case consumed
    case discarded
    case archived
}

public enum QuantityUnit: String, Sendable, Codable, Equatable, Hashable {
    case piece
    case gram
    case kilogram
    case milliliter
    case liter
    case pack
}

public struct Quantity: Sendable, Codable, Equatable, Hashable {
    public var value: Decimal
    public var unit: QuantityUnit
}

public enum InventoryDateKind: String, Sendable, Codable, Equatable, Hashable {
    case expiry
    case opened
    case bestBefore
    case useBy
    case manufactured
    case packaged
}

public struct InventoryDateInfo: Sendable, Codable, Equatable, Hashable {
    public var kind: InventoryDateKind
    public var rawText: String
    public var confidence: Double // 0...1
    public var isoDate: Date?
}

public struct ProductRef: Sendable, Codable, Equatable, Hashable {
    public var productId: String
    public var snapshot: Snapshot?

    public struct Snapshot: Sendable, Codable, Equatable, Hashable {
        public var title: String?
        public var imageURL: URL?
        public var brand: String?
    }
}

public struct StorageLocation: Sendable, Codable, Equatable, Hashable {
    public var id: String
    public var householdId: String
    public var name: String
    public var isColdStorage: Bool
    public var createdAt: Date
    public var updatedAt: Date
}

public struct InventoryItem: Sendable, Codable, Equatable, Hashable {
    public var id: String
    public var householdId: String
    public var productRef: ProductRef
    public var quantity: Quantity
    public var status: InventoryItemStatus
    public var storageLocationId: String
    public var lotOrBatchCode: String?
    public var expiryInfo: InventoryDateInfo?
    public var openedInfo: InventoryDateInfo?
    public var notes: String?
    public var createdAt: Date
    public var updatedAt: Date
    public var consumedAt: Date?
}
```

`ProductRef` strategy:
- Required: persist `productId`.
- Optional: persist lightweight snapshot (`title`, `imageURL`, `brand`) to keep UI responsive offline.
- Snapshot is advisory only; catalog truth remains in Product module.

## 4) C) Use Cases and Responsibilities

### 4.1 AddInventoryItem (merge-or-create)
Signature sketch:

```swift
public protocol AddInventoryItemUseCase: Sendable {
    func execute(_ input: AddInventoryItemInput) async throws -> AddInventoryItemOutput
}
```

Inputs:
- `householdId`, `productId`, incoming batch fields (`quantity`, `expiry/opened`, `location`, `lot`), optional product snapshot.

Outputs:
- `itemId`, `action` (`merged` or `created`), resulting `InventoryItem`.

Logic:
- Find merge candidate using strict key:
  - `productId`
  - `expiryDate` (both nil or equal day)
  - `openedAt` (both nil or equal instant)
  - `storageLocationId`
  - `lotOrBatchCode` (both nil or equal)
- If found and active: add quantity to candidate.
- Else create new active item.

Errors:
- invalid quantity (`<= 0`)
- product not found (optional strict check via Product read repo)
- location not found
- household mismatch

Concurrency:
- run in repository actor transaction to avoid double-create races.

Idempotency:
- supports optional `requestId`; repeated request returns same result without duplicate increments.

### 4.2 ConsumeInventory (FEFO)
Signature sketch:

```swift
public protocol ConsumeInventoryUseCase: Sendable {
    func execute(_ input: ConsumeInventoryInput) async throws -> ConsumeInventoryOutput
}
```

Inputs:
- Either `inventoryItemId` or (`householdId`, `productId`) + `amount`.

Outputs:
- consumed breakdown per batch, remaining amount, touched item IDs.

Logic:
- Resolve active candidate batches.
- FEFO order:
  - earliest non-nil expiry first
  - nil expiry last
  - tie-breaker `createdAt ASC`
- decrement until requested amount consumed.
- batches reaching zero become `.consumed` then optionally `.archived`.

Errors:
- invalid amount
- item not found / no active stock
- insufficient stock (choose fail-fast by default)

Concurrency:
- single atomic operation in repo actor/transaction.

Idempotency:
- optional `requestId` to protect against duplicate consume command retries.

### 4.3 MoveInventoryItemLocation
- Input: `itemId`, `newLocationId`.
- Output: updated item.
- Rule: only active batches movable.
- Error: target location household mismatch.
- Concurrency: optimistic version check (`updatedAt`/version token).

### 4.4 UpdateInventoryItemDates
- Input: `itemId`, partial date updates (`expiry`, `opened`).
- Output: updated item + recalculated derived status (if policy adds auto-expired badge, still keep `status == .active` unless consumed/discarded).
- Error: invalid confidence range, invalid chronology checks if enforced (`opened > expiry` warning/error by policy).
- Idempotent for same payload.

### 4.5 GetExpiredItems(today)
- Input: `householdId`, `today`, `timeZone`.
- Output: active items where expiry day < day(today in timezone), sorted by expiry ascending.

### 4.6 GetExpiringItems(today, windowDays)
- Input: `householdId`, `today`, `windowDays`, `timeZone`.
- Output: active items where expiry day in `[today, today + windowDays]`, sorted ascending.

### 4.7 GetInventorySummaryByProduct
- Input: `householdId`, `productId`.
- Output: `totalQuantity`, `batchCount`, `earliestExpiry`, `activeBatchCount`.

### 4.8 DeleteInventoryItem (offline-first)
- Input: `householdId`, `itemId`, optional `hardDelete` flag (default false).
- Output: updated/deleted item id + sync state.
- Behavior:
  - default soft-delete semantics (mark discarded/archived locally).
  - queue remote delete mutation in sync state.
  - on sync success, mark as synced tombstone (or hard-delete by retention policy).

### 4.9 SyncPendingInventory
- Input: optional `limit`, optional operation filters (`add`, `update`, `delete`, `consume`).
- Output: attempted/synced/failed counts + failed item IDs.
- Behavior:
  - pushes pending local mutations to remote.
  - reconciles remote responses back into local store.
  - updates sync metadata (`pending/synced/failed`, retry counters, lastError).

### 4.10 WarmExpiringInventoryWindow (home one-time trigger)
- Input: `householdId`, `today`, `windowDays` (default 14), `triggerScope` (for example `appLaunchOnce`).
- Output: `fetchedCount`, `updatedLocalCount`, `fromCacheOnly`.
- Behavior:
  - one-time-per-launch app trigger calls this use case.
  - fetches/refreshes expiring-next-two-weeks data from remote when online.
  - upserts into local store so Home renders from local immediately afterwards.
  - if offline, returns local-only result and leaves sync pending state untouched.

Concurrency notes across all use cases:
- Use cases are `Sendable` and call actor-backed repositories.
- No `Task.detached` for core flows; structured async only.

## 5) D) Repository APIs

```swift
import Foundation

public protocol InventoryRepository: Sendable {
    func upsert(_ item: InventoryItem) async throws
    func create(_ item: InventoryItem) async throws
    func findById(_ id: String, householdId: String) async throws -> InventoryItem?
    func fetchActiveByHouseholdSortedByExpiry(_ householdId: String, now: Date, timeZone: TimeZone) async throws -> [InventoryItem]
    func fetchExpired(_ householdId: String, asOf: Date, timeZone: TimeZone) async throws -> [InventoryItem]
    func fetchExpiring(_ householdId: String, asOf: Date, windowDays: Int, timeZone: TimeZone) async throws -> [InventoryItem]
    func fetchActiveBatches(productId: String, householdId: String) async throws -> [InventoryItem]
    func findMergeCandidate(_ key: InventoryMergeKey, householdId: String) async throws -> InventoryItem?
    func updateMany(_ items: [InventoryItem]) async throws
    func summarizeByProduct(productId: String, householdId: String) async throws -> InventoryProductSummary
    func delete(itemId: String, householdId: String, hardDelete: Bool) async throws
}

public protocol LocationRepository: Sendable {
    func fetchAll(householdId: String) async throws -> [StorageLocation]
    func findById(_ id: String, householdId: String) async throws -> StorageLocation?
    func upsert(_ location: StorageLocation) async throws
}

public protocol ProductReadRepository: Sendable {
    func getProduct(by productId: String) async throws -> ProductReadModel?
    func getProducts(by productIds: [String]) async throws -> [ProductReadModel]
}

public protocol InventoryRemoteGateway: Sendable {
    func fetchInventory(householdId: String) async throws -> [InventoryItem]
    func fetchExpiring(householdId: String, asOf: Date, windowDays: Int, timeZone: TimeZone) async throws -> [InventoryItem]
    func upsert(_ items: [InventoryItem]) async throws
    func delete(itemIDs: [String], householdId: String) async throws
}

public enum InventorySyncOperation: String, Sendable, Codable, Equatable, Hashable {
    case add
    case update
    case delete
    case consume
}

public struct InventorySyncMetadata: Sendable, Codable, Equatable, Hashable {
    public var itemId: String
    public var householdId: String
    public var operation: InventorySyncOperation
    public var state: ProductSyncStateLike
    public var retryCount: Int
    public var lastError: String?
    public var updatedAt: Date
}

public enum ProductSyncStateLike: String, Sendable, Codable, Equatable, Hashable {
    case pending
    case synced
    case failed
}

public protocol InventorySyncStateStore: Sendable {
    func upsert(_ metadata: [InventorySyncMetadata]) async throws
    func pending(limit: Int?, operations: Set<InventorySyncOperation>?) async throws -> [InventorySyncMetadata]
}
```

Query examples:
- Active items by expiry:
  - `fetchActiveByHouseholdSortedByExpiry(householdId, now, tz)`
- Expired vs expiring:
  - `fetchExpired(...)`
  - `fetchExpiring(... windowDays: 7 ...)`
- Batches for product:
  - `fetchActiveBatches(productId: "ean_...", householdId: "...")`

## 6) E) Persistence + Sync Strategy (Offline-First)

Decision for initial build: local-first persistence behind module ports, with concrete storage implementation owned by app infrastructure.

Storage-agnostic local record sketch (inside module boundaries):
- `InventoryItemRecord`
  - `id` (primary key)
  - `householdId` (indexed)
  - `productId` (indexed)
  - `status` (indexed)
  - `expiryDate` (indexed, nullable)
  - `storageLocationId` (indexed)
  - `lotOrBatchCode` (indexed, nullable)
  - `openedAt` (nullable)
  - `quantityValue`, `quantityUnit`
  - optional snapshot fields (`productTitleSnapshot`, `productImageURLSnapshot`)
  - `createdAt`, `updatedAt`, `consumedAt`
  - `idempotencyRequestId` (indexed, nullable)

Concrete backend placement rule:
- If Realm (or any other backend) is used, keep concrete objects/adapters in app infrastructure layer.
- Module code should depend only on `InventoryRepository`/`LocationRepository` contracts and generic record mapping abstractions.

Index/query performance plan:
- Primary query path for Home:
  - filter `householdId + status == active + expiryDate != nil`, sort `expiryDate ASC`.
- Keep nil-expiry list separately or append after non-nil query.
- Use compound predicate-friendly fields and narrow result sets early.
- Add derived `expiryDayKey` (`yyyy-MM-dd` in household timezone) if day-level boundary queries need extra speed.

Required sync model:
- Add sync metadata store (`pendingCreate`, `pendingUpdate`, `pendingDelete`, `pendingConsume`, `syncedAt`, `lastError`).
- Domain events per mutation (`InventoryMutationEvent`) for outbox pattern.
- Keep remote adapters behind ports (`InventoryRemoteGateway`, `InventorySyncStateStore`) similar to Product module.
- Remote conflict strategy: last-write-wins for mutable metadata, additive reconciliation for quantity events with command IDs.

Operation semantics:
- Add/Update/Delete/Consume:
  - local write first
  - mark pending sync metadata
  - attempt immediate remote sync when online and policy allows
  - on success mark synced; on failure mark failed with retry metadata
- Retrieve:
  - local-first return path
  - on local miss fetch remote then cache local
  - on local hit return immediately, then optional background refresh/sync
- Home launch warm-up:
  - one-time per launch trigger refreshes expiring-next-14-days inventory and upserts local cache
  - Home continues reading local database only

## 7) F) App Integration Plan (No UI in Package)

This package provides business APIs that app UI layers consume; the package itself ships no UI code.

Expected app-side composition (outside this package):
- Home sections:
  - `GetExpiredItemsUseCase`
  - `GetExpiringItemsUseCase`
- Inventory list grouped by product:
  - `GetInventorySummaryByProductUseCase`
  - `fetchActiveBatches(productId:householdId:)`
- Inventory detail batch actions:
  - `ConsumeInventoryUseCase`
  - `MoveInventoryItemLocationUseCase`
  - `UpdateInventoryItemDatesUseCase`
- Add flow final submit:
  - `AddInventoryItemUseCase`
- Home one-time launch trigger:
  - call `WarmExpiringInventoryWindowUseCase` exactly once per app launch per household context

Integration rule:
- UI-specific mapping, formatting, and navigation remain in app targets (for example `keepitfresh/Presentation/...`) and must not be implemented inside `InventoryModule`.

## 8) G) Step-by-Step Implementation Sequence (PR-Friendly)

1. Domain models + protocols
- Add entities/value objects/errors/repository protocols in `InventoryDomain`.
- Define merge key and FEFO policy utilities.
- Add small domain-only validation helpers.

2. Data layer persistence + mappers
- Create storage-agnostic local records and mappers.
- Implement local repository adapters against module ports without concrete backend references in module APIs.
- Add Product read adapter bridging existing ProductModule read API.

3. Use cases + unit tests
- Implement core use cases including sync orchestration (`Add/Update/Delete/Consume`, retrieve, expiring/expired, summary, pending sync, warm-up).
- Cover merge policy and FEFO behavior first.
- Validate idempotency handling and timezone-safe expiry classification.
- Validate offline-first behavior contracts for local-first reads and local-then-remote writes.

4. Application service surface + facade exports
- Add explicit `InventoryModuleService` facade methods for app consumption.
- Export only stable public contracts from `InventoryModuleExports`.
- Keep package API independent from app UI concerns.

5. Integration points
- Register repository adapters and use cases in app DI (Factory at composition root).
- Wire app scan/manual flows to package use-case inputs in app layer only.
- Resolve product lookup via read-only Product repository adapter.

6. QA checklist + edge cases
- Household isolation verified.
- FEFO correctness with mixed nil/non-nil expiry.
- Merge policy strict key behavior.
- Timezone correctness (Asia/Singapore).
- Offline behavior and retry/idempotency.
- One-time home launch warm-up semantics (exactly once per launch).

## 9) H) Tests

Test strategy:
- Domain tests: merge policy, FEFO selection, status transitions, date classification.
- Application tests: use-case orchestration, transactional behavior, idempotency.
- Data tests: repository query correctness and mapper roundtrip.

Concrete unit tests (minimum set):

1. Merge exact match:
- Given active item with same merge key.
- Add new quantity with same key.
- Expect single item updated and quantity summed.

2. No merge due to location mismatch:
- Same product/expiry/opened/lot, different `storageLocationId`.
- Expect new batch creation.

3. No merge due to expiry mismatch:
- Same product/location/opened/lot, different expiry day.
- Expect new batch creation.

4. FEFO consumes earliest expiry first:
- Batches: expiry Jan 2, Jan 5, nil.
- Consume partial amount crossing first batch.
- Expect Jan 2 batch depleted before Jan 5 touched.

5. FEFO nil expiry ordering:
- Batches: one nil expiry, one dated.
- Consume amount smaller than total.
- Expect dated batch consumed first; nil-expiry batch remains.

6. Expired/expiring timezone boundary (Asia/Singapore):
- `today` near UTC date boundary.
- Validate day classification uses `Asia/Singapore` calendar day, not raw UTC.

Additional recommended tests:
- Consume exact quantity marks batch `.consumed` (then archive policy path).
- Consume insufficient stock returns domain error with untouched quantities.
- Idempotent consume with same `requestId` is applied once.
- Household isolation: queries never return cross-household records.
- Local-hit retrieve returns immediately and triggers background refresh path.
- Local-miss retrieve fetches remote and persists local cache.
- Add/update/delete write locally and record pending sync when offline.
- SyncPendingInventory transitions failed/pending/synced states correctly.
- WarmExpiringInventoryWindow with `windowDays = 14` updates local cache and is guarded to one run per launch trigger.

## 10) Initial Scaffolding Checklist (No Feature Implementation Yet)

- Add package skeleton `Packages/InventoryModule` with targets:
  - `InventoryDomain`
  - `InventoryApplication`
  - `InventoryData`
  - `InventoryModule` facade
- Add empty type stubs + protocol signatures from this document.
- Add `README.md` in package with architecture and invariants.
- Add initial domain tests for merge key matcher + FEFO ordering.
- Add initial application tests for add/consume idempotency.
- Wire package dependency into app project without replacing existing inventory flows yet.
