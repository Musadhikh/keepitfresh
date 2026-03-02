//
//  AddProductCapturedImage.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: Captured image payload used by Add Product extraction state and use case APIs.
//

import Foundation
import UIKit
import ImageDataModule

struct ImagesCaptured: ImageData, Identifiable, Equatable, Sendable {
    var cgImage: CGImage
    var orientation: CGImagePropertyOrientation

    let id: UUID
    let image: UIImage
    let boundingBox: CGRect
    let imageSize: CGSize

    init(
        id: UUID,
        image: UIImage,
        boundingBox: CGRect,
        imageSize: CGSize
    ) {
        self.id = id
        self.image = image
        self.boundingBox = boundingBox
        self.imageSize = imageSize
        self.cgImage = image.cgImage!
        self.orientation = CGImagePropertyOrientation(image.imageOrientation)
    }
}
