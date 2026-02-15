//
//  ProfileStorageServicing.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines local profile storage operations required for sync-aware profile updates.
//

import Foundation

protocol ProfileStorageServicing: Sendable {
    func record(for userId: String) async throws -> ProfileSyncRecord?
    func upsert(record: ProfileSyncRecord) async throws
}
