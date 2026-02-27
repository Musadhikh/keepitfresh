//
//  ProductModuleError.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines module-level errors for validation and sync orchestration failures.
//

import Foundation

public enum ProductModuleError: Error, Sendable, Equatable {
    case emptyProductID
    case invalidBarcode
    case productIDMustMatchBarcode(productID: String, normalizedBarcode: String)
    case remoteSyncFailed(message: String)
    case connectivityUnavailable(operation: ConnectivityOperation)
}

public enum ConnectivityOperation: String, Sendable, Equatable {
    case retrieveProduct
    case retrieveProducts
    case syncPending
}
