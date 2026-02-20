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
    
    func generateModel(from data: [ObservedType]) -> AsyncThrowingStream<ProductBaseExtraction.PartiallyGenerated?, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    let session = LanguageModelSession(instructions: instructions())
                    
                    let prompt = self.prompt(from: data)
                    
                    let stream = session.streamResponse(to: prompt, generating: ProductBaseExtraction.self)
                    
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
    
    private func prompt(from data: [ObservedType]) -> Prompt {
        var barcodes: [String] = []
        var ocrTexts: [String] = []
        
        for item in data {
            switch item {
            case .barcode(value: let barcode, symbology: _):
                barcodes.append(barcode)
            case .text(value: let text):
                ocrTexts.append(text)
            case .paragraph(value: let value):
                if value.isNotEmpty {
                    ocrTexts.append(value.joined(separator: " "))
                }
            }
        }
        
        return Prompt {
            "Extract structured product information using the provided OCR text and barcode results."
            "Barcodes:"
            barcodes
            
            "OCR Texts:"
            ocrTexts
        }
    }
}
