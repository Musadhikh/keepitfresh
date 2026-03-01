//
//  ProductPendingSyncTrigger.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Throttled lifecycle trigger that replays pending ProductModule sync when app is active.
//

import Foundation
import ProductModule

actor ProductPendingSyncTrigger {
    private let service: any ProductModuleServicing
    private var lastAttemptAt: Date?
    private var isSyncing = false
    private let minimumAttemptInterval: TimeInterval = 60

    init(service: any ProductModuleServicing) {
        self.service = service
    }

    func triggerIfNeeded(appState: AppState.State, isSceneActive: Bool, limit: Int?) async {
        guard appState == .main, isSceneActive else {
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
            _ = try await service.syncPending(limit: limit)
        } catch {
            // No-op: sync is best-effort and retried on future lifecycle triggers.
        }
    }
}
