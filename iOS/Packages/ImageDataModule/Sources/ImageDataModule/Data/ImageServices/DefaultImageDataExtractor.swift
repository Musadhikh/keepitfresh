//
//  ImageDataExtractorService.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Extracts OCR paragraphs and barcode data from captured images using Vision.
//

import Foundation
import Vision

public actor DefaultImageDataExtractor: ImageDataExtracting {
    private let maxConcurrentRequests: Int

    public init(maxConcurrentRequests: Int) {
        self.maxConcurrentRequests = maxConcurrentRequests
    }

    public func extract(from images: [any ImageData]) async throws -> [ExtractedType] {
        let cgImages = cgImagesAndProperties(from: images)
        let visionResults = await read(images: cgImages)

        var extractedResults = [ExtractedType]()
        for results in visionResults {
            let extracted = extract(results: results)
            extractedResults.append(contentsOf: extracted)
        }

        return extractedResults
    }
}

private extension DefaultImageDataExtractor {
    func extract(results: [VisionResult]) -> [ExtractedType] {
        var extractedResults: [ExtractedType] = []
        for result in results {
            if let values = extract(result: result) {
                extractedResults.append(contentsOf: values)
            }
        }

        return extractedResults
    }

    func extract(result: VisionResult) -> [ExtractedType]? {
        switch result {
        case .detectBarcodes(_, let observations):
            return extract(barcodes: observations)

        case .recognizeDocuments(_, let observations):
            var extractedTypes: [ExtractedType] = []

            for observation in observations {
                let paragraphs = observation.document.paragraphs
                if let extracted = extract(paragraphs: paragraphs) {
                    extractedTypes.append(extracted)
                }
            }
            return extractedTypes

        default:
            return nil
        }
    }

    func extract(barcodes: [BarcodeObservation]) -> [ExtractedType]? {
        if barcodes.isEmpty {
            return nil
        }

        let values = barcodes
            .sorted(by: { $0.confidence > $1.confidence })
            .compactMap { barcode in
                if let value = barcode.payloadString {
                    return ExtractedType.barcode(value: value, symbology: barcode.symbology)
                }
                return nil
            }

        return values
    }

    func extract(paragraphs: [DocumentObservation.Container.Text]) -> ExtractedType? {
        if paragraphs.isEmpty {
            return nil
        }

        let wholeParagraph = paragraphs.map(\.transcript)
        return .paragraph(value: wholeParagraph)
    }
}

private extension DefaultImageDataExtractor {
    func cgImagesAndProperties(from images: [any ImageData]) -> [(CGImage, CGImagePropertyOrientation)] {
        images.map { image in
            (image.cgImage, image.orientation)
        }
    }

    func read(images: [(CGImage, CGImagePropertyOrientation?)]) async -> [[VisionResult]] {
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

    func addTask(
        group: inout TaskGroup<(Int, [VisionResult])>,
        index: Int,
        image: (CGImage, CGImagePropertyOrientation?)
    ) {
        group.addTask {
            let result = await self.read(image: image.0, orientation: image.1)
            return (index, result)
        }
    }

    func read(image: CGImage, orientation: CGImagePropertyOrientation?) async -> [VisionResult] {
        let barcodeRequest = DetectBarcodesRequest()
        let docRequest = RecognizeDocumentsRequest()

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
