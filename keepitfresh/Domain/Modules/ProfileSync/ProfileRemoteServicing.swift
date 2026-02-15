//
//  ProfileRemoteServicing.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines remote profile update behavior used by profile synchronization workflows.
//

import Foundation

protocol ProfileRemoteServicing: Sendable {
    func updateProfile(_ profile: Profile) async throws -> Profile
}
