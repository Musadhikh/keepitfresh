//
//  SelectHouseUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Loads the latest selected house and persists it as the active household on the profile.
//

import Foundation
import Factory
import HouseModule

struct SelectHouseUseCase: Sendable {
    struct Output: Sendable {
        let profile: Profile
        let house: House
    }
    
    @Injected(\.userProvider) private var userProvider: UserProviding
    @Injected(\.profileSyncRepository) private var profileSyncRepository: ProfileSyncRepository
    @Injected(\.houseDomainModule) private var houseDomainModule: HouseModule
    
    func execute(houseID: String) async throws -> Output {
        guard let user = try await userProvider.current() else {
            throw SelectHouseUseCaseError.missingAuthenticatedUser
        }
        guard let profile = try await profileSyncRepository.currentProfile(for: user.id) else {
            throw SelectHouseUseCaseError.missingProfile
        }
        
        guard let selectedHousehold = try await houseDomainModule.loadHouseholds.execute(
            id: houseID,
            policy: .localFirst
        ) else {
            throw SelectHouseUseCaseError.houseNotFound
        }
        
        let updatedProfile = try await profileSyncRepository.setLocalSelectedHousehold(
            for: user.id,
            houseId: selectedHousehold.id
        ) ?? profile.withLocalSelectedHouseholdId(selectedHousehold.id)
        
        return Output(
            profile: updatedProfile,
            house: House(moduleHousehold: selectedHousehold)
        )
    }
}

private enum SelectHouseUseCaseError: LocalizedError {
    case missingAuthenticatedUser
    case missingProfile
    case houseNotFound
    
    var errorDescription: String? {
        switch self {
        case .missingAuthenticatedUser:
            return "No authenticated user found."
        case .missingProfile:
            return "Unable to load your profile."
        case .houseNotFound:
            return "Unable to find the selected house."
        }
    }
}
