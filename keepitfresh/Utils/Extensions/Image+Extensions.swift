//
//
//  Image+Extensions.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: Image+Extensions <#brief summary#>
//
    

import UIKit
import ImageIO

extension CGImagePropertyOrientation {
    /**
     Converts a `UIImage.Orientation` to a corresponding `CGImagePropertyOrientation`.
     */
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        @unknown default:
            // Handle future cases gracefully, default to .up or log an error as appropriate
            self = .up
        }
    }
}
