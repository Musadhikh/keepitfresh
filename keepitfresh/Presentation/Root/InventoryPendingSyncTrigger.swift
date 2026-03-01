//
//  InventoryPendingSyncTrigger.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Throttled lifecycle trigger that replays pending household InventoryModule sync when app is active.
//

import Foundation
import InventoryModule

actor InventoryPendingSyncTrigger {
    private let service: any InventoryModuleTypes.InventoryModuleServicing
    private var lastAttemptAt: Date?
    private var isSyncing = false
    private let minimumAttemptInterval: TimeInterval = 60

    init(service: any InventoryModuleTypes.InventoryModuleServicing) {
        self.service = service
    }

    func triggerIfNeeded(
        appState: AppState.State,
        isSceneActive: Bool,
        householdId: String?,
        limit: Int?
    ) async {
        guard appState == .main, isSceneActive else {
            return
        }
        guard let householdId, householdId.trimmingCharacters(in: .whitespacesAndNewlines).isNotEmpty else {
            return
        }
        guard isSyncing == false else {
            return
        }

        let now = Date()
        if let lastAttemptAt, now.timeIntervalSince(lastAttemptAt) < minimumAttemptInterval {
            return
        }

        isSyncing = true
        lastAttemptAt = now
        defer { isSyncing = false }

        do {
            _ = try await service.syncPendingInventory(
                InventoryModuleTypes.SyncPendingInventoryInput(
                    householdId: householdId,
                    limit: limit
                )
            )
        } catch {
            // No-op: sync is best-effort and retried on future lifecycle triggers.
        }
    }
}
