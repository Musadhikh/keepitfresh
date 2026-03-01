//
//  HouseholdMember.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines household member information associated with a household.
//

import Foundation

public struct HouseholdMember: Sendable, Codable, Equatable, Identifiable {
    public let id: String
    public var name: String
    public var email: String?
    
    public init(
        id: String,
        name: String,
        email: String?
    ) {
        self.id = id
        self.name = name
        self.email = email
    }
}

