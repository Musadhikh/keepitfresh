//
//  ProfileSyncRecord.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Stores profile data and merge metadata used by offline-first bidirectional sync.
//

import Foundation

struct ProfileSyncRecord: Sendable, Codable, Equatable {
    let profile: Profile
    let lastSyncedRemoteProfile: Profile?
    let state: ProfileSyncState
    let lastError: String?
    let updatedAt: Date
}
