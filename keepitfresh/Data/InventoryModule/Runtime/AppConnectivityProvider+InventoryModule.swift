//
//  AppConnectivityProvider+InventoryModule.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Bridges the app connectivity provider into InventoryModule connectivity port.
//

import Foundation
import InventoryModule

extension AppConnectivityProvider: InventoryModuleTypes.ConnectivityProviding {}

