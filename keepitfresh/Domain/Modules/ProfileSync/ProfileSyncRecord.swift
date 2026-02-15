//
//  ProfileSyncRecord.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Stores profile data with synchronization metadata for local persistence.
//

import Foundation

struct ProfileSyncRecord: Sendable, Codable, Equatable {
    let profile: Profile
    let state: ProfileSyncState
    let lastError: String?
    let updatedAt: Date
}
