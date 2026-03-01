//
//  UserProfile.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed K on 25/10/25.
//

import Foundation

enum ProfileAppearancePreference: String, Codable, CaseIterable, Equatable, Sendable {
    case system
    case light
    case dark
}

struct Profile: Codable, Equatable, Identifiable, Sendable {
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

    /// Preferred app appearance for this user profile.
    let appearancePreference: ProfileAppearancePreference
    
    /// Timestamps
    let createdAt: Date?
    let updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case name
        case email
        case avatarURL
        case householdIds
        case lastSelectedHouseholdId
        case isActive
        case appearancePreference
        case createdAt
        case updatedAt
    }

    init(
        id: String,
        userId: String,
        name: String,
        email: String?,
        avatarURL: String?,
        householdIds: [String],
        lastSelectedHouseholdId: String?,
        isActive: Bool,
        appearancePreference: ProfileAppearancePreference,
        createdAt: Date?,
        updatedAt: Date?
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.email = email
        self.avatarURL = avatarURL
        self.householdIds = householdIds
        self.lastSelectedHouseholdId = lastSelectedHouseholdId
        self.isActive = isActive
        self.appearancePreference = appearancePreference
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        avatarURL = try container.decodeIfPresent(String.self, forKey: .avatarURL)
        householdIds = try container.decode([String].self, forKey: .householdIds)
        lastSelectedHouseholdId = try container.decodeIfPresent(String.self, forKey: .lastSelectedHouseholdId)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        appearancePreference = try container.decodeIfPresent(ProfileAppearancePreference.self, forKey: .appearancePreference) ?? .system
        createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt)
    }
}
