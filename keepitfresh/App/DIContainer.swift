//
//  DIContainer.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//  Summary: Registers app dependencies using Factory.
//

import Factory
import HouseModule

extension Container {
    var appMetadataProvider: Factory<AppMetadataProviding> {
        self { AppMetadataService() }
    }
    
    var versionCheckProvider: Factory<VersionCheckProvider> {
        self { VersionCheckProvider() }
    }
    
    var userProvider: Factory<UserProviding> {
        self { UserFirebaseService() }
    }
    
    var profileProvider: Factory<ProfileProviding> {
        self { ProfileFirebaseService() }
    }
    
    var houseProvider: Factory<HouseProviding> {
        self { HouseFirebaseService() }
    }
    
    var houseModuleStorageService: Factory<any HouseStorageServicing> {
        self { InMemoryHouseStorageService() }
            .singleton
    }
    
    var houseModuleNetworkService: Factory<any HouseNetworkServicing> {
        self { HouseNetworkServiceAdapter(houseProvider: self.houseProvider()) }
    }
    
    var houseDomainModule: Factory<HouseModule> {
        self {
            HouseModule(
                storageService: self.houseModuleStorageService(),
                networkService: self.houseModuleNetworkService()
            )
        }
            .singleton
    }
    
    var profileStorageService: Factory<any ProfileStorageServicing> {
        self { RealmProfileStorageService() }
            .singleton
    }
    
    var profileRemoteService: Factory<any ProfileRemoteServicing> {
        self { ProfileRemoteServiceAdapter(profileProvider: self.profileProvider()) }
    }
    
    var profileSyncRepository: Factory<ProfileSyncRepository> {
        self {
            ProfileSyncRepository(
                storageService: self.profileStorageService(),
                remoteService: self.profileRemoteService()
            )
        }
            .singleton
    }
    
    var updateProfileHouseholdsUseCase: Factory<UpdateProfileHouseholdsUseCase> {
        self { UpdateProfileHouseholdsUseCase(repository: self.profileSyncRepository()) }
    }
    
    var createHouseUseCase: Factory<CreateHouseUseCase> {
        self { CreateHouseUseCase() }
    }
    
    var loadHouseholdsForCurrentUserUseCase: Factory<LoadHouseholdsForCurrentUserUseCase> {
        self { LoadHouseholdsForCurrentUserUseCase() }
    }
    
    var selectHouseUseCase: Factory<SelectHouseUseCase> {
        self { SelectHouseUseCase() }
    }
}
