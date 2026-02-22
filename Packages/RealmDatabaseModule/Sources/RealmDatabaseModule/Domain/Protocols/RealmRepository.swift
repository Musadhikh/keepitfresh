//
//  RealmRepository.swift
//  RealmDatabaseModule
//
//  Created by musadhikh on 22/2/26.
//  Summary: Generic repository abstraction for actor-safe Realm CRUD operations.
//

import Foundation

public protocol RealmRepository<Model>: Sendable {
    associatedtype Model: Sendable

    func upsert(_ model: Model, policy: RealmWritePolicy) async throws
    func upsert(_ models: [Model], policy: RealmWritePolicy) async throws
    func fetchAll(sortedBy descriptors: [RealmSortDescriptor]) async throws -> [Model]
    func fetch<PrimaryKey: Sendable>(primaryKey: PrimaryKey) async throws -> Model?
    func delete<PrimaryKey: Sendable>(primaryKey: PrimaryKey) async throws
    func deleteAll() async throws
}
