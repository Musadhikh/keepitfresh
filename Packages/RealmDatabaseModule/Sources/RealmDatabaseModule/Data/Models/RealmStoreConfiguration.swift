//
//  RealmStoreConfiguration.swift
//  RealmDatabaseModule
//
//  Created by musadhikh on 22/2/26.
//  Summary: Sendable Realm configuration model independent from Realm runtime types.
//

import Foundation
import RealmSwift

public struct RealmStoreConfiguration: Sendable, Equatable {
    public var schemaVersion: UInt64
    public var inMemoryIdentifier: String?
    public var fileURL: URL?
    public var deleteRealmIfMigrationNeeded: Bool
    public var isReadOnly: Bool

    public init(
        schemaVersion: UInt64 = 1,
        inMemoryIdentifier: String? = nil,
        fileURL: URL? = nil,
        deleteRealmIfMigrationNeeded: Bool = false,
        isReadOnly: Bool = false
    ) {
        self.schemaVersion = schemaVersion
        self.inMemoryIdentifier = inMemoryIdentifier
        self.fileURL = fileURL
        self.deleteRealmIfMigrationNeeded = deleteRealmIfMigrationNeeded
        self.isReadOnly = isReadOnly
    }

    public static let `default` = RealmStoreConfiguration()
}

extension RealmStoreConfiguration {
    func makeRealmConfiguration() -> Realm.Configuration {
        var configuration = Realm.Configuration(schemaVersion: schemaVersion)
        if let inMemoryIdentifier {
            configuration.inMemoryIdentifier = inMemoryIdentifier
        }
        if let fileURL {
            configuration.fileURL = fileURL
        }
        configuration.deleteRealmIfMigrationNeeded = deleteRealmIfMigrationNeeded
        configuration.readOnly = isReadOnly
        return configuration
    }
}
