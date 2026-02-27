//
//  RealmCodableRepository.swift
//  RealmDatabaseModule
//
//  Created by musadhikh on 22/2/26.
//  Summary: Actor-isolated repository storing Codable domain models without exposing Realm object types.
//

import Foundation
import RealmSwift

public actor RealmCodableRepository<Model: Codable & Sendable>: CodableRealmRepository {
    private let configuration: RealmStoreConfiguration
    private let namespace: String
    private let keyForModel: @Sendable (Model) -> String
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        namespace: String,
        configuration: RealmStoreConfiguration = .default,
        keyForModel: @escaping @Sendable (Model) -> String,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.namespace = namespace
        self.configuration = configuration
        self.keyForModel = keyForModel
        self.encoder = encoder
        self.decoder = decoder
    }

    public func upsert(_ model: Model) async throws {
        let realm = try openRealm()
        let key = keyForModel(model)

        let payload: Data
        do {
            payload = try encoder.encode(model)
        } catch {
            throw RealmDatabaseError.conversionFailed(
                typeName: String(describing: Model.self),
                reason: error.localizedDescription
            )
        }

        let object = RealmCodableEnvelopeObject()
        object.id = objectID(for: key)
        object.namespace = namespace
        object.recordKey = key
        object.payload = payload
        object.updatedAt = Date()

        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            throw RealmDatabaseError.writeFailed(reason: error.localizedDescription)
        }
    }

    public func fetch(primaryKey: String) async throws -> Model? {
        let realm = try openRealm()

        guard let object = realm.object(
            ofType: RealmCodableEnvelopeObject.self,
            forPrimaryKey: objectID(for: primaryKey)
        ) else {
            return nil
        }

        do {
            return try decoder.decode(Model.self, from: object.payload)
        } catch {
            throw RealmDatabaseError.conversionFailed(
                typeName: String(describing: Model.self),
                reason: error.localizedDescription
            )
        }
    }

    public func fetchAll() async throws -> [Model] {
        let realm = try openRealm()
        let objects = realm.objects(RealmCodableEnvelopeObject.self)
            .where { $0.namespace == namespace }

        var models: [Model] = []
        models.reserveCapacity(objects.count)

        for object in objects {
            do {
                let model = try decoder.decode(Model.self, from: object.payload)
                models.append(model)
            } catch {
                throw RealmDatabaseError.conversionFailed(
                    typeName: String(describing: Model.self),
                    reason: error.localizedDescription
                )
            }
        }

        return models
    }

    public func delete(primaryKey: String) async throws {
        let realm = try openRealm()

        guard let object = realm.object(
            ofType: RealmCodableEnvelopeObject.self,
            forPrimaryKey: objectID(for: primaryKey)
        ) else {
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
        let objects = realm.objects(RealmCodableEnvelopeObject.self)
            .where { $0.namespace == namespace }

        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            throw RealmDatabaseError.writeFailed(reason: error.localizedDescription)
        }
    }
}

private extension RealmCodableRepository {
    func openRealm() throws -> Realm {
        do {
            return try Realm(configuration: configuration.makeRealmConfiguration())
        } catch {
            throw RealmDatabaseError.openRealmFailed(reason: error.localizedDescription)
        }
    }

    func objectID(for key: String) -> String {
        "\(namespace)::\(key)"
    }
}

@objc(RealmCodableEnvelopeObject)
final class RealmCodableEnvelopeObject: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var namespace: String = ""
    @Persisted var recordKey: String = ""
    @Persisted var payload: Data = Data()
    @Persisted var updatedAt: Date = .distantPast
}
