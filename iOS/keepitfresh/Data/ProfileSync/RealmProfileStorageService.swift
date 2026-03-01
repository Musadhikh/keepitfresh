//
//  RealmProfileStorageService.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Persists profile sync records via package-level RealmCodableRepository without app-level Realm types.
//

import Foundation
import RealmDatabaseModule

struct RealmNameSpace {
    static let profileSyncRecords = "profile_sync_records"
}

actor RealmProfileStorageService: ProfileStorageServicing {
    private let repository: RealmCodableRepository<ProfileSyncRecord>

    init(configuration: RealmStoreConfiguration = .default) {
        self.repository = RealmCodableRepository(
            namespace: RealmNameSpace.profileSyncRecords,
            configuration: configuration,
            keyForModel: { $0.profile.userId }
        )
    }

    func record(for userId: String) async throws -> ProfileSyncRecord? {
        try await repository.fetch(primaryKey: userId)
    }

    func upsert(record: ProfileSyncRecord) async throws {
        try await repository.upsert(record)
    }
}
