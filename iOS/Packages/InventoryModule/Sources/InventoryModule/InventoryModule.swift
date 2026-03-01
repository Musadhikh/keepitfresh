//
//  InventoryModule.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Exposes package facade for integrating inventory application services.
//

import Foundation
import InventoryApplication

public struct InventoryModule: Sendable {
    public let service: any InventoryModuleServicing

    public init(service: any InventoryModuleServicing) {
        self.service = service
    }
}

