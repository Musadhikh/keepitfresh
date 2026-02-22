# # Add Product Flow – Implementation Plan
# Purpose
This document defines how the **Add Product Module** should be implemented in code using:
* Clean Architecture
* Swift + SwiftUI
* Async/Await
* Actor-based concurrency where appropriate
* Offline-first design
* Firestore as a replaceable data source

⠀This file is intended to guide Codex when scaffolding the module.

# High-Level Architecture
```
### Presentation (SwiftUI)
###     ↓
### Application / UseCase Layer
###     ↓
### Domain Layer (Protocols + Models)
###     ↓
### Data Layer (Local DB + Firestore)
```

# older Structure
```
### AddProduct/
###     Domain/
###         Models/
###         Repositories/
###         Services/
###         UseCases/
###     Data/
###         Local/
###         Remote/
###         Mappers/
###     Presentation/
###         ViewModels/
###         Screens/
###         Components/
###     DI/
```

# 1\. Domain Layer
# 1.1 Models
Use models defined in:
* AddProductModuleSpec.md

⠀Ensure:
* All models are Sendable
* No Firestore imports
* No Realm/SwiftData imports

⠀Domain must be platform-agnostic.

# 1.2 Repository Protocols
Already defined in spec:
* InventoryRepository
* CatalogRepository
* VisionExtracting
* DraftBuilding
* HouseholdContextProviding

⠀These must not depend on Firestore or any specific database.

# 2\. Application Layer
# 2.1 AddProductFlowUseCase
This is the orchestration engine.
### Responsibilities
* Handle barcode input
* Coordinate resolution pipeline
* Build ProductDraft
* Manage state transitions
* Save inventory
* Handle offline fallback

⠀
# 2.2 State Machine
```

### enum AddProductState {
###     case idle
###     case scanning
###     case resolving(barcode: Barcode)
###     case inventoryFound(InventoryItem)
###     case catalogFound(ProductCatalogItem)
###     case captureImages
###     case extracting
###     case reviewing(ProductDraft)
###     case saving
###     case success(String)
###     case failure(String)
### }
```

# 2.3 Use Case Skeleton

```
### final actor AddProductFlowUseCase {

###     private let inventoryRepository: InventoryRepository
###     private let catalogRepository: CatalogRepository
###     private let visionExtractor: VisionExtracting
###     private let draftBuilder: DraftBuilding
###     private let householdProvider: HouseholdContextProviding

###     private(set) var state: AddProductState = .idle

###     init(
###         inventoryRepository: InventoryRepository,
###         catalogRepository: CatalogRepository,
###         visionExtractor: VisionExtracting,
###         draftBuilder: DraftBuilding,
###         householdProvider: HouseholdContextProviding
###     ) {
###         self.inventoryRepository = inventoryRepository
###         self.catalogRepository = catalogRepository
###         self.visionExtractor = visionExtractor
###         self.draftBuilder = draftBuilder
###         self.householdProvider = householdProvider
###     }
### }
```
# 3\. Resolution Pipeline Implementation
# 3.1 Handle Barcode
### func handleBarcode(_ barcode: Barcode) async
Steps:
1. state = .resolving(barcode)
2. Get current householdId
3. Check inventory local
4. If found → state = .inventoryFound
5. Else check inventory remote
6. If found → sync local → state = .inventoryFound
7. Else check catalog local
8. If found → state = .catalogFound
9. Else check catalog remote
10. If found → cache local → state = .catalogFound
11. Else → state = .captureImages

⠀
# 3.2 Parallel Optimization
Recommended:
* Inventory local first (fast)
* If miss:
  * Run inventory remote + catalog local in parallel
* Then catalog remote

⠀But first successful strong hit wins:
Priority: Inventory > Catalog > AI

# 4\. AI Extraction Flow
# 4.1 Capture Images
UI collects image data.
Call:
### func handleCapturedImages(_ images: [Data]) async
Steps:
1. state = .extracting
2. Run VisionExtracting
3. If barcode found → restart resolution
4. Else:
   * Build ProductDraft via draftBuilder
   * state = .reviewing(draft)

⠀
# 5\. Draft Builder Rules
# 5.1 From Inventory
* Source: .inventoryLocal or .inventoryRemote
* Lock catalog fields
* Quantity default = 1

⠀5.2 From Catalog
* Source: .catalogLocal or .catalogRemote
* Lock catalog fields
* Editable inventory fields

⠀5.3 From Extraction
* Source: .aiExtraction
* All fields editable
* Attach confidence metadata

⠀
# 6\. Save Implementation
# 6.1 Save Draft
### func saveDraft(_ draft: ProductDraft) async
Steps:
1. state = .saving
2. Get householdId
3. Create or update InventoryItem
4. Save locally
5. Try remote upsert
6. If remote fails:
   * enqueue sync operation
7. state = .success(itemId)

⠀
# 7\. Data Layer Implementation
# 7.1 Local Storage
You may use:
* SwiftData
* Realm
* SQLite
* CoreData

⠀Must implement:
* Local InventoryRepository
* Local CatalogRepository

⠀
# 7.2 Remote (Firestore)
Create:
* FirestoreInventoryRepository
* FirestoreCatalogRepository

⠀These implement domain protocols.
Important:
* No Firestore types leak outside Data layer.
* Map Firestore DTOs to Domain models.

⠀
# 8\. Presentation Layer
# 8.1 ViewModel
Use @MainActor ViewModel that observes use case state.
Example:
```
### @MainActor
### final class AddProductViewModel: ObservableObject {

###     @Published private(set) var state: AddProductState = .idle

###     private let useCase: AddProductFlowUseCase

###     init(useCase: AddProductFlowUseCase) {
###         self.useCase = useCase
###     }
### }
```

ViewModel responsibilities:
* Start scanning
* Pass barcode to use case
* Observe state changes
* Trigger navigation

⠀
# 8.2 Screens
### BarcodeScannerView
* Emits AsyncStream<Barcode>

⠀CaptureImagesView
* Returns image data

⠀ReviewProductView
* Binds to ProductDraft
* Shows locked fields
* Save button

⠀
# 9\. Concurrency Model
* UseCase = actor
* Repositories may be actors if local DB requires thread safety
* ViewModel = @MainActor
* Vision extraction = async background task
* No blocking main thread

⠀
# 10\. Offline Strategy
* Always save locally first
* Remote sync best-effort
* Maintain sync queue
* Sync on app launch or connectivity regain

⠀
# 11\. Duplicate Handling Rules
If inventory item already exists:
Default behavior:
* Increment quantity in latest batch

⠀If expiry differs:
* Create new batch

⠀Optional improvement:
* Prompt user only if necessary

⠀
# 12\. Error Handling
Categories:
* Camera permission denied
* Network unavailable
* Firestore timeout
* Vision extraction failure
* Barcode scan failure

⠀Errors must:
* Not crash flow
* Allow retry
* Allow manual fallback

⠀
# 13\. Performance Goals
Inventory hit:
* 1 tap to complete

⠀Catalog hit:
* 1 tap to complete

⠀AI path:
* 2 captures + save

⠀Target: Under 5 seconds total for common case

# 14\. Future Extensibility
Design must allow:
* Replacing Firestore
* Adding third-party barcode APIs
* Adding nutrition parsing module
* Adding category-specific forms
* Supporting multiple barcodes per product
* Admin override of locked fields

⠀
# 15\. What Codex Should Generate
When generating code, Codex must:
1. Create full Domain models
2. Create repository protocols
3. Create AddProductFlowUseCase actor
4. Create ViewModel
5. Create SwiftUI screens
6. Provide mock repositories
7. Keep Firestore optional
8. Follow Clean Architecture strictly
9. Use async/await
10. Ensure all models are Sendable

⠀
This implementation plan works together with:
### AddProductModuleSpec.md