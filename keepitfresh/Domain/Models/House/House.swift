//
//  House.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

struct House: Codable, Equatable, Identifiable, Sendable {
    /// Unique household ID (from backend)
    public let id: String
    
    /// Display name (e.g., "My Home", "Office")
    let name: String
    
    /// Optional description or location note
    let description: String?
    
    /// List of member user IDs (not full user models)
    let memberIds: [String]
    
    /// ID of the user who created the household
    let ownerId: String
    
    /// Creation and update timestamps
    let createdAt: Date
    let updatedAt: Date?
}

extension House {
    
    /// Convenience check: whether current user is the owner
    func isOwned(by userId: String) -> Bool {
        userId == ownerId
    }
    
    /// Whether a user is part of this household
    func isMember(_ userId: String) -> Bool {
        memberIds.contains(userId)
    }
}
