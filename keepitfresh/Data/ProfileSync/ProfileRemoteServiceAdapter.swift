//
//  ProfileRemoteServiceAdapter.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Adapts the app profile provider to profile module remote service requirements.
//

import Foundation

actor ProfileRemoteServiceAdapter: ProfileRemoteServicing {
    private let profileProvider: any ProfileProviding
    
    init(profileProvider: any ProfileProviding) {
        self.profileProvider = profileProvider
    }
    
    func updateProfile(_ profile: Profile) async throws -> Profile {
        try await profileProvider.update(profile: profile)
        return profile
    }
}
