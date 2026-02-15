//
//  Household.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines household aggregate data used by storage, networking, and business use cases.
//

import Foundation

public struct Household: Sendable, Codable, Equatable, Identifiable {
    public let id: String
    public var name: String
    public var members: [HouseholdMember]
    public var updatedAt: Date
    
    public init(
        id: String,
        name: String,
        members: [HouseholdMember],
        updatedAt: Date
    ) {
        self.id = id
        self.name = name
        self.members = members
        self.updatedAt = updatedAt
    }
}

