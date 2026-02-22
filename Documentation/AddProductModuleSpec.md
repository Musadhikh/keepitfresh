# Add Product Module Spec
### Goal
Fastest path: **Scan → (inventory hit) → +1 → Done** Fallback: **Scan → (catalog hit) → confirm dates/qty → Save** Worst case: **Scan fails / not found → Photos → Vision+Foundation → Edit → Save**

## Screens
1. **Home**
* Floating “Add” button (icon + text)
* Action: open AddProductFlow (scanner)
1. **Barcode Scanner**
* Continuous scanning
* On detection: freeze + haptic + start resolve pipeline
* Actions:
  * Enter barcode manually
  * Skip barcode → Camera capture
1. **Resolve Bottom Sheet (inline on scanner)**
* States:
  * Looking up…
  * Found in inventory (quick actions)
  * Found in catalog (Continue)
  * Not found (Continue to camera)
  * Error (Retry / Manual)
1. **Camera Capture**
* Capture 1–3 images
* Guided prompts (front/back/date area)
* After capture: extract + build draft
1. **Review / Edit (Unified)**
* Form driven by ProductDraft
* Locks fields by source
* Save + Save & Add Another

⠀
## Domain Concepts
### Models


```
enum ProductDataSource: Sendable {
    case inventoryLocal
    case inventoryRemote
    case catalogLocal
    case catalogRemote
    case aiExtraction
    case manual
}

struct Barcode: Sendable, Hashable {
    let value: String
    let symbology: String? // e.g. EAN-13, UPC-A
}

struct ProductCatalogItem: Sendable, Identifiable, Hashable {
    let id: String              // usually barcode
    let barcode: Barcode
    let title: String?
    let brand: String?
    let description: String?
    let images: [URL]?
    let categories: [String]?
    let size: String?           // "500ml", "200g" etc
}

struct InventoryBatch: Sendable, Identifiable, Hashable {
    let id: String              // UUID or deterministic
    var quantity: Int
    var unit: String?           // pcs, pack, bottle
    var dates: [DateInfo]       // expiry/packed/manufactured
    var notes: String?
}

struct InventoryItem: Sendable, Identifiable, Hashable {
    let id: String              // householdId + barcode.value
    let householdId: String
    let barcode: Barcode
    var catalogRefId: String?   // barcode string
    var batches: [InventoryBatch]
    var updatedAt: Date?
}

struct FieldConfidence<T: Sendable>: Sendable {
    var value: T?
    var confidence: Double?     // 0...1
    var rawText: String?
}

struct ProductExtractionResult: Sendable {
    var barcodeCandidates: [Barcode]
    var title: FieldConfidence<String>
    var brand: FieldConfidence<String>
    var size: FieldConfidence<String>
    var categories: FieldConfidence<[String]>
    var description: FieldConfidence<String>
    var images: [URL]?          // optional; usually captured locally
    var dateInfo: [DateInfo]?
}

struct ProductDraft: Sendable, Identifiable {
    let id: String // UUID
    var source: ProductDataSource

    var barcode: Barcode?
    var catalog: ProductCatalogItem?  // when resolved

    // Editable fields (some might be locked)
    var title: String?
    var brand: String?
    var description: String?
    var categories: [String]?
    var size: String?
    var images: [Data] // local image blobs or file refs

    // Inventory fields
    var quantity: Int
    var unit: String?
    var dateInfo: [DateInfo]
    var notes: String?

    // UX metadata
    var lockedFields: Set<ProductField>
    var fieldConfidences: [ProductField: Double] // AI only
}

enum ProductField: Sendable, Hashable {
    case barcode, title, brand, description, categories, size, images
    case quantity, unit, dateInfo, notes
}
```

### Locking rules
* If source is .catalogLocal/.catalogRemote/.inventoryLocal/.inventoryRemote Locked: .barcode, .title, .brand, .description, .categories, .size, .images Editable: .quantity, .unit, .dateInfo, .notes
* If source is .aiExtraction or .manual All editable by default (barcode may still be locked if scanned and confident—optional rule)

⠀
## Repositories / Services (Domain protocols)


```
protocol HouseholdContextProviding: Sendable {
    func currentHouseholdId() async throws -> String
}

protocol BarcodeScanning: Sendable {
    func scanBarcodes() -> AsyncStream<Barcode>
}

protocol InventoryRepository: Sendable {
    func findLocal(householdId: String, barcode: Barcode) async throws -> InventoryItem?
    func findRemote(householdId: String, barcode: Barcode) async throws -> InventoryItem?

    func upsertLocal(_ item: InventoryItem) async throws
    func upsertRemote(_ item: InventoryItem) async throws

    func enqueueSync(_ operation: InventorySyncOperation) async
}

protocol CatalogRepository: Sendable {
    func findLocal(barcode: Barcode) async throws -> ProductCatalogItem?
    func findRemote(barcode: Barcode) async throws -> ProductCatalogItem?

    func cacheLocal(_ item: ProductCatalogItem) async throws
}

protocol VisionExtracting: Sendable {
    func extract(from images: [Data]) async throws -> ProductExtractionResult
}

protocol DraftBuilding: Sendable {
    func fromInventory(_ item: InventoryItem, catalog: ProductCatalogItem?) -> ProductDraft
    func fromCatalog(_ item: ProductCatalogItem, barcode: Barcode) -> ProductDraft
    func fromExtraction(_ extraction: ProductExtractionResult, preferredBarcode: Barcode?) -> ProductDraft
}
```


## Use Case Orchestrator
### State machine


```
enum AddProductState: Sendable, Equatable {
    case idle
    case scanning
    case resolving(barcode: Barcode)
    case inventoryFound(item: InventoryItem, source: ProductDataSource)
    case catalogFound(item: ProductCatalogItem, source: ProductDataSource)
    case captureImages
    case extracting
    case reviewing(draft: ProductDraft)
    case saving
    case success(savedItemId: String)
    case failure(message: String)
}
```

### Main flow rules (authoritative)
1. Start → scanning
2. On barcode detected → resolving(barcode)
3. Resolve pipeline order:
   * Inventory local
   * Inventory remote
   * Catalog local
   * Catalog remote
   * Else → capture images

⠀**Parallelism recommendation**
* Do inventory local first (fast)
* If miss, run inventory remote + catalog local in parallel
* If both miss, run catalog remote
* At any point, first “strong hit” wins (inventory beats catalog)

⠀Quick action (inventory hit)
* Default action: +1 quantity to latest batch OR create new batch (configurable)
* If tracking batches by expiry:
  * If user has “default batch behavior” = “ask when expiry differs”, then show mini prompt
  * Otherwise auto-add to most recent batch and allow undo

⠀
## Save rules
When saving from draft:
* If draft has barcode:
  * Ensure catalog exists (if AI/manual, may create local-only catalog record)
  * Create/Upsert inventory item keyed by householdId + barcode
  * Add batch (dates + qty + unit)
* If no barcode:
  * Create a local-only inventory item with generated id
  * Mark as needsBarcode = true (optional)
* Remote sync:
  * If online: upsert remote inventory
  * If offline: enqueue sync

⠀
## Firestore decoupling (implementation note)
In Data layer:
* FirestoreInventoryRepository: InventoryRepository
* FirestoreCatalogRepository: CatalogRepository

⠀But domain only sees protocols. Later you can swap:
* OpenFoodFacts / GS1 / custom API
* Algolia search
* DynamoDB backend

⠀
## UX Minimization Targets
* Inventory hit: **1 tap** (“+1”) → saved
* Catalog hit: **Save** after defaults (quantity=1, no dates) → 1 tap
* AI path: capture 2 photos + Save → 3 taps (capture, capture, save)

⠀
## Analytics / observability hooks (high value)
Track:
* time-to-add
* % inventory hits vs catalog hits vs AI
* barcode scan failures
* fields edited after AI (to improve prompts / extraction)
