//
//  LoadHouseholdsForCurrentUserUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Loads profile-scoped households through HouseModule so presentation layers avoid direct provider calls.
//

import Foundation
import Factory
import HouseModule

struct LoadHouseholdsForCurrentUserUseCase: Sendable {
    struct Output: Sendable {
        let profile: Profile
        let houses: [House]
    }
    
    @Injected(\.userProvider) private var userProvider: UserProviding
    @Injected(\.profileProvider) private var profileProvider: ProfileProviding
    @Injected(\.houseDomainModule) private var houseDomainModule: HouseModule
    
    func execute() async throws -> Output {
        guard let user = try await userProvider.current() else {
            throw LoadHouseholdsForCurrentUserUseCaseError.missingAuthenticatedUser
        }
        guard let profile = try await profileProvider.getProfile(for: user.id) else {
            throw LoadHouseholdsForCurrentUserUseCaseError.missingProfile
        }
        
        let households = try await houseDomainModule.loadHouseholds.execute(
            ids: profile.householdIds,
            policy: .remoteFirst
        )
        let houses = households.map(House.init(moduleHousehold:))
        
        return Output(profile: profile, houses: houses)
    }
}

private enum LoadHouseholdsForCurrentUserUseCaseError: LocalizedError {
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
