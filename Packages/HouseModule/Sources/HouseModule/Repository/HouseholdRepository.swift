//
//  HouseholdRepository.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Coordinates storage and network operations for household data using constructor injection.
//

import Foundation

public actor HouseholdRepository {
    private let storageService: any HouseStorageServicing
    private let networkService: any HouseNetworkServicing
    
    public init(
        storageService: any HouseStorageServicing,
        networkService: any HouseNetworkServicing
    ) {
        self.storageService = storageService
        self.networkService = networkService
    }
    
    public func loadHouseholds(
        ids: [String],
        policy: HouseLoadPolicy
    ) async throws -> [Household] {
        guard !ids.isEmpty else { return [] }
        
        switch policy {
        case .localOnly:
            return try await loadLocal(ids: ids)
        case .remoteOnly:
            let remote = try await loadRemote(ids: ids)
            return order(remote, by: ids)
        case .localFirst:
            let local = try await loadLocal(ids: ids)
            if local.count == ids.count {
                return order(local, by: ids)
            }
            let remote = try await loadRemote(ids: ids)
            return order(remote, by: ids)
        case .remoteFirst:
            do {
                let remote = try await loadRemote(ids: ids)
                return order(remote, by: ids)
            } catch {
                return try await loadLocal(ids: ids)
            }
        }
    }
    
    public func syncHouseholds(ids: [String]) async throws -> [Household] {
        let households = try await loadRemote(ids: ids)
        return order(households, by: ids)
    }
    
    public func createHousehold(_ request: CreateHouseholdRequest) async throws -> Household {
        let trimmedName = request.name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            throw HouseModuleError.invalidHouseName
        }
        
        let now = Date()
        let pendingHousehold = Household(
            id: "local-\(UUID().uuidString)",
            name: trimmedName,
            description: request.description,
            ownerId: request.ownerId,
            memberIds: request.memberIds,
            createdAt: now,
            updatedAt: now,
            syncState: .pending
        )
        
        try await storageService.upsertHousehold(pendingHousehold)
        
        do {
            let remote = try await networkService.createHousehold(
                CreateHouseholdRequest(
                    name: trimmedName,
                    description: request.description,
                    ownerId: request.ownerId,
                    memberIds: request.memberIds
                )
            )
            let synced = Household(
                id: remote.id,
                name: remote.name,
                description: remote.description,
                ownerId: remote.ownerId,
                memberIds: remote.memberIds,
                createdAt: remote.createdAt,
                updatedAt: remote.updatedAt,
                syncState: .synced
            )
            
            if synced.id != pendingHousehold.id {
                try await storageService.deleteHousehold(id: pendingHousehold.id)
            }
            try await storageService.upsertHousehold(synced)
            return synced
        } catch {
            let failed = Household(
                id: pendingHousehold.id,
                name: pendingHousehold.name,
                description: pendingHousehold.description,
                ownerId: pendingHousehold.ownerId,
                memberIds: pendingHousehold.memberIds,
                createdAt: pendingHousehold.createdAt,
                updatedAt: Date(),
                syncState: .failed
            )
            try await storageService.upsertHousehold(failed)
            throw error
        }
    }
    
    public func updateHousehold(_ household: Household) async throws -> Household {
        let updated = try await networkService.updateHousehold(household)
        let synced = Household(
            id: updated.id,
            name: updated.name,
            description: updated.description,
            ownerId: updated.ownerId,
            memberIds: updated.memberIds,
            createdAt: updated.createdAt,
            updatedAt: updated.updatedAt,
            syncState: .synced
        )
        try await storageService.upsertHousehold(synced)
        return synced
    }
    
    public func deleteHousehold(id: String) async throws {
        try await networkService.deleteHousehold(id: id)
        try await storageService.deleteHousehold(id: id)
    }
    
    private func loadLocal(ids: [String]) async throws -> [Household] {
        let local = try await storageService.fetchHouseholds(ids: ids)
        return order(local, by: ids)
    }
    
    private func loadRemote(ids: [String]) async throws -> [Household] {
        let remote = try await networkService.fetchHouseholds(ids: ids)
        let synced = remote.map {
            Household(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                ownerId: $0.ownerId,
                memberIds: $0.memberIds,
                createdAt: $0.createdAt,
                updatedAt: $0.updatedAt,
                syncState: .synced
            )
        }
        for house in synced {
            try await storageService.upsertHousehold(house)
        }
        return synced
    }
    
    private func order(_ households: [Household], by ids: [String]) -> [Household] {
        let byID = Dictionary(uniqueKeysWithValues: households.map { ($0.id, $0) })
        return ids.compactMap { byID[$0] }
    }
}
