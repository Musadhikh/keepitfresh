//
//
//  CameraCapturedImage+Extension.swift
//  keepitfresh
//
//  Created by musadhikh on 3/3/26.
//  Summary: CameraCapturedImage+Extension <#brief summary#>
//
    

import CameraModule

extension CameraCapturedImage {
    var imageCaptured: ImagesCaptured {
        ImagesCaptured(
            id: self.id,
            image: self.image,
            boundingBox: self.boundingBox,
            imageSize: self.imageSize
        )
    }
}

extension Collection where Element == CameraCapturedImage {
    var imagesCaptured: [ImagesCaptured] {
        self.map(\.imageCaptured)
    }
}
