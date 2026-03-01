//
//  RealmCodableRepositoryTests.swift
//  RealmDatabaseModuleTests
//
//  Created by musadhikh on 22/2/26.
//  Summary: Verifies Codable domain model persistence without exposing Realm object types.
//

import XCTest
@testable import RealmDatabaseModule

final class RealmCodableRepositoryTests: XCTestCase {
    func testUpsertAndFetch() async throws {
        let repository = makeRepository()
        let record = SampleRecord(id: "u1", name: "Musadhikh", count: 4)

        try await repository.upsert(record)

        let loaded = try await repository.fetch(primaryKey: "u1")
        XCTAssertEqual(loaded, record)
    }

    func testDeleteAndDeleteAll() async throws {
        let repository = makeRepository()

        try await repository.upsert(SampleRecord(id: "u1", name: "One", count: 1))
        try await repository.upsert(SampleRecord(id: "u2", name: "Two", count: 2))

        try await repository.delete(primaryKey: "u1")
        let removed = try await repository.fetch(primaryKey: "u1")
        XCTAssertNil(removed)

        try await repository.deleteAll()
        let second = try await repository.fetch(primaryKey: "u2")
        XCTAssertNil(second)
    }

    private func makeRepository() -> RealmCodableRepository<SampleRecord> {
        RealmCodableRepository(
            namespace: "realm_codable_repository_tests",
            configuration: RealmStoreConfiguration(
                schemaVersion: 1,
                inMemoryIdentifier: "RealmCodableRepositoryTests-\(UUID().uuidString)",
                fileURL: nil,
                deleteRealmIfMigrationNeeded: true,
                isReadOnly: false
            ),
            keyForModel: { $0.id }
        )
    }
}

private struct SampleRecord: Codable, Equatable, Sendable {
    let id: String
    let name: String
    let count: Int
}

