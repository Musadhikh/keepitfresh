//
//  DIContainer.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//  Summary: Registers app dependencies using Factory.
//

import Factory
import HouseModule
import InventoryModule
import ProductModule
import RealmDatabaseModule


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

    var addProductInventoryRepository: Factory<any InventoryRepository> {
        self { RealmInventoryRepository() }
            .singleton
    }

    var addProductCatalogRepository: Factory<any CatalogRepository> {
        self { RealmCatalogRepository() }
            .singleton
    }

    var addProductCatalogService: Factory<any AddProductCatalogServicing> {
        self {
            ProductModuleAddProductCatalogService(
                productModuleService: self.productModuleService(),
                localStore: self.productModuleLocalStore()
            )
        }
            .singleton
    }

    var appConnectivityProvider: Factory<AppConnectivityProvider> {
        self { .shared }
            .singleton
    }

    var networkConnectivityProvider: Factory<any NetworkConnectivityProviding> {
        self { self.appConnectivityProvider() }
            .singleton
    }

    var productModuleLocalStore: Factory<any ProductLocalStore> {
        self { RealmProductLocalStore(configuration: .default) }
            .singleton
    }

    var productModuleCatalogRemoteRepository: Factory<any CatalogRepository> {
        self { FirestoreCatalogRepository() }
            .singleton
    }

    var productModuleRemoteGateway: Factory<any ProductRemoteGateway> {
        self {
            CatalogProductRemoteGateway(
                catalogRepository: self.productModuleCatalogRemoteRepository()
            )
        }
            .singleton
    }

    var productModuleSyncStateStore: Factory<any ProductSyncStateStore> {
        self { RealmProductSyncStateStore(configuration: .default) }
            .singleton
    }

    var productModuleConnectivityProvider: Factory<any ProductModuleTypes.ConnectivityProviding> {
        self { self.appConnectivityProvider() }
            .singleton
    }

    var productModuleService: Factory<any ProductModuleServicing> {
        self {
            DefaultProductModuleService(
                localStore: self.productModuleLocalStore(),
                remoteGateway: self.productModuleRemoteGateway(),
                syncStateStore: self.productModuleSyncStateStore(),
                connectivity: self.productModuleConnectivityProvider(),
                clock: ProductModuleTypes.SystemClock(),
                strategy: .offlineFirstDefault
            )
        }
            .singleton
    }

    // MARK: - InventoryModule (Business Logic Package)

    var inventoryModuleInventoryRepository: Factory<any InventoryModuleTypes.InventoryRepository> {
        self { RealmInventoryModuleRepository(configuration: .default) }
            .singleton
    }

    var inventoryModuleLocationRepository: Factory<any InventoryModuleTypes.LocationRepository> {
        self { RealmInventoryModuleLocationRepository(configuration: .default) }
            .singleton
    }

    var inventoryModuleRemoteGateway: Factory<any InventoryModuleTypes.InventoryRemoteGateway> {
        self { StubInventoryModuleRemoteGateway() }
            .singleton
    }

    var inventoryModuleSyncStateStore: Factory<any InventoryModuleTypes.InventorySyncStateStore> {
        self { RealmInventoryModuleSyncStateStore(configuration: .default) }
            .singleton
    }

    var inventoryModuleWarmupRunStore: Factory<any InventoryModuleTypes.InventoryWarmupRunStore> {
        self { RealmInventoryModuleWarmupRunStore(configuration: .default) }
            .singleton
    }

    var inventoryModuleConnectivityProvider: Factory<any InventoryModuleTypes.ConnectivityProviding> {
        self { self.appConnectivityProvider() }
            .singleton
    }

    var inventoryModuleAddUseCase: Factory<any InventoryModuleTypes.AddInventoryItemUseCase> {
        self {
            DefaultAddInventoryItemUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                locationRepository: self.inventoryModuleLocationRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                syncStateStore: self.inventoryModuleSyncStateStore(),
                connectivity: self.inventoryModuleConnectivityProvider(),
                clock: InventoryModuleTypes.SystemClock()
            )
        }
            .singleton
    }

    var inventoryModuleConsumeUseCase: Factory<any InventoryModuleTypes.ConsumeInventoryUseCase> {
        self {
            DefaultConsumeInventoryUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                syncStateStore: self.inventoryModuleSyncStateStore(),
                connectivity: self.inventoryModuleConnectivityProvider(),
                clock: InventoryModuleTypes.SystemClock()
            )
        }
            .singleton
    }

    var inventoryModuleDeleteUseCase: Factory<any InventoryModuleTypes.DeleteInventoryItemUseCase> {
        self {
            DefaultDeleteInventoryItemUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                syncStateStore: self.inventoryModuleSyncStateStore(),
                connectivity: self.inventoryModuleConnectivityProvider(),
                clock: InventoryModuleTypes.SystemClock()
            )
        }
            .singleton
    }

    var inventoryModuleMoveUseCase: Factory<any InventoryModuleTypes.MoveInventoryItemLocationUseCase> {
        self {
            DefaultMoveInventoryItemLocationUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                locationRepository: self.inventoryModuleLocationRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                syncStateStore: self.inventoryModuleSyncStateStore(),
                connectivity: self.inventoryModuleConnectivityProvider(),
                clock: InventoryModuleTypes.SystemClock()
            )
        }
            .singleton
    }

    var inventoryModuleUpdateDatesUseCase: Factory<any InventoryModuleTypes.UpdateInventoryItemDatesUseCase> {
        self {
            DefaultUpdateInventoryItemDatesUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                syncStateStore: self.inventoryModuleSyncStateStore(),
                connectivity: self.inventoryModuleConnectivityProvider(),
                clock: InventoryModuleTypes.SystemClock()
            )
        }
            .singleton
    }

    var inventoryModuleGetExpiredUseCase: Factory<any InventoryModuleTypes.GetExpiredItemsUseCase> {
        self {
            DefaultGetExpiredItemsUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                connectivity: self.inventoryModuleConnectivityProvider()
            )
        }
            .singleton
    }

    var inventoryModuleGetExpiringUseCase: Factory<any InventoryModuleTypes.GetExpiringItemsUseCase> {
        self {
            DefaultGetExpiringItemsUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                connectivity: self.inventoryModuleConnectivityProvider()
            )
        }
            .singleton
    }

    var inventoryModuleSummaryUseCase: Factory<any InventoryModuleTypes.GetInventorySummaryByProductUseCase> {
        self {
            DefaultGetInventorySummaryByProductUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository()
            )
        }
            .singleton
    }

    var inventoryModuleSyncPendingUseCase: Factory<any InventoryModuleTypes.SyncPendingInventoryUseCase> {
        self {
            DefaultSyncPendingInventoryUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                syncStateStore: self.inventoryModuleSyncStateStore(),
                connectivity: self.inventoryModuleConnectivityProvider(),
                clock: InventoryModuleTypes.SystemClock()
            )
        }
            .singleton
    }

    var inventoryModuleWarmupUseCase: Factory<any InventoryModuleTypes.WarmExpiringInventoryWindowUseCase> {
        self {
            DefaultWarmExpiringInventoryWindowUseCase(
                inventoryRepository: self.inventoryModuleInventoryRepository(),
                remoteGateway: self.inventoryModuleRemoteGateway(),
                warmupRunStore: self.inventoryModuleWarmupRunStore(),
                connectivity: self.inventoryModuleConnectivityProvider()
            )
        }
            .singleton
    }

    var inventoryModuleService: Factory<any InventoryModuleTypes.InventoryModuleServicing> {
        self {
            AppInventoryModuleService(
                addUseCase: self.inventoryModuleAddUseCase(),
                consumeUseCase: self.inventoryModuleConsumeUseCase(),
                deleteUseCase: self.inventoryModuleDeleteUseCase(),
                moveUseCase: self.inventoryModuleMoveUseCase(),
                updateDatesUseCase: self.inventoryModuleUpdateDatesUseCase(),
                getExpiredUseCase: self.inventoryModuleGetExpiredUseCase(),
                getExpiringUseCase: self.inventoryModuleGetExpiringUseCase(),
                summaryUseCase: self.inventoryModuleSummaryUseCase(),
                syncPendingUseCase: self.inventoryModuleSyncPendingUseCase(),
                warmupUseCase: self.inventoryModuleWarmupUseCase()
            )
        }
            .singleton
    }
}
