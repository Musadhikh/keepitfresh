//
//  CodableRealmRepository.swift
//  RealmDatabaseModule
//
//  Created by musadhikh on 22/2/26.
//  Summary: Domain-facing repository contract for storing Codable domain models in Realm.
//

import Foundation

public protocol CodableRealmRepository<Model>: Sendable {
    associatedtype Model: Codable & Sendable

    func upsert(_ model: Model) async throws
    func fetch(primaryKey: String) async throws -> Model?
    func fetchAll() async throws -> [Model]
    func delete(primaryKey: String) async throws
    func deleteAll() async throws
}
