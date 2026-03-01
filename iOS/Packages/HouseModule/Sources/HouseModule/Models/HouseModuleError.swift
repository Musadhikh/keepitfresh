//
//  HouseModuleError.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Declares domain-safe error values for household module operations.
//

import Foundation

public enum HouseModuleError: Error, Sendable, Equatable {
    case householdNotFound(String)
    case storageUnavailable
    case networkUnavailable
    case invalidHouseName
}
