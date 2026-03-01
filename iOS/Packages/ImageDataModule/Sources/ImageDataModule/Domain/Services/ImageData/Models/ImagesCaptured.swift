//
//  ImagesCaptured.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Captured image payload used by Vision extraction services with platform-neutral image storage.
//

import CoreGraphics
import Foundation
import ImageIO

public protocol ImageData: Sendable {
    var cgImage: CGImage { get set }
    var orientation: CGImagePropertyOrientation { get set }
}
