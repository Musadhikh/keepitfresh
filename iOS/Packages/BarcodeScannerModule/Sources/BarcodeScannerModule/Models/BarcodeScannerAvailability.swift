//
//  BarcodeScannerAvailability.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Describes runtime scanner availability states for VisionKit-backed barcode scanning.
//

import Foundation

public enum BarcodeScannerAvailability: Equatable, Sendable {
    case ready
    case unsupportedDevice
    case unavailable(reason: String)

    public var message: String {
        switch self {
        case .ready:
            return ""
        case .unsupportedDevice:
            return "Live barcode scanning is not supported on this device."
        case .unavailable(let reason):
            return reason
        }
    }
}
