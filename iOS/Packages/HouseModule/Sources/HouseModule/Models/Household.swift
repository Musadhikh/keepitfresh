//
//  Household.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines the base household model used by storage, networking, and household use cases.
//

import Foundation

public struct Household: Sendable, Codable, Equatable, Identifiable {
    public let id: String
    public var name: String
    public var description: String?
    public var ownerId: String
    public var memberIds: [String]
    public var createdAt: Date
    public var updatedAt: Date
    public var syncState: HouseSyncState
    
    public init(
        id: String,
        name: String,
        description: String?,
        ownerId: String,
        memberIds: [String],
        createdAt: Date,
        updatedAt: Date,
        syncState: HouseSyncState
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.ownerId = ownerId
        self.memberIds = memberIds
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.syncState = syncState
    }
}
