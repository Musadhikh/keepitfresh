//
//  ImageDataModule.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Exposes the public API surface for the ImageDataModule package.
//

import Foundation
import FoundationModels

public final class ImageProcessor: Sendable {
    let extractorService: any ImageDataExtracting
    let generatorService: any ImageDataGenerating

    public init(instruction: Instruction) {
        self.extractorService = DefaultImageDataExtractor(maxConcurrentRequests: 3)
        self.generatorService = DefaultImageDataGenerator(instruction: instruction)
    }
    
    public init(extractorService: any ImageDataExtracting, generatorService: any ImageDataGenerating) {
        self.extractorService = extractorService
        self.generatorService = generatorService
    }
    
    public func inventoryData(images: [any ImageData]) -> AsyncThrowingStream<ExtractedData.PartiallyGenerated?, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    let extracted = try await extractorService.extract(from: images)
                    let generator = self.generatorService.generateData(
                        from: PromptType.inventory(extracted),
                        type: ExtractedData.self
                    )
                    for try await partial in generator {
                        continuation.yield(partial)
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}
