//
//  UserProfile.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

struct UserProfile: Codable, Equatable, Identifiable, Sendable {
    let id: String
    /// Unique user identifier
    let userId: String
    /// Display name
    let name: String
    
    /// Email address
    let email: String?
    
    /// Optional avatar URL
    let avatarURL: String?
    
    /// All household IDs the user belongs to
    let householdIds: [String]
    
    /// Last selected household ID (used to restore app context)
    let lastSelectedHouseholdId: String?
    
    /// Whether user account is active
    let isActive: Bool
    
    /// Timestamps
    let createdAt: Date?
    let updatedAt: Date?
}
