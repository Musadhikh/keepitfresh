//
//  FirestoreInventoryRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Firestore-backed inventory repository stub kept optional and swappable.
//

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif
import Foundation

actor FirestoreInventoryRepository: InventoryRepository {
    func findLocal(householdId: String, barcode: Barcode) async throws -> InventoryItem? {
        nil
    }

    func findRemote(householdId: String, barcode: Barcode) async throws -> InventoryItem? {
        nil
    }

    func fetchAllLocal(householdId: String?) async throws -> [InventoryItem] {
        []
    }

    func upsertLocal(_ item: InventoryItem) async throws {
        // no-op: local persistence is handled by a local repository implementation.
    }

    func upsertRemote(_ item: InventoryItem) async throws {
        throw InventoryRepositoryError.remoteUnavailable
    }

    func enqueueSync(_ operation: InventorySyncOperation) async {
        // no-op for stub
    }
}
