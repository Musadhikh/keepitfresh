//
//  InventorySyncRetryPolicy.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Defines retry/backoff strategy abstractions for inventory sync replay.
//

import Foundation
import InventoryDomain

public protocol InventorySyncRetryPolicy: Sendable {
    func shouldAttempt(_ metadata: InventorySyncMetadata, now: Date) -> Bool
}

public struct DefaultInventorySyncRetryPolicy: InventorySyncRetryPolicy {
    public var baseDelay: TimeInterval
    public var maxDelay: TimeInterval
    public var maxRetryCount: Int

    public init(
        baseDelay: TimeInterval = 2,
        maxDelay: TimeInterval = 60,
        maxRetryCount: Int = 8
    ) {
        self.baseDelay = baseDelay
        self.maxDelay = maxDelay
        self.maxRetryCount = maxRetryCount
    }

    public func shouldAttempt(_ metadata: InventorySyncMetadata, now: Date) -> Bool {
        switch metadata.state {
        case .pending:
            return true

        case .synced:
            return false

        case .failed:
            guard metadata.retryCount < maxRetryCount else {
                return false
            }
            guard let lastAttemptAt = metadata.lastAttemptAt else {
                return true
            }
            let delay = min(maxDelay, baseDelay * pow(2, Double(max(0, metadata.retryCount - 1))))
            let jitter = delay * deterministicJitterFactor(metadata: metadata)
            let earliestRetryAt = lastAttemptAt.addingTimeInterval(delay + jitter)
            return now >= earliestRetryAt
        }
    }

    // Small deterministic jitter (0...10%) to avoid thundering herd without introducing randomness in tests.
    private func deterministicJitterFactor(metadata: InventorySyncMetadata) -> TimeInterval {
        let seed = "\(metadata.householdId)|\(metadata.itemId)|\(metadata.operation.rawValue)|\(metadata.retryCount)"
        let bucket = seed.unicodeScalars.reduce(0) { partial, scalar in
            (partial + Int(scalar.value)) % 11
        }
        return TimeInterval(bucket) / 100
    }
}
