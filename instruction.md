# instruction.md

## 📌 Project Context
**Keep it Fresh** is an iOS app (Swift 6, SwiftUI, iOS minimum version 18) for:
- Tracking **expiry dates** of items
- Managing **households** (items grouped by household)
- **Camera scanning** (labels/barcodes) to auto-fill fields
- **LocalNotifications** before items expire  
**Data layer:** Cloud Firestore with **offline persistence & cache**.

**Architecture:** Clean (Domain / Data / Presentation / Shared), MVVM, protocol-driven, concurrency-safe with actors.

---

## 🧱 Tech Stack & Libraries
- **Firebase**: Firestore (+ offline cache), Auth (optional), App Check (Recommended), Messaging (optional)
- **Swift Packages**: `FirebaseFirestore`, `FirebaseFirestoreSwift`, `FirebaseAuth` (if needed)
- **UI**: SwiftUI (iOS 18+ APIs where helpful)
- **Testing**: XCTest (+ Firestore emulator for integration tests if possible)

---

## 🧩 Coding Guidelines
1. **Data Access**
   - Use **Repository pattern** with protocols.
   - Prefer **query listeners** (`addSnapshotListener`) for live updates.
   - Support **offline-first**: Firestore will read from local cache immediately, then sync.
2. **Concurrency**
   - Use `async/await` wrappers for Firestore operations.
   - Use **actors** for shared mutable state (e.g., `InventoryActor`).
3. **UI**
   - SwiftUI views consume **@Observable** ViewModels.
   - Provide lightweight **previews with sample data**.
   - Previews and Prewview data should only avaialable in Debug mode
4. **Error Handling**
   - Map Firestore errors to domain errors (e.g., `DataError.network`, `DataError.permission`).
5. **Testing**
   - Repositories coded to interfaces; provide **in-memory fakes**.
   - Where possible, target **Firestore emulator** for integration tests.

---

## 🔐 Firebase Initialization & Offline Cache

```swift
import FirebaseCore
import FirebaseFirestore

@main
struct KeepItFreshApp: App {
    init() {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        let settings = db.settings
        // iOS has persistence enabled by default, but set explicitly for clarity:
        settings.isPersistenceEnabled = true
        // Optional: adjust cache size (bytes). 100 MB default.
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: 200 * 1024 * 1024) // 200MB
        db.settings = settings
    }

    var body: some Scene {
        WindowGroup { RootView() }
    }
}
```

---

## 🧪 Data Model (Firestore Documents)

**Collections**
- `/households/{householdId}`
- `/households/{householdId}/items/{itemId}`
- `/households/{householdId}/purchases/{purchaseId}` (optional history)

**Swift Models**

```swift
import FirebaseFirestoreSwift

struct Household: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var createdAt: Date
    var ownerUID: String
    var memberUIDs: [String]
}

enum ExpiryStatus: String, Codable { case fresh, expiringSoon, expired }

struct Item: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var category: String?
    var expiryDate: Date?
    var addedDate: Date
    var notes: String?
    var barcode: String?
    var status: ExpiryStatus
}

struct Purchase: Codable, Identifiable {
    @DocumentID var id: String?
    var itemId: String
    var quantity: Int
    var purchasedAt: Date
    var unit: String?
}
```

---

## 🗃️ Repositories (Protocols)

```swift
protocol HouseholdRepository {
    func createHousehold(_ household: Household) async throws -> String
    func observeHouseholds(for uid: String) -> AsyncStream<[Household]>
}

protocol ItemRepository {
    func upsertItem(_ item: Item, in householdId: String) async throws -> String
    func deleteItem(_ itemId: String, in householdId: String) async throws
    func observeItems(in householdId: String) -> AsyncStream<[Item]>
    func observeItemsExpiringSoon(in householdId: String, within days: Int) -> AsyncStream<[Item]>
}
```

---

## 📂 Project Structure

```
Sources/
 ├── Domain/
 │    ├── Models/ (Household, Item, Purchase, ExpiryStatus)
 │    ├── Services/ (ExpiryService, ReminderScheduler)
 │    └── Protocols/ (ItemProviding, HouseholdProviding)
 ├── Data/
 │    ├── Firestore/ (FirestoreItemProvider, FirestoreHouseholdProvider, DTOs)
 │    └── Mappers/ (Model <-> Firestore document)
 ├── Presentation/
 │    ├── Views/ (ExpiryListView, HouseholdView, DebugView)
 │    └── ViewModels/ (InventoryViewModel, HouseholdViewModel)
 └── Utils/
      ├── Utilities/ (AsyncStream helpers, Date utils)
      └── Debug/ (Floating debug button, DebugView)
```
## Folder Structure

- **Data**
  - Contains actual implementations of protocols defined in the `Domain` layer.
  - Related items should be grouped into folders (e.g., `Repositories`, `Network`, `Persistence`).
  - Do not define new protocols here — only implement ones declared in `Domain`.

- **Domain**
  - Contains only **protocols** and **models**.
  - All protocol names must end with `Providing`.  
    Example: `DownloadProviding`, `UserProviding`.
  - Models must:
    - Be inside the `Model` folder.
    - Be declared as `struct`.
    - Conform to `Codable`.

- **Presentation**
  - Contains all **SwiftUI Views**, **ViewModels**, and UI-related logic.
  - ViewModels must follow `@Observable` from Swift and conform to MVVM practices.
  - Avoid any business logic here — delegate to `Domain`.

- **Utils**
  - Contains reusable helpers, extensions, and utilities.
  - Should not depend on other layers.

- **Resources**
  - Contains assets, localization files, JSON mocks, and static resources.

---

## ✅ Copilot Prompting Hints
- “Generate a Firestore repository that observes items for a household with offline cache.”
- “Create a SwiftUI ExpiryListView grouping items by expired/expiringSoon/fresh.”
- “Write a ViewModel that listens to Firestore changes via AsyncStream.”
- “Add a save pipeline using AsyncStream that reports scanning → parsing → upsert steps.”
- “Provide Firestore security rules ensuring only household members can read/write.”
---

### What Copilot Should Prefer
- Firestore with **offline cache**.
- `async/await`, **actors**, `AsyncStream` for listeners/progress.
- SwiftUI-first components with previews.
- Protocol-driven, testable repositories.
- Minimal UIKit; only when necessary (e.g., VisionKit wrapper).

---
