# RealmDatabaseModule

Actor-safe Swift package for Realm persistence in a Clean Architecture setup.

## Why this module exists

- Keep domain models free from Realm types.
- Convert non-Realm models into Realm objects via explicit mapping contracts.
- Centralize CRUD operations in an actor to preserve isolation and avoid data races.

## Core pieces

- `RealmModelConvertible`: mapping contract (`DomainModel <-> Realm Object`).
- `RealmRepository`: domain-facing async CRUD protocol.
- `RealmObjectRepository<ObjectType>`: actor-backed generic Realm implementation.
- `CodableRealmRepository`: domain-facing contract for object-free persistence.
- `RealmCodableRepository<Model>`: actor-backed repository that stores Codable domain models without requiring Realm object types in the app module.
- `RealmStoreConfiguration`: sendable configuration model.

## Usage

```swift
import RealmSwift
import RealmDatabaseModule

struct ProductRecord: Sendable, Equatable {
    let id: String
    let title: String
}

final class ProductObject: Object, RealmModelConvertible {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var title: String = ""

    static func makeRealmObject(from model: ProductRecord) -> ProductObject {
        let object = ProductObject()
        object.id = model.id
        object.title = model.title
        return object
    }

    func makeDomainModel() throws -> ProductRecord {
        ProductRecord(id: id, title: title)
    }
}

let repository = RealmObjectRepository<ProductObject>()
try await repository.upsert(ProductRecord(id: "123", title: "Tea"), policy: .modified)
let saved = try await repository.fetch(primaryKey: "123")
```

### Object-free usage (no Realm model in app layer)

```swift
import RealmDatabaseModule

struct ProfileSyncRecord: Codable, Sendable {
    let userId: String
    let state: String
}

let repository = RealmCodableRepository<ProfileSyncRecord>(
    namespace: "profile_sync_records",
    keyForModel: { $0.userId }
)

try await repository.upsert(ProfileSyncRecord(userId: "abc", state: "pending"))
let saved = try await repository.fetch(primaryKey: "abc")
```

## Concurrency

All database operations are actor-isolated in `RealmObjectRepository` and `RealmCodableRepository`, and public APIs only expose sendable domain models.
