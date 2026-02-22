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

@Observable
@MainActor
class ProductReviewViewModel {
    private let extractionService: VisionExtracting
    private let aiDataGeneratingService: AIDataGenerating
    let capturedImages: [ImagesCaptured]
    
    var generatedData: ExtractedData.PartiallyGenerated?
    
    var numberOfItems: Int = 1
    
    init(capturedImages:[ImagesCaptured]) {
        self.capturedImages = capturedImages
        self.extractionService = ImageDataExtractorService()
        self.aiDataGeneratingService = ImageDataGeneratorService(instruction: .inventoryAssistant)
    }
    
    func startReviewProcess() async {
        do {
            let extracted = try await extractionService.extract(from: capturedImages)
            let dataGenerator = aiDataGeneratingService.generateData(
                from: .inventory(extracted),
                type: ExtractedData.self
            )
            
            for try await data in dataGenerator {
                generatedData = data
            }
            
        } catch {
            logger.error("error: \(error)")
        }
    }
    
    func prepareData() {
        
    }
}
