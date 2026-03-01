//
//  ProfileRemoteServicing.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines remote profile operations required by profile synchronization workflows.
//

import Foundation

protocol ProfileRemoteServicing: Sendable {
    func fetchProfile(for userId: String) async throws -> Profile?
    func createProfile(_ profile: Profile) async throws -> Profile
    func updateProfile(_ profile: Profile) async throws -> Profile
}
