//
//  RealmObjectRepositoryTests.swift
//  RealmDatabaseModuleTests
//
//  Created by Codex on 22/2/26.
//  Summary: Verifies non-Realm <-> Realm mapping and actor-safe CRUD behavior.
//

import XCTest
import RealmSwift
@testable import RealmDatabaseModule

final class RealmObjectRepositoryTests: XCTestCase {
    func testUpsertAndFetchByPrimaryKey() async throws {
        let repository = makeRepository()

        let apple = PantryItem(id: "001", name: "Apple", quantity: 4)
        try await repository.upsert(apple, policy: .modified)

        let stored = try await repository.fetch(primaryKey: "001")
        XCTAssertEqual(stored, apple)
    }

    func testUpsertManyAndSortedFetch() async throws {
        let repository = makeRepository()

        try await repository.upsert([
            PantryItem(id: "003", name: "Tea", quantity: 2),
            PantryItem(id: "001", name: "Rice", quantity: 1),
            PantryItem(id: "002", name: "Milk", quantity: 3)
        ], policy: .modified)

        let sorted = try await repository.fetchAll(sortedBy: [
            RealmSortDescriptor(keyPath: "id", ascending: true)
        ])

        XCTAssertEqual(sorted.map(\.id), ["001", "002", "003"])
    }

    func testDeleteAndDeleteAll() async throws {
        let repository = makeRepository()

        try await repository.upsert([
            PantryItem(id: "001", name: "Rice", quantity: 1),
            PantryItem(id: "002", name: "Milk", quantity: 3)
        ], policy: .modified)

        try await repository.delete(primaryKey: "001")
        let deleted = try await repository.fetch(primaryKey: "001")
        XCTAssertNil(deleted)

        try await repository.deleteAll()
        let remaining = try await repository.fetchAll()
        XCTAssertTrue(remaining.isEmpty)
    }

    private func makeRepository() -> RealmObjectRepository<PantryItemObject> {
        RealmObjectRepository(
            configuration: RealmStoreConfiguration(
                schemaVersion: 1,
                inMemoryIdentifier: "RealmDatabaseModuleTests-\(UUID().uuidString)",
                fileURL: nil,
                deleteRealmIfMigrationNeeded: true,
                isReadOnly: false
            )
        )
    }
}

struct PantryItem: Sendable, Equatable {
    let id: String
    let name: String
    let quantity: Int
}

@objc(PantryItemObject)
final class PantryItemObject: Object, RealmModelConvertible {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var name: String = ""
    @Persisted var quantity: Int = 0

    static func makeRealmObject(from model: PantryItem) -> PantryItemObject {
        let object = PantryItemObject()
        object.id = model.id
        object.name = model.name
        object.quantity = model.quantity
        return object
    }

    func makeDomainModel() throws -> PantryItem {
        PantryItem(id: id, name: name, quantity: quantity)
    }
}
