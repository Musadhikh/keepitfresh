// TestSupport/Fixtures.swift
// Target: keepitfreshTests

import Foundation
@testable import keepitfresh

enum Fixtures {
    static let metadataOK = AppMetadata(
        message: "Welcome",
        minimumVersion: "1.0.0",
        appStoreUrl: "https://example.com/app",
        isUnderMaintenance: false
    )
    
    static let metadataMaintenance = AppMetadata(
        message: "Maintenance",
        minimumVersion: "1.0.0",
        appStoreUrl: "https://example.com/app",
        isUnderMaintenance: true
    )
    
    static let user = keepitfresh.User(
        id: "user-1",
        name: "Test User",
        email: "test@example.com",
        profileImageURL: nil,
        lastLoggedIn: Date()
    )
    
    static func profile(households: [String], lastSelected: String?) -> Profile {
        Profile(
            id: "profile-1",
            userId: user.id,
            name: "Test User",
            email: user.email,
            avatarURL: nil,
            householdIds: households,
            lastSelectedHouseholdId: lastSelected,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}
