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

@Observable
@MainActor
class ProductReviewViewModel {
    
    private let imageProcessor: ImageProcessor
    let capturedImages: [ImagesCaptured]
    
    var generatedData: ExtractedData.PartiallyGenerated?
    
    var numberOfItems: Int = 1
    
    init(capturedImages:[ImagesCaptured]) {
        self.capturedImages = capturedImages
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
    
    func prepareData() {
        
    }
}
