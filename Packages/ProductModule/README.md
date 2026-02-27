# ProductModule

`ProductModule` is the product-domain package for KeepItFresh.

It gives you:
- A single import surface: `import ProductModule`
- Product domain models (`Product`, `ProductDetails`, `ProductQuery`, etc.)
- Offline-first orchestration service (`DefaultProductModuleService`)
- Storage/network-agnostic ports for local DB, remote API, sync state, and connectivity

It intentionally does **not** include concrete Realm or remote API implementations. Those are injected from the host app.

## Why It Exists

This package isolates product logic from app/infrastructure details so product behavior is reusable, testable, and scalable.

- Product is the canonical catalog entity (shared knowledge about an item).
- Inventory is contextual stock state (household/user quantities, batches, expiry, etc.).
- Inventory should reference `productId` from Product, but Product should not depend on Inventory.

## Package Structure

The package has 3 internal targets and 1 public product:

- `ProductDomain`: Models + ports + identity helpers
- `ProductApplication`: Offline-first use cases/service orchestration
- `ProductModule`: Public facade exports (single import for consumers)

Public package product:
- `ProductModule`

## Identity Rules (Critical)

`productId` is the primary key and must be unique.

- Every product must have a non-empty `productId`.
- If barcode is present, `productId` **must equal** normalized barcode value.
- Barcode normalization uses `ProductIdentity.normalizeBarcode(_:)`.
- Empty/invalid values throw `ProductModuleError`.

Current validation errors:
- `.emptyProductID`
- `.invalidBarcode`
- `.productIDMustMatchBarcode(productID:normalizedBarcode:)`

## Public Service API

Main protocol:
- `ProductModuleServicing`

Operations:
- `retrieveProduct(by:)`
- `retrieveProducts(query:)`
- `addProducts(_:)`
- `updateProducts(_:)`
- `syncPending(limit:)`

Delete is planned for future scale-up. Port contracts already include delete operations, but service-level delete orchestration is not implemented yet.

## Offline-First Behavior

### Retrieve one product
- Try local first (`productId` or barcode lookup).
- If local hit:
  - return local immediately
  - optionally refresh from remote in background (based on read policy)
- If local miss:
  - if `.localOnly`, return `nil`
  - otherwise fetch remote, cache locally, return result
  - if offline, throw `.connectivityUnavailable(operation: .retrieveProduct)`

### Retrieve product list
- Query local first.
- If local has items:
  - return local immediately
  - optionally refresh from remote in background
- If local is empty:
  - if `.localOnly`, return empty page
  - otherwise fetch remote, cache, return result
  - if offline, throw `.connectivityUnavailable(operation: .retrieveProducts)`

### Add / update products
- Validate identity invariants.
- Save to local first with `pendingUpsert`.
- Try remote sync immediately when policy is `.localThenRemoteImmediate` and connectivity is online.
- On remote success: mark as `synced`.
- On remote failure/offline enqueue flow: keep pending/failed metadata for later sync.

### Sync pending
- Requires connectivity.
- Reads pending IDs from sync-state store.
- Pushes pending products to remote and updates sync metadata.
- If offline, throws `.connectivityUnavailable(operation: .syncPending)`.

## Product Model Snapshot

Core aggregate: `Product`

Main field groups:
- Identity: `productId`, `barcode`
- Display: `title`, `brand`, `shortDescription`, `images`
- Classification: `category`, `productDetails`
- Packaging/composition: `packaging`, `size`, `attributes`
- Governance/quality: `extractionMetadata`, `qualitySignals`, `compliance`
- Lifecycle: `source`, `status`, `createdAt`, `updatedAt`, `version`

`ProductDetails` is category-oriented and excludes inventory-only fields (like packaged/expiry dates and stock quantities).

## Required Integrations (Host App)

You must inject implementations for:
- `ProductLocalStore`
- `ProductRemoteGateway`
- `ProductSyncStateStore`
- `ConnectivityProviding`
- Optional: custom `ClockProviding`

Typical mapping in app infrastructure:
- `ProductLocalStore` -> Realm adapter
- `ProductRemoteGateway` -> API/Firestore adapter
- `ProductSyncStateStore` -> Realm sync metadata adapter
- `ConnectivityProviding` -> Network monitor adapter

## Quick Start

### 1) Import once

```swift
import ProductModule
```

### 2) Create service with injected adapters

```swift
import ProductModule

let service = DefaultProductModuleService(
    localStore: realmProductLocalStore,
    remoteGateway: productRemoteGateway,
    syncStateStore: realmProductSyncStateStore,
    connectivity: appConnectivityProvider,
    strategy: .offlineFirstDefault
)

let module = ProductModule(service: service)
```

### 3) Retrieve by barcode (local-first, remote fallback)

```swift
let product = try await module.service.retrieveProduct(
    by: .barcode("0123456789012")
)
```

### 4) Add product

```swift
let product = Product(
    productId: "0123456789012",
    barcode: Barcode(value: "0123456789012", symbology: .ean13),
    title: "Milk"
)

let result = try await module.service.addProducts([product])
```

### 5) Handle offline errors for UI messages/toasts

```swift
do {
    _ = try await module.service.retrieveProducts(query: ProductQuery())
} catch let error as ProductModuleError {
    if case .connectivityUnavailable(let operation) = error {
        // Show operation-specific offline message/toast
        print("Offline for operation: \(operation.rawValue)")
    }
}
```

## Sync Strategy Knobs

`ProductSyncStrategy` allows behavior tuning:
- Read policy: `localOnly`, `localThenRemoteIfStale`, `localThenRemoteAlwaysBackground`
- Write policy: `localThenRemoteImmediate`, `localThenEnqueue`
- Conflict policy: `lastWriteWins`, `remoteWins`, `localWins`, `merge`

Default: `.offlineFirstDefault`.

## Testing & Validation

Run package checks:

```bash
swift build --package-path Packages/ProductModule
swift test --package-path Packages/ProductModule
```

Current package tests validate:
- Product identity invariants (`productId` vs barcode)
- Local-miss remote-hit caching behavior
- Connectivity error behavior for offline scenarios
