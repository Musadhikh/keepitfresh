# InventoryModule

`InventoryModule` is the business-logic package for household inventory in KeepItFresh.

It provides:
- A single import surface: `import InventoryModule`
- Domain models for inventory batches/items, locations, quantity, and date metadata
- Application service contracts for merge-or-create, FEFO consumption, date/location updates, and inventory queries
- Data-layer scaffolding interfaces and in-memory adapters for early integration/testing

It intentionally excludes:
- SwiftUI views, routes, navigation, and app presentation concerns
- App-specific DI registration (Factory remains in app composition root)

## Package Structure

- `InventoryDomain`: Entities, value objects, errors, repository ports
- `InventoryApplication`: Use-case contracts and policy utilities
- `InventoryData`: DTO/persistence mapping scaffolding + in-memory repositories
- `InventoryModule`: Public facade exports for single-import consumer ergonomics

## Verification

```bash
swift build --package-path Packages/InventoryModule
swift test --package-path Packages/InventoryModule
```
