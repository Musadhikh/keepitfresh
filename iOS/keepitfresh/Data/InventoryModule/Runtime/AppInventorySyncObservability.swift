//
//  AppInventorySyncObservability.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: App-layer observability sink for InventoryModule sync events.
//

import Foundation
import InventoryModule
import os

actor AppInventorySyncObservability: InventoryModuleTypes.InventorySyncObservability {
    private let logger = Logger(subsystem: "com.mus.keepitfresh", category: "InventorySync")
    private var recentEvents: [InventoryModuleTypes.InventorySyncEvent] = []
    private let maxRecentEvents = 50

    func record(_ event: InventoryModuleTypes.InventorySyncEvent) async {
        recentEvents.append(event)
        if recentEvents.count > maxRecentEvents {
            recentEvents.removeFirst(recentEvents.count - maxRecentEvents)
        }
        logger.debug("Inventory sync event: \(String(describing: event), privacy: .public)")
    }

    func snapshotRecentEvents() -> [InventoryModuleTypes.InventorySyncEvent] {
        recentEvents
    }
}
