//
//  CreateHouseholdRequest.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines inputs required to create a new household.
//

import Foundation

public struct CreateHouseholdRequest: Sendable, Codable, Equatable {
    public let name: String
    public let description: String?
    public let ownerId: String
    public let memberIds: [String]
    
    public init(
        name: String,
        description: String?,
        ownerId: String,
        memberIds: [String]
    ) {
        self.name = name
        self.description = description
        self.ownerId = ownerId
        self.memberIds = memberIds
    }
}
