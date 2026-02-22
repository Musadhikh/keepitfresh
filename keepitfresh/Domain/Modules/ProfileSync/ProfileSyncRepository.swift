//
//  ProfileSyncRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Offline-first profile source-of-truth that merges local and remote changes with conflict handling.
//

import Foundation

actor ProfileSyncRepository {
    private let storageService: any ProfileStorageServicing
    private let remoteService: any ProfileRemoteServicing
    private var observers: [String: [UUID: AsyncStream<ProfileSyncRecord?>.Continuation]] = [:]
    
    init(
        storageService: any ProfileStorageServicing,
        remoteService: any ProfileRemoteServicing
    ) {
        self.storageService = storageService
        self.remoteService = remoteService
    }
    
    func record(for userId: String) async throws -> ProfileSyncRecord? {
        try await storageService.record(for: userId)
    }

    func observeRecord(for userId: String) -> AsyncStream<ProfileSyncRecord?> {
        AsyncStream { continuation in
            let id = UUID()
            if observers[userId] == nil {
                observers[userId] = [:]
            }
            observers[userId]?[id] = continuation

            Task { [weak self] in
                guard let self else { return }
                let snapshot = try? await self.storageService.record(for: userId)
                await self.emit(snapshot ?? nil, for: userId, onlyTo: id)
            }

            continuation.onTermination = { [weak self] _ in
                Task {
                    await self?.removeObserver(userId: userId, id: id)
                }
            }
        }
    }

    func currentProfile(for userId: String) async throws -> Profile? {
        if let local = try await storageService.record(for: userId) {
            return local.profile
        }
        if let remote = try await remoteService.fetchProfile(for: userId) {
            let record = syncedRecord(fromRemote: remote, localSelectedHouseholdId: nil)
            try await storageService.upsert(record: record)
            await emit(record, for: userId)
            return record.profile
        }
        return nil
    }

    func ensureProfile(for user: User) async throws -> Profile {
        if let existing = try await currentProfile(for: user.id) {
            return existing
        }

        let created = Profile(
            id: user.id,
            userId: user.id,
            name: user.name,
            email: user.email,
            avatarURL: user.profileImageURL,
            householdIds: [],
            lastSelectedHouseholdId: nil,
            isActive: true,
            createdAt: Date(),
            updatedAt: Date()
        )

        let remoteCreated = try await remoteService.createProfile(created.remoteNormalized())
        let record = syncedRecord(fromRemote: remoteCreated, localSelectedHouseholdId: nil)
        try await storageService.upsert(record: record)
        await emit(record, for: user.id)
        return record.profile
    }

    func stageSharedProfileUpdate(_ profile: Profile) async throws {
        let existing = try await storageService.record(for: profile.userId)
        let selected = profile.lastSelectedHouseholdId ?? existing?.profile.lastSelectedHouseholdId

        let pending = ProfileSyncRecord(
            profile: profile.withLocalSelectedHouseholdId(selected),
            lastSyncedRemoteProfile: existing?.lastSyncedRemoteProfile,
            state: .pending,
            lastError: nil,
            updatedAt: Date()
        )
        try await storageService.upsert(record: pending)
        await emit(pending, for: profile.userId)
    }

    func setLocalSelectedHousehold(for userId: String, houseId: String?) async throws -> Profile? {
        guard let existing = try await storageService.record(for: userId) else {
            return nil
        }

        let updated = ProfileSyncRecord(
            profile: existing.profile.withLocalSelectedHouseholdId(houseId),
            lastSyncedRemoteProfile: existing.lastSyncedRemoteProfile,
            state: existing.state,
            lastError: existing.lastError,
            updatedAt: Date()
        )
        try await storageService.upsert(record: updated)
        await emit(updated, for: userId)
        return updated.profile
    }

    func synchronize(for user: User) async throws -> Profile {
        var local = try await storageService.record(for: user.id)
        if local == nil {
            _ = try await ensureProfile(for: user)
            local = try await storageService.record(for: user.id)
        }
        guard let local else {
            throw ProfileSyncRepositoryError.profileResolutionFailed
        }

        return try await synchronizeResolvedLocal(local, userId: user.id)
    }

    func synchronize(for userId: String) async throws -> Profile {
        guard let local = try await storageService.record(for: userId) else {
            throw ProfileSyncRepositoryError.profileResolutionFailed
        }
        return try await synchronizeResolvedLocal(local, userId: userId)
    }

    func synchronizeInBackground(for user: User) {
        Task {
            do {
                _ = try await self.synchronize(for: user)
            } catch {
                await self.markSyncFailure(for: user.id, error: error)
            }
        }
    }

    func synchronizeInBackground(for userId: String) {
        Task {
            do {
                _ = try await self.synchronize(for: userId)
            } catch {
                await self.markSyncFailure(for: userId, error: error)
            }
        }
    }
}

private extension ProfileSyncRepository {
    func synchronizeResolvedLocal(_ local: ProfileSyncRecord, userId: String) async throws -> Profile {
        let localSelectedHouseholdId = local.profile.lastSelectedHouseholdId
        let localShared = local.profile.remoteNormalized()
        let base = local.lastSyncedRemoteProfile?.remoteNormalized()

        let remoteProfile = try await remoteService.fetchProfile(for: userId)
        if remoteProfile == nil {
            let createdRemote = try await remoteService.createProfile(localShared)
            let synced = syncedRecord(
                fromRemote: createdRemote,
                localSelectedHouseholdId: localSelectedHouseholdId
            )
            try await storageService.upsert(record: synced)
            await emit(synced, for: userId)
            return synced.profile
        }
        guard let remote = remoteProfile else {
            throw ProfileSyncRepositoryError.profileResolutionFailed
        }
        let remoteShared = remote.remoteNormalized()

        let merged = mergeProfiles(base: base, local: localShared, remote: remoteShared)
        let remoteNeedsUpdate = merged != remoteShared

        if remoteNeedsUpdate {
            let mergedForRemote = merged.withLocalSelectedHouseholdId(nil)
            let pushedRemote = try await remoteService.updateProfile(mergedForRemote)
            let synced = syncedRecord(
                fromRemote: pushedRemote,
                localSelectedHouseholdId: localSelectedHouseholdId
            )
            try await storageService.upsert(record: synced)
            await emit(synced, for: userId)
            return synced.profile
        } else {
            let pulled = syncedRecord(
                fromRemote: remoteShared,
                localSelectedHouseholdId: localSelectedHouseholdId
            )
            try await storageService.upsert(record: pulled)
            await emit(pulled, for: userId)
            return pulled.profile
        }
    }
    func syncedRecord(fromRemote remote: Profile, localSelectedHouseholdId: String?) -> ProfileSyncRecord {
        let selected: String?
        if let localSelectedHouseholdId, remote.householdIds.contains(localSelectedHouseholdId) {
            selected = localSelectedHouseholdId
        } else {
            selected = nil
        }

        let normalizedRemote = remote.remoteNormalized()
        return ProfileSyncRecord(
            profile: normalizedRemote.withLocalSelectedHouseholdId(selected),
            lastSyncedRemoteProfile: normalizedRemote,
            state: .synced,
            lastError: nil,
            updatedAt: Date()
        )
    }

    func mergeProfiles(base: Profile?, local: Profile, remote: Profile) -> Profile {
        let effectiveBase = base ?? remote
        let preferRemoteOnDoubleConflict = (remote.updatedAt ?? remote.createdAt ?? .distantPast) >= (local.updatedAt ?? local.createdAt ?? .distantPast)

        let mergedHouseholds = mergeHouseholdIDs(
            base: effectiveBase.householdIds,
            local: local.householdIds,
            remote: remote.householdIds
        )

        return Profile(
            id: mergeValue(base: effectiveBase.id, local: local.id, remote: remote.id, preferRemoteOnDoubleConflict: preferRemoteOnDoubleConflict),
            userId: mergeValue(base: effectiveBase.userId, local: local.userId, remote: remote.userId, preferRemoteOnDoubleConflict: preferRemoteOnDoubleConflict),
            name: mergeValue(base: effectiveBase.name, local: local.name, remote: remote.name, preferRemoteOnDoubleConflict: preferRemoteOnDoubleConflict),
            email: mergeValue(base: effectiveBase.email, local: local.email, remote: remote.email, preferRemoteOnDoubleConflict: preferRemoteOnDoubleConflict),
            avatarURL: mergeValue(base: effectiveBase.avatarURL, local: local.avatarURL, remote: remote.avatarURL, preferRemoteOnDoubleConflict: preferRemoteOnDoubleConflict),
            householdIds: mergedHouseholds,
            lastSelectedHouseholdId: nil,
            isActive: mergeValue(base: effectiveBase.isActive, local: local.isActive, remote: remote.isActive, preferRemoteOnDoubleConflict: preferRemoteOnDoubleConflict),
            createdAt: local.createdAt ?? remote.createdAt,
            updatedAt: Date()
        )
    }

    func mergeValue<T: Equatable>(
        base: T,
        local: T,
        remote: T,
        preferRemoteOnDoubleConflict: Bool
    ) -> T {
        let localChanged = local != base
        let remoteChanged = remote != base

        switch (localChanged, remoteChanged) {
        case (false, false):
            return base
        case (true, false):
            return local
        case (false, true):
            return remote
        case (true, true):
            return preferRemoteOnDoubleConflict ? remote : local
        }
    }

    func mergeHouseholdIDs(base: [String], local: [String], remote: [String]) -> [String] {
        let baseSet = Set(base)
        let localSet = Set(local)
        let remoteSet = Set(remote)

        let localAdded = localSet.subtracting(baseSet)
        let localRemoved = baseSet.subtracting(localSet)
        let remoteAdded = remoteSet.subtracting(baseSet)
        let remoteRemoved = baseSet.subtracting(remoteSet)

        var mergedSet = baseSet
        mergedSet.subtract(localRemoved.union(remoteRemoved))
        mergedSet.formUnion(localAdded)
        mergedSet.formUnion(remoteAdded)

        var ordered: [String] = []
        for id in local + remote + base {
            if mergedSet.contains(id), ordered.contains(id) == false {
                ordered.append(id)
            }
        }
        return ordered
    }

    func markSyncFailure(for userId: String, error: Error) async {
        guard let existing = try? await storageService.record(for: userId) else { return }

        let failed = ProfileSyncRecord(
            profile: existing.profile,
            lastSyncedRemoteProfile: existing.lastSyncedRemoteProfile,
            state: .failed,
            lastError: error.localizedDescription,
            updatedAt: Date()
        )
        try? await storageService.upsert(record: failed)
        await emit(failed, for: userId)
    }

    func emit(_ record: ProfileSyncRecord?, for userId: String, onlyTo specificObserver: UUID? = nil) async {
        guard let map = observers[userId] else { return }
        if let specificObserver {
            map[specificObserver]?.yield(record)
        } else {
            for continuation in map.values {
                continuation.yield(record)
            }
        }
    }

    func removeObserver(userId: String, id: UUID) {
        observers[userId]?[id] = nil
        if observers[userId]?.isEmpty == true {
            observers[userId] = nil
        }
    }
}

private enum ProfileSyncRepositoryError: LocalizedError {
    case profileResolutionFailed

    var errorDescription: String? {
        switch self {
        case .profileResolutionFailed:
            return "Could not resolve profile during synchronization."
        }
    }
}
