//
//  HouseModule.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Exposes the package entry point and wires household use cases using constructor-injected services.
//

import Foundation

public struct HouseModule: Sendable {
    public let loadHouseholds: LoadHouseholdsUseCase
    public let syncHouseholds: SyncHouseholdsUseCase
    public let createHousehold: CreateHouseholdUseCase
    public let updateHousehold: UpdateHouseholdUseCase
    public let deleteHousehold: DeleteHouseholdUseCase
    
    public init(
        storageService: any HouseStorageServicing,
        networkService: any HouseNetworkServicing
    ) {
        let repository = HouseholdRepository(
            storageService: storageService,
            networkService: networkService
        )
        self.loadHouseholds = LoadHouseholdsUseCase(repository: repository)
        self.syncHouseholds = SyncHouseholdsUseCase(repository: repository)
        self.createHousehold = CreateHouseholdUseCase(repository: repository)
        self.updateHousehold = UpdateHouseholdUseCase(repository: repository)
        self.deleteHousehold = DeleteHouseholdUseCase(repository: repository)
    }
}

