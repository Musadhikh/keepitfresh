//
//  ProfileSyncRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Coordinates local and remote profile updates while tracking sync status transitions.
//

import Foundation

actor ProfileSyncRepository {
    private let storageService: any ProfileStorageServicing
    private let remoteService: any ProfileRemoteServicing
    
    init(
        storageService: any ProfileStorageServicing,
        remoteService: any ProfileRemoteServicing
    ) {
        self.storageService = storageService
        self.remoteService = remoteService
    }
    
    func updateProfile(
        _ profile: Profile,
        syncMetadataPreservingExisting existingRecord: ProfileSyncRecord?
    ) async throws -> Profile {
        let pendingRecord = ProfileSyncRecord(
            profile: profile,
            state: .pending,
            lastError: nil,
            updatedAt: Date()
        )
        try await storageService.upsert(record: pendingRecord)
        
        do {
            let remoteProfile = try await remoteService.updateProfile(profile)
            let syncedRecord = ProfileSyncRecord(
                profile: remoteProfile,
                state: .synced,
                lastError: nil,
                updatedAt: Date()
            )
            try await storageService.upsert(record: syncedRecord)
            return remoteProfile
        } catch {
            let failedRecord = ProfileSyncRecord(
                profile: existingRecord?.profile ?? profile,
                state: .failed,
                lastError: error.localizedDescription,
                updatedAt: Date()
            )
            try await storageService.upsert(record: failedRecord)
            throw error
        }
    }
    
    func record(for userId: String) async throws -> ProfileSyncRecord? {
        try await storageService.record(for: userId)
    }
}
