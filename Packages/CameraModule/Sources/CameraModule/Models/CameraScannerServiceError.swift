//
//  CameraScannerServiceError.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines camera service errors used by scanner capture workflows.
//

import Foundation

public enum CameraScannerServiceError: LocalizedError {
    case permissionDenied
    case sessionConfigurationFailed
    case sessionNotRunning
    case captureInProgress
    case photoDataUnavailable
    case cameraUnavailable
    
    public var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return "Camera permission was denied."
        case .sessionConfigurationFailed:
            return "Failed to configure camera session."
        case .sessionNotRunning:
            return "Camera session is not running."
        case .captureInProgress:
            return "Please wait for current capture to finish."
        case .photoDataUnavailable:
            return "Unable to read captured photo data."
        case .cameraUnavailable:
            return "Camera is not available on this device."
        }
    }
}
