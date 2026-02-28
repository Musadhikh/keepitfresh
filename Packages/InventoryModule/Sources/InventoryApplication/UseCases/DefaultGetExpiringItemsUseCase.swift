//
//  DefaultGetExpiringItemsUseCase.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Implements local-first expiring-items reads with remote cache fallback/refresh.
//

import Foundation
import InventoryDomain

public actor DefaultGetExpiringItemsUseCase: GetExpiringItemsUseCase {
    private let inventoryRepository: any InventoryRepository
    private let remoteGateway: any InventoryRemoteGateway
    private let connectivity: any ConnectivityProviding

    public init(
        inventoryRepository: any InventoryRepository,
        remoteGateway: any InventoryRemoteGateway,
        connectivity: any ConnectivityProviding
    ) {
        self.inventoryRepository = inventoryRepository
        self.remoteGateway = remoteGateway
        self.connectivity = connectivity
    }

    public func execute(_ input: GetExpiringItemsInput) async throws -> [InventoryItem] {
        try validate(input)

        let local = try await inventoryRepository.fetchExpiring(
            input.householdId,
            asOf: input.today,
            windowDays: input.windowDays,
            timeZone: input.timeZone
        )
        let hasLocalData = try await inventoryRepository.hasAnyItems(householdId: input.householdId)

        guard await connectivity.isOnline() else {
            return local
        }

        if hasLocalData {
            try? await refreshLocalCache(householdId: input.householdId)
            return local
        }

        try await refreshLocalCache(householdId: input.householdId)
        return try await inventoryRepository.fetchExpiring(
            input.householdId,
            asOf: input.today,
            windowDays: input.windowDays,
            timeZone: input.timeZone
        )
    }
}

private extension DefaultGetExpiringItemsUseCase {
    func validate(_ input: GetExpiringItemsInput) throws {
        if input.householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw InventoryDomainError.invalidHouseholdID
        }
        if input.windowDays < 0 {
            throw InventoryDomainError.invalidWindowDays
        }
    }

    func refreshLocalCache(householdId: String) async throws {
        let remoteItems = try await remoteGateway.fetchActiveItems(householdId: householdId)
        try await inventoryRepository.updateMany(remoteItems)
    }
}

