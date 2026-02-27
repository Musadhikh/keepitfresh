//
//  RealmInventoryRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Realm-backed local inventory repository with barcode index lookup and sync queue fallback.
//

import Foundation
import RealmDatabaseModule

actor RealmInventoryRepository: InventoryRepository {
    private let inventoryRepository: RealmCodableRepository<InventoryItem>
    private let barcodeIndexRepository: RealmCodableRepository<InventoryBarcodeLookupRecord>
    private let syncQueue: LocalSyncQueue

    private var remoteItemsByID: [String: InventoryItem]
    private var remoteAvailable: Bool

    init(
        configuration: RealmStoreConfiguration = .default,
        syncQueue: LocalSyncQueue = LocalSyncQueue(),
        remoteItems: [InventoryItem] = [],
        remoteAvailable: Bool = false
    ) {
        self.inventoryRepository = RealmCodableRepository(
            namespace: RealmInventoryRepositoryNamespace.items,
            configuration: configuration,
            keyForModel: { $0.id }
        )
        self.barcodeIndexRepository = RealmCodableRepository(
            namespace: RealmInventoryRepositoryNamespace.barcodeIndex,
            configuration: configuration,
            keyForModel: { record in
                RealmInventoryRepository.barcodeLookupKey(
                    householdId: record.householdId,
                    barcodeValue: record.barcodeValue
                )
            }
        )
        self.syncQueue = syncQueue
        self.remoteItemsByID = Dictionary(uniqueKeysWithValues: remoteItems.map { ($0.id, $0) })
        self.remoteAvailable = remoteAvailable
    }

    func findLocal(householdId: String, barcode: Barcode) async throws -> InventoryItem? {
        guard let normalizedBarcode = Self.normalizedBarcodeValue(barcode.value) else {
            return nil
        }

        let lookupKey = Self.barcodeLookupKey(householdId: householdId, barcodeValue: normalizedBarcode)
        if let lookup = try await barcodeIndexRepository.fetch(primaryKey: lookupKey),
           let item = try await inventoryRepository.fetch(primaryKey: lookup.itemID) {
            return item
        }

        let defaultItemID = Self.defaultInventoryItemID(
            householdId: householdId,
            barcodeValue: normalizedBarcode
        )
        if let item = try await inventoryRepository.fetch(primaryKey: defaultItemID) {
            try? await storeLookup(for: item)
            return item
        }

        return nil
    }

    func findRemote(householdId: String, barcode: Barcode) async throws -> InventoryItem? {
        guard remoteAvailable else { return nil }
        guard let normalizedQueryBarcode = Self.normalizedBarcodeValue(barcode.value) else { return nil }

        return remoteItemsByID.values.first { item in
            item.householdId == householdId &&
            Self.normalizedBarcodeValue(item.barcode?.value) == normalizedQueryBarcode
        }
    }

    func fetchAllLocal(householdId: String?) async throws -> [InventoryItem] {
        let items = try await inventoryRepository.fetchAll()
        guard let householdId else {
            return items
        }
        return items.filter { $0.householdId == householdId }
    }

    func upsertLocal(_ item: InventoryItem) async throws {
        try await inventoryRepository.upsert(item)
        try await storeLookup(for: item)
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

    func setRemoteAvailable(_ isAvailable: Bool) {
        remoteAvailable = isAvailable
    }

    func seedRemote(_ item: InventoryItem) {
        remoteItemsByID[item.id] = item
    }
}

private extension RealmInventoryRepository {
    func storeLookup(for item: InventoryItem) async throws {
        guard let normalizedBarcode = Self.normalizedBarcodeValue(item.barcode?.value) else {
            return
        }

        let lookup = InventoryBarcodeLookupRecord(
            householdId: item.householdId,
            barcodeValue: normalizedBarcode,
            itemID: item.id
        )
        try await barcodeIndexRepository.upsert(lookup)
    }

    static func normalizedBarcodeValue(_ value: String?) -> String? {
        guard let value else { return nil }
        let normalized = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return normalized.isEmpty ? nil : normalized
    }

    static func barcodeLookupKey(householdId: String, barcodeValue: String) -> String {
        "\(householdId)::\(barcodeValue)"
    }

    static func defaultInventoryItemID(householdId: String, barcodeValue: String) -> String {
        "\(householdId)_\(barcodeValue)"
    }
}

private enum RealmInventoryRepositoryNamespace {
    static let items = "add_product_inventory_items"
    static let barcodeIndex = "add_product_inventory_barcode_index"
}

private struct InventoryBarcodeLookupRecord: Codable, Sendable {
    let householdId: String
    let barcodeValue: String
    let itemID: String
}
