//
//  CameraCapturedImage.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Defines captured image payload returned by the camera service.
//

import CoreGraphics
import Foundation
import UIKit

public struct CameraCapturedImage: Identifiable, Equatable {
    public let id: UUID
    public let image: UIImage
    public let boundingBox: CGRect
    public let imageSize: CGSize
    
    public init(
        id: UUID,
        image: UIImage,
        boundingBox: CGRect,
        imageSize: CGSize
    ) {
        self.id = id
        self.image = image
        self.boundingBox = boundingBox
        self.imageSize = imageSize
    }
}

extension CameraCapturedImage: @unchecked Sendable {}
