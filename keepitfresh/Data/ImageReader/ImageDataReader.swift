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

enum ObservedType: Sendable, ModelStringConvertible {
    case barcode(value: String, symbology: BarcodeSymbology)
    case text(value: String)
    case paragraph(value: [String])
}

actor ImageDataReader: Sendable {
    private let maxConcurrentRequests: Int
    
    init(maxConcurrentRequests: Int = 3) {
        self.maxConcurrentRequests = maxConcurrentRequests
    }
    
    func readData(images: [CameraCapturedImage]) async -> [[ObservedType]] {
        let cgImages = images.compactMap { image in
            if let cgImage = image.image.cgImage {
                return (cgImage, CGImagePropertyOrientation(image.image.imageOrientation))
            }
            return nil
        }
        
        let results = await read(images: cgImages)
        
        var allResults: [[ObservedType]] = []
        
        for result in results {
            let observedResults = examine(results: result)
            allResults.append(observedResults)
            
        }
        
        return allResults
    }
}

extension ImageDataReader {
    private func examine(results: [VisionResult]) -> [ObservedType] {
        var observedResults: [ObservedType] = []
        for result in results {
            if let values = examine(result: result) {
                observedResults.append(contentsOf: values)
            }
        }
        
        return observedResults
    }
    
    private func examine(result: VisionResult) -> [ObservedType]? {
        switch result {
        case .detectBarcodes(_, let observations):
            return examine(barcodes: observations)
            
        case .recognizeText(_, let observations):
            return examine(text: observations)
            
        case .recognizeDocuments(_, let observations):
            var observedTypes: [ObservedType] = []
            
            for observation in observations {
                let paragraphs = observation.document.paragraphs
                if let observed = examine(paragraphs: paragraphs) {
                    observedTypes.append(contentsOf: observed)
                }
                
            }
            return observedTypes
        default: return nil
        }
    }
    
    private func examine(barcodes: [BarcodeObservation]) -> [ObservedType]? {
        if barcodes.isEmpty { return nil }
        
        let values = barcodes
            .sorted(by: { $0.confidence > $1.confidence })
            .compactMap { barcode in
                if let value = barcode.payloadString {
                    return ObservedType.barcode(value: value, symbology: barcode.symbology)
                }
                return nil
            }

        return values
    }
    
    private func examine(paragraphs: [DocumentObservation.Container.Text]) -> [ObservedType]? {
        if paragraphs.isEmpty { return nil }
        let wholeParagraph = paragraphs.map(\.transcript)
        return [ObservedType.paragraph(value: wholeParagraph)]
        
    }
    
    private func examine(text observations: [RecognizedTextObservation]) -> [ObservedType]? {
        if observations.isEmpty { return nil }
        let observedTypes = observations.sorted {
            $0.confidence > $1.confidence
        }
        .compactMap { observation in
            observation.topCandidates(1).first
        }
        .map { text in
            ObservedType.text(value: text.string)
        }
        
        return observedTypes
    }
}

extension ImageDataReader {
    private func examine(lists: [DocumentObservation.Container.List]) {
        if lists.isEmpty { return }
        for list in lists {
            for item in list.items {
                examine(item: item)
            }
        }
    }
    
    private func examine(tables: [DocumentObservation.Container.Table]) {
        if tables.isEmpty { return }
        
        for table in tables {
            examine(cellGroups: table.rows)
            examine(cellGroups: table.columns)
        }
    }
    
    private func examine(cellGroups: [[DocumentObservation.Container.Table.Cell]]) {
        if cellGroups.isEmpty { return }
        
        for cells in cellGroups {
            if cells.isEmpty { continue }
            
            for cell in cells {
                _ = examine(barcodes: cell.content.barcodes)
                examine(lists: cell.content.lists)
                examine(tables: cell.content.tables)
            }
        }
    }
    
    private func examine(item: DocumentObservation.Container.List.Item) {
        _ = examine(barcodes: item.content.barcodes)
        _ = examine(paragraphs: item.content.paragraphs)
        examine(text: item.content.text)
        
        if let title = item.content.title {
            examine(text: title)
        }
    }
    
    private func examine(text: DocumentObservation.Container.Text) {}
}

extension ImageDataReader {
    
    private func read(images: [(CGImage, CGImagePropertyOrientation?)]) async -> [[VisionResult]] {
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
        
        return results.compactMap(\.self)
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
        
        let docRequest = RecognizeDocumentsRequest()
        
        
        var textRequest = RecognizeTextRequest()
        textRequest.recognitionLevel = .accurate
        textRequest.usesLanguageCorrection = true
        textRequest.automaticallyDetectsLanguage = true
        
        
        let handler = ImageRequestHandler(image, orientation: orientation)
        
        let requests: [any ImageProcessingRequest] = [barcodeRequest, docRequest]
        let responses = handler.performAll(requests)
        
        var results: [VisionResult] = []
        for await response in responses {
            results.append(response)
        }
        
        return results
    }
}
