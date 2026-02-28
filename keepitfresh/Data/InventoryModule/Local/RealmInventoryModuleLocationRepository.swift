//
//  RealmInventoryModuleLocationRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Realm-backed storage location repository adapter for InventoryModule.
//

import Foundation
import InventoryModule
import RealmDatabaseModule

typealias IMLocation = InventoryModuleTypes.StorageLocation

private enum InventoryModuleLocationRealmNamespace {
    static let locations = "inventory_module_locations"
}

actor RealmInventoryModuleLocationRepository: InventoryModuleTypes.LocationRepository {
    private let repository: RealmCodableRepository<IMLocation>

    init(configuration: RealmStoreConfiguration) {
        self.repository = RealmCodableRepository(
            namespace: InventoryModuleLocationRealmNamespace.locations,
            configuration: configuration,
            keyForModel: { $0.id }
        )
    }

    func fetchAll(householdId: String) async throws -> [IMLocation] {
        try await repository.fetchAll().filter { $0.householdId == householdId }
    }

    func findById(_ id: String, householdId: String) async throws -> IMLocation? {
        guard let location = try await repository.fetch(primaryKey: id), location.householdId == householdId else {
            return nil
        }
        return location
    }

    func upsert(_ location: IMLocation) async throws {
        try await repository.upsert(location)
    }
}
