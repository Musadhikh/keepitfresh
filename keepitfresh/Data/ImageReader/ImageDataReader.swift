//
//
//  ImageDataReader.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: ImageDataReader
//
    

import Foundation
import Vision
import CameraModule

enum ObservedType: String, Sendable, ModelStringConvertible {
    case barcode
    case text
}
struct ImageData: Sendable, ModelStringConvertible {
    var value: [String?]
    var type: ObservedType
}

actor ImageDataReader: Sendable {
    private let maxConcurrentRequests: Int
    
    init(maxConcurrentRequests: Int = 3) {
        self.maxConcurrentRequests = maxConcurrentRequests
    }
    
    func readData(images: [CameraCapturedImage]) async -> [ImageData] {
        let cgImages = images.compactMap { image in
            if let cgImage = image.image.cgImage {
                return (cgImage, CGImagePropertyOrientation(image.image.imageOrientation))
            }
            return nil
        }
        
        let results = await read(images: cgImages)
        return prepareDataFrom(results: results)
    }
}

extension ImageDataReader {
    private func prepareDataFrom(results: [VisionResult]) -> [ImageData] {
        
        var imageData: [ImageData] = []
        
        for result in results {
            if case let .detectBarcodes(_, observations)  = result {
                let barcodeData = observations.compactMap { observation -> ImageData? in
                    return ImageData(value: [observation.payloadString], type: .barcode)
                }
                imageData.append(contentsOf: barcodeData)
            } else if case let .recognizeText(_, observations) = result {
                let textData = observations.compactMap { observation -> ImageData? in
                    let values = observation
                        .topCandidates(3)
                        .map(\.string)
                        
                    
                    return ImageData(value: values, type: .text)
                }
                imageData.append(contentsOf: textData)
            }
        }
        
        return imageData
    }
}

extension ImageDataReader {
    
    private func read(images: [(CGImage, CGImagePropertyOrientation?)]) async -> [VisionResult] {
        var results: [[VisionResult]?] = Array(repeating: nil, count: images.count)
        
        var nextIndex = 0
        
        await withTaskGroup(of: (Int, [VisionResult]).self) { group in
            
            let initialGroupSize = min(maxConcurrentRequests, images.count)
            for _ in 0..<initialGroupSize {
                let image = images[nextIndex]
                addTask(group: &group, index: nextIndex, image: image)
                nextIndex += 1
            }
            
            while let (finishedIndex, result) = await group.next() {
                results[finishedIndex] = result
                
                if nextIndex < images.count {
                    let image = images[nextIndex]
                    addTask(group: &group, index: nextIndex, image: image)
                    nextIndex += 1
                }
            }
        }
    
        return results.compactMap(\.self).flatMap(\.self)
    }
    
    private func addTask(
        group: inout TaskGroup<(Int, [VisionResult])>,
        index: Int,
        image: (CGImage, CGImagePropertyOrientation?)
    ) {
        group.addTask {
            let result = await self.read(image: image.0, orientation: image.1)
            return (index, result)
        }
    }
    
    private func read(image: CGImage, orientation: CGImagePropertyOrientation?) async -> [VisionResult] {
        let barcodeRequest = DetectBarcodesRequest()
        
        var textRequest = RecognizeTextRequest()
        textRequest.recognitionLevel = .accurate
        textRequest.usesLanguageCorrection = true
        textRequest.automaticallyDetectsLanguage = true
        
        let handler = ImageRequestHandler(image, orientation: orientation)
        
        let requests: [any ImageProcessingRequest] = [barcodeRequest, textRequest]
        let responses = handler.performAll(requests)
        
        var results: [VisionResult] = []
        for await response in responses {
            results.append(response)
        }
        
        return results
    }
}
