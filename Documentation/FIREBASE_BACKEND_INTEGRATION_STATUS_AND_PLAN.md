# Firebase Backend Integration Status and Plan (Product + Inventory)

Status date: 2026-03-01  
Scope: `ProductModule` + `InventoryModule` backend integration (business logic + app infrastructure wiring)

## 1) Executive Snapshot

- Inventory backend integration is partially complete and already live in app wiring:
  - Local store: Realm-backed adapters through module ports.
  - Remote store target path: `Houses/{householdId}/Purchases/{inventoryItemId}`.
  - Offline-first mutation flows (add/consume/move/update/delete archive) are implemented with sync-state tracking.
- Product backend integration is not complete:
  - Product module orchestration is implemented and DI-wired.
  - Remote gateway chain is currently stubbed (`FirestoreCatalogRepository` returns `nil`/throws), so Product remote fetch/query/upsert are effectively non-functional.
- Add Product flow still uses legacy `Domain/AddProduct` inventory repository path, not `InventoryModule` use cases, so write/read behavior is split across two systems.

## 2) Where We Are (Code + Docs Reconciliation)

### 2.1 Inventory module and app integration

Implemented:
- Package exists and is test-covered (`Packages/InventoryModule`).
- Core offline-first use cases are implemented (add, consume FEFO, move, update dates, archive-delete, expired/expiring queries, sync pending, warm-up).
- App DI uses:
  - `RealmInventoryModuleRepository`
  - `RealmInventoryModuleLocationRepository`
  - `RealmInventoryModuleSyncStateStore`
  - `RealmInventoryModuleWarmupRunStore`
  - `FirestoreInventoryModuleRemoteGateway`
- Home and Inventory tab reads are module-driven for active/expiring use cases.

Current backend characteristics:
- Remote upsert is implemented.
- Remote read currently fetches only active items for a household (`status == "active"`).
- Sync observability exists (`AppInventorySyncObservability`) and retry policy is wired.

Known gaps:
- No global app lifecycle trigger for `syncPendingInventory` (Product has one; Inventory does not).
- Remote refresh strategy is “fetch active and upsert local,” which does not reconcile remote removals/archives done on another device (missing tombstone/deletion reconciliation).
- Inventory list screen currently reads repository directly (`inventoryModuleInventoryRepository`) instead of going through module service/use-case façade.

### 2.2 Product module and app integration

Implemented:
- Package exists and is test-covered (`Packages/ProductModule`).
- Offline-first orchestration and sync metadata strategy are implemented.
- Local store adapter exists (`RealmProductLocalStore`).
- Sync-state adapter exists (`RealmProductSyncStateStore`).
- Lifecycle trigger exists for `productModuleService.syncPending(...)` in `KeepItFreshApp`.

Current backend characteristics:
- DI remote gateway is `CatalogProductRemoteGateway`.
- `CatalogProductRemoteGateway` delegates to `CatalogRepository` (`FirestoreCatalogRepository`).
- `FirestoreCatalogRepository` is currently a stub:
  - `findRemote` returns `nil`
  - `upsertRemote` throws `remoteUnavailable`
  - no remote query implementation

Known gaps:
- Product remote read/write path is not actually integrated with Firestore yet.
- Product query pagination/filter/sort is only local in practical behavior because remote query returns empty.

### 2.3 Add Product flow integration state

Current state:
- `AddProductFlowUseCase` still uses legacy `Domain/AddProduct/Repositories/InventoryRepository`.
- Default assembler path uses `RealmInventoryRepository` (legacy path).
- Legacy remote inventory repository path is effectively unavailable by default (`remoteAvailable = false`), so remote writes in this flow usually enqueue fallback sync and do not hit Firestore.
- Catalog lookups in Add Product use ProductModule-backed bridge for catalog service, but remote capability is constrained by Product remote stubs above.

Impact:
- App now has mixed architecture paths:
  - New module path (InventoryModule/ProductModule)
  - Legacy AddProduct path (old repositories)
- This is the biggest integration consistency risk before full Firebase rollout.

## 3) Target Backend Architecture (Firebase)

### 3.1 Firestore collections (recommended)

- Product catalog (global): `ProductCatalog/{productId}`.
- Household inventory (scoped): `Houses/{householdId}/Purchases/{inventoryItemId}`.

Notes:
- Keep Product canonical and inventory instance-based.
- Inventory references Product by `productId` only (optional lightweight snapshot for offline UI).
- Archive semantics remain soft-delete by status (`archived`), not document hard delete by default.

### 3.2 Offline-first behavior (target)

- Add/Update/Delete/Consume:
  1. Persist local.
  2. Mark sync metadata.
  3. Attempt remote sync if online.
  4. Retry via `syncPending` with backoff.
- Retrieve:
  1. Return local immediately.
  2. If local miss, fetch remote and backfill local.
  3. If local hit and online, refresh in background.
- Home launch warm-up:
  - one-time per launch per household for next 14 days (already implemented in module flow).

## 4) Integration Gaps to Close (Priority)

## P0 (must complete before saying backend is integrated)

1. Implement real Firestore Product remote adapter.
- Replace `FirestoreCatalogRepository` stub behavior with real reads/writes/queries.
- Support:
  - fetch by barcode/productId
  - query pagination/filter/sort (or an explicit subset with documented limits)
  - upsert behavior for app-authored product records (if enabled).

2. Migrate Add Product flow inventory writes/reads to InventoryModule service.
- Replace legacy `InventoryRepository` usage in `AddProductFlowUseCase` with module use cases (`addInventoryItem`, optional lookup via module query path).
- Remove/retire legacy inventory remote fallback path for this flow once module path is live.

3. Add Inventory sync lifecycle trigger.
- Mirror Product’s lifecycle trigger approach in `KeepItFreshApp` for `syncPendingInventory`.
- Keep throttled/best-effort semantics.

4. Implement remote reconciliation strategy for Inventory.
- Current “fetch active + local upsert” misses remote archival/deletion done elsewhere.
- Add one:
  - full-state reconciliation endpoint (active + archived relevant set), or
  - delta feed with tombstones (`updatedSince` + status changes), or
  - explicit remote revision checkpoints.

## P1 (strongly recommended next)

1. Move Inventory tab reads behind module façade.
- Introduce use case(s) for list query (paged/sorted/filtered) so Presentation does not depend directly on repositories.

2. Harden Firestore indexes and query shape.
- Validate needed composite indexes for:
  - `household + status + expiry`
  - product/category sort/filter combinations (if implemented remotely).

3. Add conflict/version metadata policy.
- For multi-device consistency, define and enforce merge strategy using version/timestamps and idempotency IDs.

4. Add end-to-end integration tests against emulator/staging.
- Product fetch/query/upsert.
- Inventory mutation sync and cross-device reconciliation.

## 5) Step-by-Step Implementation Plan

1. Product Firestore adapter implementation.
- Build `FirestoreCatalogRepository` for real:
  - map Firestore schema <-> `ProductCatalogItem`/`ProductModule` product model.
  - use `ProductCatalog/{productId}` as the canonical collection path.
  - implement remote lookup by barcode.
  - implement remote query with cursor paging.
- Update/extend tests around `CatalogProductRemoteGateway`.

2. Product query strategy alignment.
- Decide minimum supported remote query contract for `ProductQuery`.
- Document unsupported filter/sort combinations and fallback behavior.

3. Add Product migration to module path.
- Create app adapter/use-case bridge so `AddProductFlowUseCase` uses `InventoryModuleServicing`.
- Keep behavior parity:
  - local-first
  - merge-or-create
  - sync metadata/idempotency.
- Remove duplicate legacy sync queue reliance for this flow.

4. Inventory sync trigger at app lifecycle.
- Add `InventoryPendingSyncTrigger` actor similar to `ProductPendingSyncTrigger`.
- Trigger on `.main` + app active, with throttling and bounded limits.

5. Inventory reconciliation upgrade.
- Extend `InventoryRemoteGateway` contract and Firestore adapter to support reconciliation (tombstones/delta/full snapshot by status windows).
- use `Houses/{householdId}/Purchases/{inventoryItemId}` as the canonical inventory path.
- Update `GetExpired/GetExpiring/Warmup` refresh internals to apply reconciliation, not just blind upsert.

6. Security rules + indexes + observability.
- Confirm Firestore rules enforce household scope.
- Add/verify indexes used by queries.
- Route `InventorySyncEvent` and product sync outcomes into analytics/monitoring.

7. Final cleanup and deprecation.
- Decommission legacy AddProduct repositories for inventory remote path when migration completes.
- Keep only module-driven business paths for Product/Inventory.

## 6) Definition of Done for “Firebase Integrated”

- Product:
  - Remote lookup/query is functional in production (not stubbed).
  - Offline-first local cache + remote refresh works with measurable sync outcomes.
- Inventory:
  - All mutation and read flows used by app screens go through InventoryModule services/use cases.
  - Lifecycle sync replay is active.
  - Cross-device reconciliation handles archive/status transitions correctly.
- Architecture:
  - No critical user flow depends on legacy AddProduct inventory remote stubs.
  - Module boundaries remain backend-agnostic; Firebase remains in app infrastructure adapters.

## 7) Recommended Immediate Next Sprint (Practical)

1. Implement `FirestoreCatalogRepository` real remote read/query for Product.
2. Add `InventoryPendingSyncTrigger` in `KeepItFreshApp`.
3. Start Add Product migration to `InventoryModuleServicing` for save path first.
4. Add reconciliation design RFC for inventory remote refresh (tombstones/delta).
