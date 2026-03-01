//
//  BarcodeScannerConfiguration.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Holds scanner tuning options that trade off recognition quality, latency, and UX behavior.
//

import Foundation

public enum BarcodeScannerMode: Equatable, Sendable {
    case continuous
    case tapToCapture
}

public enum BarcodeScannerQuality: Equatable, Sendable {
    case fast
    case balanced
    case accurate
}

public enum BarcodeSymbology: String, CaseIterable, Sendable {
    case ean8
    case ean13
    case upce
    case qr
    case code128
    case code39
    case dataMatrix
    case pdf417
    case itf14
    case aztec
}

public struct BarcodeScannerConfiguration: Sendable {
    public var mode: BarcodeScannerMode
    public var quality: BarcodeScannerQuality
    public var symbologies: [BarcodeSymbology]
    public var isHighFrameRateTrackingEnabled: Bool
    public var isPinchToZoomEnabled: Bool
    public var isGuidanceEnabled: Bool
    public var isHighlightingEnabled: Bool
    public var isHapticsEnabled: Bool
    public var continuousDebounceInterval: TimeInterval
    public var duplicateFilterInterval: TimeInterval

    public init(
        mode: BarcodeScannerMode = .continuous,
        quality: BarcodeScannerQuality = .balanced,
        symbologies: [BarcodeSymbology] = [.ean13, .ean8, .upce, .code128, .qr],
        isHighFrameRateTrackingEnabled: Bool = true,
        isPinchToZoomEnabled: Bool = true,
        isGuidanceEnabled: Bool = true,
        isHighlightingEnabled: Bool = true,
        isHapticsEnabled: Bool = true,
        continuousDebounceInterval: TimeInterval = 0.15,
        duplicateFilterInterval: TimeInterval = 1.0
    ) {
        self.mode = mode
        self.quality = quality
        self.symbologies = symbologies
        self.isHighFrameRateTrackingEnabled = isHighFrameRateTrackingEnabled
        self.isPinchToZoomEnabled = isPinchToZoomEnabled
        self.isGuidanceEnabled = isGuidanceEnabled
        self.isHighlightingEnabled = isHighlightingEnabled
        self.isHapticsEnabled = isHapticsEnabled
        self.continuousDebounceInterval = continuousDebounceInterval
        self.duplicateFilterInterval = duplicateFilterInterval
    }
}
