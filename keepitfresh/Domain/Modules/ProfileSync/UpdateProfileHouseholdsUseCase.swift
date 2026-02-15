//
//  UpdateProfileHouseholdsUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Updates profile household membership with local sync-state transitions before and after remote sync.
//

import Foundation

struct UpdateProfileHouseholdsUseCase: Sendable {
    private let repository: ProfileSyncRepository
    
    init(repository: ProfileSyncRepository) {
        self.repository = repository
    }
    
    func execute(
        profile: Profile,
        appendingHouseholdID householdID: String
    ) async throws -> Profile {
        var updatedHouseholdIDs = profile.householdIds
        if !updatedHouseholdIDs.contains(householdID) {
            updatedHouseholdIDs.append(householdID)
        }
        
        let updatedProfile = Profile(
            id: profile.id,
            userId: profile.userId,
            name: profile.name,
            email: profile.email,
            avatarURL: profile.avatarURL,
            householdIds: updatedHouseholdIDs,
            lastSelectedHouseholdId: profile.lastSelectedHouseholdId,
            isActive: profile.isActive,
            createdAt: profile.createdAt,
            updatedAt: Date()
        )
        
        let existingRecord = try await repository.record(for: profile.userId)
        return try await repository.updateProfile(
            updatedProfile,
            syncMetadataPreservingExisting: existingRecord
        )
    }
}
