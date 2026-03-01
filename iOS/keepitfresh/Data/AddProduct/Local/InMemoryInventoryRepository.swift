//
//  InMemoryInventoryRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: In-memory inventory repository used as default local-first implementation.
//

import Foundation

actor InMemoryInventoryRepository: InventoryRepository {
    private var localItemsByID: [String: InventoryItem]
    private var remoteItemsByID: [String: InventoryItem]
    private let syncQueue: LocalSyncQueue
    private var remoteAvailable: Bool

    init(
        localItems: [InventoryItem] = [],
        remoteItems: [InventoryItem] = [],
        syncQueue: LocalSyncQueue = LocalSyncQueue(),
        remoteAvailable: Bool = false
    ) {
        self.localItemsByID = Dictionary(uniqueKeysWithValues: localItems.map { ($0.id, $0) })
        self.remoteItemsByID = Dictionary(uniqueKeysWithValues: remoteItems.map { ($0.id, $0) })
        self.syncQueue = syncQueue
        self.remoteAvailable = remoteAvailable
    }

    func findLocal(householdId: String, barcode: Barcode) async throws -> InventoryItem? {
        localItemsByID.values.first {
            $0.householdId == householdId && $0.barcode?.value == barcode.value
        }
    }

    func findRemote(householdId: String, barcode: Barcode) async throws -> InventoryItem? {
        guard remoteAvailable else { return nil }
        return remoteItemsByID.values.first {
            $0.householdId == householdId && $0.barcode?.value == barcode.value
        }
    }

    func fetchAllLocal(householdId: String?) async throws -> [InventoryItem] {
        let all = Array(localItemsByID.values)
        guard let householdId else {
            return all
        }
        return all.filter { $0.householdId == householdId }
    }

    func upsertLocal(_ item: InventoryItem) async throws {
        localItemsByID[item.id] = item
    }

    func upsertRemote(_ item: InventoryItem) async throws {
        guard remoteAvailable else {
            throw InventoryRepositoryError.remoteUnavailable
        }
        remoteItemsByID[item.id] = item
    }

    func enqueueSync(_ operation: InventorySyncOperation) async {
        await syncQueue.enqueue(operation)
    }

    // MARK: Debug/Test helpers

    func setRemoteAvailable(_ isAvailable: Bool) {
        remoteAvailable = isAvailable
    }

    func seedRemote(_ item: InventoryItem) {
        remoteItemsByID[item.id] = item
    }

    func localItem(id: String) -> InventoryItem? {
        localItemsByID[id]
    }

    func queuedSyncCount() async -> Int {
        await syncQueue.pendingCount()
    }
}
