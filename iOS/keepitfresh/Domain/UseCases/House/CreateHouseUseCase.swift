//
//  CreateHouseUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Orchestrates new household creation across house and profile modules with sync-state handling.
//

import Foundation
import Factory
import HouseModule

struct CreateHouseUseCase: Sendable {
    struct Input: Sendable {
        let name: String
        let address: String
        let note: String
    }
    
    struct Output: Sendable {
        let profile: Profile
        let house: House
    }
    
    @Injected(\.userProvider) private var userProvider: UserProviding
    @Injected(\.profileSyncRepository) private var profileSyncRepository: ProfileSyncRepository
    @Injected(\.houseDomainModule) private var houseDomainModule: HouseModule
    @Injected(\.updateProfileHouseholdsUseCase) private var updateProfileHouseholdsUseCase: UpdateProfileHouseholdsUseCase
    
    func execute(input: Input) async throws -> Output {
        guard let user = try await userProvider.current() else {
            throw CreateHouseUseCaseError.missingAuthenticatedUser
        }
        guard let profile = try await profileSyncRepository.currentProfile(for: user.id) else {
            throw CreateHouseUseCaseError.missingProfile
        }
        
        let mergedDescription = mergeDescription(
            address: input.address,
            note: input.note
        )
        let createdHousehold = try await houseDomainModule.createHousehold.execute(
            request: CreateHouseholdRequest(
                name: input.name,
                description: mergedDescription,
                ownerId: user.id,
                memberIds: [user.id]
            )
        )
        
        let updatedProfile = try await updateProfileHouseholdsUseCase.execute(
            profile: profile,
            appendingHouseholdID: createdHousehold.id
        )
        
        return Output(
            profile: updatedProfile,
            house: House(moduleHousehold: createdHousehold)
        )
    }
    
    private func mergeDescription(address: String, note: String) -> String? {
        let normalizedAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedNote = note.trimmingCharacters(in: .whitespacesAndNewlines)
        let parts = [normalizedAddress, normalizedNote].filter { !$0.isEmpty }
        if parts.isEmpty {
            return nil
        }
        return parts.joined(separator: "\n")
    }
}

private enum CreateHouseUseCaseError: LocalizedError {
    case missingAuthenticatedUser
    case missingProfile
    
    var errorDescription: String? {
        switch self {
        case .missingAuthenticatedUser:
            return "No authenticated user found."
        case .missingProfile:
            return "Unable to load your profile."
        }
    }
}
