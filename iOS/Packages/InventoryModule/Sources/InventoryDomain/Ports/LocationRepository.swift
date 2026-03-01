//
//  LocationRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares storage-location persistence operations used in inventory workflows.
//

import Foundation

public protocol LocationRepository: Sendable {
    func fetchAll(householdId: String) async throws -> [StorageLocation]
    func findById(_ id: String, householdId: String) async throws -> StorageLocation?
    func upsert(_ location: StorageLocation) async throws
}

