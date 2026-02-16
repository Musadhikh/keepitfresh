//
//
//  ImageDataGenerator.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: ImageDataGenerator
//
    

import Foundation
import FoundationModels


final class ImageDataGenerator: Sendable {
    private let model: SystemLanguageModel
    
    init(model: SystemLanguageModel) {
        self.model = model
    }
    
    func generateModel(from data: [ImageData]) -> AsyncThrowingStream<Product.PartiallyGenerated?, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    let session = LanguageModelSession(instructions: instructions())
                    
                    let prompt = self.prompt(from: data)
                    
                    let stream = session.streamResponse(to: prompt, generating: Product.self)
                    
                    for try await generatedProduct in stream {
                        continuation.yield(generatedProduct.content)
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

extension ImageDataGenerator {
    private func instructions() -> String {
        """
        You are Inventory Structured Extraction Engine.
        Your job is to extract ONLY what is explicitly present in the provided input (OCR text + barcode results).
        You must produce a single structured output that conforms to the target schema.
        """
    }
    
    private func prompt(from data: [ImageData]) -> Prompt {
        let barcodeTexts = data
            .filter { $0.type == .barcode }
            .flatMap(\.value)
            .compactMap(\.self)
            
        let ocrTexts = data
            .filter { $0.type == .text }
            .flatMap(\.value)
            .compactMap(\.self)
        
        return Prompt {
            "Extract structured product information using the provided OCR text and barcode results."
            "Barcodes:"
            barcodeTexts
            
            "Texts:"
            ocrTexts
        }
    }
}
