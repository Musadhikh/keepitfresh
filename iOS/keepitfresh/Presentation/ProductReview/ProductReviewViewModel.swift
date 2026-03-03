//
//
//  ProductReviewViewModel.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: ProductReviewViewModel.
//
    

import Foundation
import Observation
import ImageDataModule
import UIKit

@Observable
@MainActor
class ProductReviewViewModel {
    
    private let imageProcessor: ImageProcessor
    let capturedImages: [ImagesCaptured]
    let displayImages: [UIImage]
    
    var generatedData: ExtractedData.PartiallyGenerated?
    
    var numberOfItems: Int = 1
    var onAdd: (Product) -> Void
    
    init(capturedImages:[ImagesCaptured], onAdd: @escaping (Product) -> Void) {
        self.capturedImages = capturedImages
        self.displayImages = capturedImages.map(\.image)
        self.onAdd = onAdd
        self.imageProcessor = ImageProcessor(instruction: .inventoryAssistant)
    }
    
    func startReviewProcess() async {
        do {
            
            let inventoryDataGenerator = imageProcessor.inventoryData(images: capturedImages)
            
            for try await data in inventoryDataGenerator {
                generatedData = data
            }
            
        } catch {
            logger.error("error: \(error)")
        }
    }
    
    func prepareData(){
        if let product = generatedData?.toProduct() {
            onAdd(product)
        }
    }
}
