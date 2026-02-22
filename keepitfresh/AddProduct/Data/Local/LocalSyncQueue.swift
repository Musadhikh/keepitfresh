//
//  LocalSyncQueue.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: In-memory sync queue for deferred remote inventory operations.
//

import Foundation

actor LocalSyncQueue {
    private var operations: [InventorySyncOperation] = []

    func enqueue(_ operation: InventorySyncOperation) {
        operations.append(operation)
    }

    func dequeueAll() -> [InventorySyncOperation] {
        let result = operations
        operations.removeAll()
        return result
    }

    func pendingOperations() -> [InventorySyncOperation] {
        operations
    }

    func pendingCount() -> Int {
        operations.count
    }
}
