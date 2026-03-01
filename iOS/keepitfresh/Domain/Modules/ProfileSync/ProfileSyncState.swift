//
//  ProfileSyncState.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Declares synchronization state values used by profile sync workflows.
//

import Foundation

enum ProfileSyncState: String, Codable, Sendable, Equatable {
    case pending
    case synced
    case failed
}
