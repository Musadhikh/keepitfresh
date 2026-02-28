//
//  StorageLocation.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Represents a household-scoped inventory storage location.
//

import Foundation

public struct StorageLocation: Sendable, Codable, Equatable, Hashable {
    public var id: String
    public var householdId: String
    public var name: String
    public var isColdStorage: Bool
    public var createdAt: Date
    public var updatedAt: Date

    public init(
        id: String,
        householdId: String,
        name: String,
        isColdStorage: Bool,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.householdId = householdId
        self.name = name
        self.isColdStorage = isColdStorage
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

