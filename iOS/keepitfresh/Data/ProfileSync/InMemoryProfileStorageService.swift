//
//  InMemoryProfileStorageService.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Provides a mock in-memory profile database used for sync-state tracking.
//

import Foundation

actor InMemoryProfileStorageService: ProfileStorageServicing {
    private var recordsByUserID: [String: ProfileSyncRecord] = [:]
    
    func record(for userId: String) async throws -> ProfileSyncRecord? {
        recordsByUserID[userId]
    }
    
    func upsert(record: ProfileSyncRecord) async throws {
        recordsByUserID[record.profile.userId] = record
    }
}
