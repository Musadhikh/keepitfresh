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
import UIKit

@Observable
@MainActor
class ProductOverViewModel {
    private let capturedImages: [CameraCapturedImage]
    let imageDataReader: ImageDataReader = ImageDataReader()
    let imageDataGenerator: ImageDataGenerator = ImageDataGenerator(model: .init(useCase: .contentTagging))
    
    private(set) var product: Product.PartiallyGenerated?
    private(set) var isGenerating = false
    private(set) var errorMessage: String?
    var selectedImageIndex = 0
    
    init(capturedImages: [CameraCapturedImage]) {
        self.capturedImages = capturedImages
    }
    
    func start() async {
        isGenerating = true
        errorMessage = nil

        do {
            let imageData =  await imageDataReader.readData(images: capturedImages)
            
            logger.debug("image data: \(imageData)")
            
            let generator = imageDataGenerator.generateModel(from: imageData)
            for try await generated in  generator {
                product = generated
            }
            isGenerating = false
        } catch {
            isGenerating = false
            errorMessage = error.localizedDescription
            logger.error("generating model failed: \(error)")
        }
    }
}

extension ProductOverViewModel {
    var imageCount: Int {
        capturedImages.count
    }

    var displayImages: [UIImage] {
        capturedImages.map(\.image)
    }

    var titleText: String {
        product?.title ?? "Generating product details..."
    }

    var statusText: String {
        if let errorMessage {
            return errorMessage
        }
        return isGenerating ? "Generating product details..." : "Product details generated"
    }

    var barcodeText: String {
        product?.barcode?.barcode ?? "Not detected"
    }

    var categoryTitle: String {
        guard let category = product?.category else {
            return "Unknown"
        }
        return Self.humanize(rawValue: category.rawValue)
    }

    var categoryConfidenceText: String {
        let filledFieldCount = [
            product?.title,
            product?.barcode?.barcode,
            product?.brand,
            product?.category?.rawValue,
            product?.dateInfo?.isEmpty == false ? "date" : nil
        ]
            .compactMap(\.self)
            .count
        let confidenceValue = Int((Double(filledFieldCount) / 5.0 * 100.0).rounded())
        return "\(confidenceValue)%"
    }

    var packedDateText: String {
        let preferredKinds: Set<DateKind> = [.packed_on, .manufactured]
        logger.debug("date info: \(String(describing: self.product?.dateInfo))")
        if let match = product?.dateInfo?.first(where: { info in
            guard let kind = info.kind else {
                return false
            }
            return preferredKinds.contains(kind)
        }) {
            return formatted(dateInfo: match)
        }
        return "Not found"
    }

    var expiryDateText: String {
        let preferredKinds: Set<DateKind> = [.expiry, .best_before, .use_by]
        if let match = product?.dateInfo?.first(where: { info in
            guard let kind = info.kind else {
                return false
            }
            return preferredKinds.contains(kind)
        }) {
            return formatted(dateInfo: match)
        }
        return "Not found"
    }

    var detailRows: [String] {
        [
            "Brand: \(product?.brand ?? "Not detected")",
            "Source: Image + barcode extraction",
            "Captured Images: \(imageCount)"
        ]
    }

    var hasError: Bool {
        errorMessage != nil
    }
}

private extension ProductOverViewModel {
    static func humanize(rawValue: String) -> String {
        let replacedUnderscores = rawValue.replacing("_", with: " ")
        var words: [String] = []
        var currentWord = ""

        for character in replacedUnderscores {
            let isUppercase = character.isUppercase
            if isUppercase && !currentWord.isEmpty {
                words.append(currentWord)
                currentWord = String(character)
            } else {
                currentWord.append(character)
            }
        }

        if !currentWord.isEmpty {
            words.append(currentWord)
        }

        return words
            .map { $0.capitalized }
            .joined(separator: " ")
    }

    func formatted(dateInfo: DateInfo.PartiallyGenerated?) -> String {
        guard let dateInfo else {
            return "Not found"
        }

        if let isoDate = dateInfo.isoDate, let parsedDate = Self.isoDateFormatter.date(from: isoDate) {
            return Self.displayDateFormatter.string(from: parsedDate)
        }

        return dateInfo.rawText ?? "Not found"
    }

    static let isoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
