//
//  ProductSync.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines sync states and metadata tracked per product for offline-first behavior.
//

import Foundation

public enum ProductSyncState: Sendable, Codable, Equatable {
    case pendingUpsert
    case synced
    case failed(retryCount: Int, lastError: String?, nextRetryAt: Date?)
    case pendingDelete
}

public struct ProductSyncMetadata: Sendable, Codable, Equatable {
    public var productId: String
    public var state: ProductSyncState
    public var lastAttemptAt: Date?
    public var lastSyncedAt: Date?
    public var retryCount: Int
    public var lastError: String?
    public var remoteVersion: String?

    public init(
        productId: String,
        state: ProductSyncState,
        lastAttemptAt: Date? = nil,
        lastSyncedAt: Date? = nil,
        retryCount: Int = 0,
        lastError: String? = nil,
        remoteVersion: String? = nil
    ) {
        self.productId = productId
        self.state = state
        self.lastAttemptAt = lastAttemptAt
        self.lastSyncedAt = lastSyncedAt
        self.retryCount = retryCount
        self.lastError = lastError
        self.remoteVersion = remoteVersion
    }
}
