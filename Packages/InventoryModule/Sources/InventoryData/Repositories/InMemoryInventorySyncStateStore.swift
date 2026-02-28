//
//  InMemoryInventorySyncStateStore.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Provides an actor-backed in-memory sync metadata store for inventory workflows.
//

import Foundation
import InventoryDomain

public actor InMemoryInventorySyncStateStore: InventorySyncStateStore {
    private var byCompositeKey: [String: InventorySyncMetadata] = [:]
    private var requestKeyToComposite: [String: String] = [:]

    public init(seed: [InventorySyncMetadata] = []) {
        for metadata in seed {
            let composite = Self.compositeKey(
                itemId: metadata.itemId,
                householdId: metadata.householdId,
                operation: metadata.operation
            )
            byCompositeKey[composite] = metadata
            if let requestID = metadata.idempotencyRequestId {
                requestKeyToComposite[Self.requestKey(requestID: requestID, householdId: metadata.householdId, operation: metadata.operation)] = composite
            }
        }
    }

    public func upsertMetadata(_ metadata: [InventorySyncMetadata]) async throws {
        for item in metadata {
            let composite = Self.compositeKey(itemId: item.itemId, householdId: item.householdId, operation: item.operation)
            byCompositeKey[composite] = item
            if let requestID = item.idempotencyRequestId {
                requestKeyToComposite[Self.requestKey(requestID: requestID, householdId: item.householdId, operation: item.operation)] = composite
            }
        }
    }

    public func metadata(
        for itemId: String,
        householdId: String,
        operation: InventorySyncOperation
    ) async throws -> InventorySyncMetadata? {
        byCompositeKey[Self.compositeKey(itemId: itemId, householdId: householdId, operation: operation)]
    }

    public func metadata(
        forRequestId requestId: String,
        householdId: String,
        operation: InventorySyncOperation
    ) async throws -> InventorySyncMetadata? {
        guard let composite = requestKeyToComposite[Self.requestKey(requestID: requestId, householdId: householdId, operation: operation)] else {
            return nil
        }
        return byCompositeKey[composite]
    }
}

private extension InMemoryInventorySyncStateStore {
    static func compositeKey(itemId: String, householdId: String, operation: InventorySyncOperation) -> String {
        "\(householdId)|\(operation.rawValue)|\(itemId)"
    }

    static func requestKey(requestID: String, householdId: String, operation: InventorySyncOperation) -> String {
        "\(householdId)|\(operation.rawValue)|\(requestID)"
    }
}
