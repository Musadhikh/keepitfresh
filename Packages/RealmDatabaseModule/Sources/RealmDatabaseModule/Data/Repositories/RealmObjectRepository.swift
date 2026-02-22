//
//  RealmObjectRepository.swift
//  RealmDatabaseModule
//
//  Created by Codex on 22/2/26.
//  Summary: Actor-isolated generic repository that persists non-Realm models via conversion contracts.
//

import Foundation
import RealmSwift

public actor RealmObjectRepository<ObjectType>: RealmRepository
where ObjectType: Object & RealmModelConvertible {
    public typealias Model = ObjectType.DomainModel

    private let configuration: RealmStoreConfiguration

    public init(configuration: RealmStoreConfiguration = .default) {
        self.configuration = configuration
    }

    public func upsert(_ model: Model, policy: RealmWritePolicy = .modified) async throws {
        try await upsert([model], policy: policy)
    }

    public func upsert(_ models: [Model], policy: RealmWritePolicy = .modified) async throws {
        guard !models.isEmpty else { return }

        let realm = try openRealm()
        do {
            try realm.write {
                for model in models {
                    let object = ObjectType.makeRealmObject(from: model)
                    realm.add(object, update: policy.toRealmUpdatePolicy())
                }
            }
        } catch {
            throw RealmDatabaseError.writeFailed(reason: error.localizedDescription)
        }
    }

    public func fetchAll(sortedBy descriptors: [RealmSortDescriptor] = []) async throws -> [Model] {
        let realm = try openRealm()
        var results = realm.objects(ObjectType.self)

        for descriptor in descriptors {
            results = results.sorted(byKeyPath: descriptor.keyPath, ascending: descriptor.ascending)
        }

        var mapped: [Model] = []
        mapped.reserveCapacity(results.count)

        for object in results {
            do {
                mapped.append(try object.makeDomainModel())
            } catch {
                throw RealmDatabaseError.conversionFailed(
                    typeName: String(describing: ObjectType.self),
                    reason: error.localizedDescription
                )
            }
        }

        return mapped
    }

    public func fetch<PrimaryKey: Sendable>(primaryKey: PrimaryKey) async throws -> Model? {
        let realm = try openRealm()
        guard hasPrimaryKey(in: realm) else {
            throw RealmDatabaseError.primaryKeyNotDefined(typeName: String(describing: ObjectType.self))
        }
        guard let object = realm.object(ofType: ObjectType.self, forPrimaryKey: primaryKey) else {
            return nil
        }

        do {
            return try object.makeDomainModel()
        } catch {
            throw RealmDatabaseError.conversionFailed(
                typeName: String(describing: ObjectType.self),
                reason: error.localizedDescription
            )
        }
    }

    public func delete<PrimaryKey: Sendable>(primaryKey: PrimaryKey) async throws {
        let realm = try openRealm()
        guard hasPrimaryKey(in: realm) else {
            throw RealmDatabaseError.primaryKeyNotDefined(typeName: String(describing: ObjectType.self))
        }
        guard let object = realm.object(ofType: ObjectType.self, forPrimaryKey: primaryKey) else {
            return
        }

        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            throw RealmDatabaseError.writeFailed(reason: error.localizedDescription)
        }
    }

    public func deleteAll() async throws {
        let realm = try openRealm()

        do {
            try realm.write {
                realm.delete(realm.objects(ObjectType.self))
            }
        } catch {
            throw RealmDatabaseError.writeFailed(reason: error.localizedDescription)
        }
    }
}

private extension RealmObjectRepository {
    func openRealm() throws -> Realm {
        let realmConfiguration = configuration.makeRealmConfiguration()

        do {
            return try Realm(configuration: realmConfiguration)
        } catch {
            throw RealmDatabaseError.openRealmFailed(reason: error.localizedDescription)
        }
    }

    func hasPrimaryKey(in realm: Realm) -> Bool {
        let className = ObjectType.className()
        return realm.schema[className]?.primaryKeyProperty != nil
    }
}

private extension RealmWritePolicy {
    func toRealmUpdatePolicy() -> Realm.UpdatePolicy {
        switch self {
        case .error:
            return .error
        case .modified:
            return .modified
        case .all:
            return .all
        }
    }
}
