//
//  ProductModule.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Exposes the package facade for integrating product application services.
//

import Foundation
import ProductApplication

public struct ProductModule: Sendable {
    public let service: any ProductModuleServicing

    public init(service: any ProductModuleServicing) {
        self.service = service
    }
}
