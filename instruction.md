# instruction.md

## 📌 Project Context
**Keep it Fresh** is an iOS app (Swift 6, SwiftUI, iOS minimum version 18) for:
- Tracking **expiry dates** of items
- Managing **households** (items grouped by household)
- **Camera scanning** (labels/barcodes) to auto-fill fields
- **LocalNotifications** before item## ✅ Copilot Prompting Hints
- "Generate a Firestore repository that observes items for a household with offline cache."
- "Create a SwiftUI ExpiryListView grouping items by expired/expiringSoon/fresh."
- "Write a ViewModel that listens to Firestore changes via AsyncStream."
- "Add a save pipeline using AsyncStream that reports scanning → parsing → upsert steps."
- "Provide Firestore security rules ensuring only household members can read/write."
- "Create a splash screen with staggered animations and coordinator pattern."
- "Implement actor-based repository with AsyncStream listeners."
- "Build onboarding flow with authentication and household selection."
- "Design color system with semantic naming and gradient support."
- "Add animation constants with proper timing and easing functions."re  
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
protocol HouseholdProviding {
    func createHousehold(_ household: Household) async throws -> String
    func observeHouseholds(for uid: String) -> AsyncStream<[Household]>
    func getHousehold(id: String) async throws -> Household?
}

protocol ItemProviding {
    func upsertItem(_ item: Item, in householdId: String) async throws -> String
    func deleteItem(_ itemId: String, in householdId: String) async throws
    func observeItems(in householdId: String) -> AsyncStream<[Item]>
    func observeItemsExpiringSoon(in householdId: String, within days: Int) -> AsyncStream<[Item]>
}

protocol AuthProviding {
    var isAuthenticated: Bool { get async }
    func signIn() async throws
    func signOut() async throws
    func observeAuthState() -> AsyncStream<Bool>
}

protocol UserPreferencesProviding {
    func getLastSelectedHouseholdId() -> String?
    func setLastSelectedHouseholdId(_ id: String?)
    func getHasCompletedOnboarding() -> Bool
    func setHasCompletedOnboarding(_ completed: Bool)
}
```

---

## 📂 Project Structure

```
keepitfresh/
├── Domain/
│   ├── Models/
│   │   ├── Household.swift
│   │   ├── Item.swift
│   │   ├── Purchase.swift
│   │   └── ExpiryStatus.swift
│   ├── Protocols/
│   │   ├── AuthProviding.swift
│   │   ├── HouseholdProviding.swift
│   │   ├── ItemProviding.swift
│   │   └── UserPreferencesProviding.swift
│   └── Services/
│       └── ExpiryService.swift
├── Data/
│   └── Repositories/
│       ├── AuthRepository.swift
│       ├── HouseholdRepository.swift
│       ├── ItemRepository.swift
│       └── UserPreferencesRepository.swift
├── Presentation/
│   ├── Splash/
│   │   ├── SplashView.swift
│   │   └── SplashViewModel.swift
│   ├── Onboarding/
│   │   ├── OnboardingCoordinator.swift
│   │   └── OnboardingCoordinatorView.swift
│   └── Home/
│       └── HomeView.swift
├── Utils/
│   ├── Environment/
│   │   └── AppEnvironment.swift
│   ├── Constants/
│   │   └── AnimationConstants.swift
│   ├── Extensions/
│   │   └── Color+Extension.swift
│   └── Helpers/
│       └── AsyncStreamHelpers.swift
└── Resources/
    └── SampleData.swift
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
  - Each Feature should be inside a folder. eg: for Splash, the folder is Splash and it will have `SplashView.swift` and `SplashViewModel.swift`

- **Utils**
  - Contains reusable helpers, extensions, and utilities.
  - Should not depend on other layers.
  - Organized by type:
    - `Constants/` - Animation, styling, and other app constants
    - `Extensions/` - Swift/SwiftUI extensions (one per file)
    - `Environment/` - Dependency injection and app configuration
    - `Helpers/` - Utility functions and reusable code

- **Resources**
  - Contains assets, localization files, JSON mocks, and static resources.

## 🎨 UI & Animation Guidelines

1. **Splash Screen Implementation**
   - Use staggered animations for visual hierarchy
   - Minimum display duration: 2 seconds for loading tasks
   - Progressive disclosure: Icon → Text → Progress indicator
   - Use completion callbacks for navigation coordination

2. **Animation Standards**
   - Centralize animation constants in `AnimationConstants.swift`
   - Use semantic animation names (e.g., `splashIconSpring`, `sceneTransition`)
   - Prefer spring animations for interactive elements
   - Implement proper timing delays for choreographed sequences

3. **Color System**
   - Define app colors in `Color+Extension.swift`
   - Use semantic color names (e.g., `splashGradientStart`)
   - Gradient backgrounds for visual depth
   - Maintain consistent opacity patterns

4. **State Management**
   - Use `@Observable` for ViewModels (Swift 6)
   - Implement proper loading states with visual feedback
   - Handle navigation through coordinators
   - Separate animation state from business logic

---

## 🔄 App Lifecycle & Navigation

1. **App State Management**
   - Use coordinator pattern for complex navigation flows
   - Implement proper splash → onboarding → main app flow
   - Handle authentication state changes gracefully
   - Persist user preferences for seamless experience

2. **Onboarding Flow**
   - Splash screen with initialization tasks
   - Authentication check and routing
   - Household selection/creation logic
   - Smooth transitions between states

3. **Environment Configuration**
   - Dependency injection through `AppEnvironment`
   - Protocol-based service resolution
   - Easy testing through mock implementations
   - Clear separation of concerns

---

## 🏗️ Development Best Practices

- Use **actors** where concurrency is required.
- Follow **MVVM** strictly; do not introduce other patterns.
- Use only Apple's official APIs — avoid third-party patterns or frameworks unless explicitly allowed.
- Keep separation of concerns clear:
  - `Domain` = what the app *can do*.
  - `Data` = how it *does it*.
  - `Presentation` = how it's *shown*.
- Always prefer value types (`struct`) over reference types (`class`) for models.
- Strict SOLID patterns should follow
- Do not use singleton patterns other than Apple's native APIs.
- Files should be smaller and focused on one implementation
- Create separate files for individual struct, class, actors, enums etc.

## 🎯 File Organization Rules

1. **One Entity Per File**: Each struct, class, actor, enum gets its own file
2. **Feature-Based Folders**: Group related functionality (e.g., Splash/, Onboarding/)
3. **Extension Separation**: Extensions go in separate files with `+Extension` suffix
4. **Constants Organization**: Group by type (Animation, Color, etc.) in dedicated files
5. **Protocol Naming**: All protocols end with `Providing` for consistency
6. **Repository Implementation**: Use actors for thread-safe data access

## 🧪 Testing Strategy

- **Mock All Protocols**: Every `Providing` protocol should have a mock implementation
- **Sample Data**: Debug-only sample data in `Resources/SampleData.swift`
- **Actor Testing**: Test concurrent access patterns in repositories
- **UI Testing**: Focus on user flows and accessibility
- **Animation Testing**: Verify timing and state transitions

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
- **Coordinator pattern** for complex navigation flows.
- **Staggered animations** with proper timing and visual hierarchy.
- **Feature-based folder structure** with clear separation.
- **Extension files** with semantic naming (`+Extension` suffix).
- **Actor-based repositories** for thread-safe data access.

---
