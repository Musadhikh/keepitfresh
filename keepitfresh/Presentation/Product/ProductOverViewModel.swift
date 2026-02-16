//
//
//  ProductOverViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: ProductOverViewModel 
//
    

import Foundation
import CameraModule
import FoundationModels

@Observable
@MainActor
class ProductOverViewModel {
    private let capturedImages: [CameraCapturedImage]
    let imageDataReader: ImageDataReader = ImageDataReader()
    let imageDataGenerator: ImageDataGenerator = ImageDataGenerator(model: .init(useCase: .contentTagging))
    
    private(set) var product: Product.PartiallyGenerated?
    
    init(capturedImages: [CameraCapturedImage]) {
        self.capturedImages = capturedImages
    }
    
    func start() async {
        do {
            let imageData =  await imageDataReader.readData(images: capturedImages)
            
            logger.debug("image data: \(imageData)")
            
            let generator = imageDataGenerator.generateModel(from: imageData)
            for try await generated in  generator {
                product = generated
            }
        } catch {
            logger.error("generating model failed: \(error)")
        }
    }
}

extension ProductOverViewModel {
    var imageCount: Int {
        capturedImages.count
    }
}
