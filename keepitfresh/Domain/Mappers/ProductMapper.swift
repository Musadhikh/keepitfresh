//
//  ProductMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Maps LLM extraction output into stable Product domain models.
//

import Foundation

struct ProductMapper {
    func makeProduct(
        id: String,
        from base: ProductBaseExtraction,
        classification: ProductClassificationExtraction,
        rawTextRefs: [String],
        source: ProductSource
    ) -> Product {
        let now = Date()
        return Product(
            id: id,
            title: normalized(base.title),
            barcode: mappedBarcode(from: base.barcode),
            brand: normalized(base.brand),
            shortDescription: normalized(base.shortDescription),
            images: mappedImages(from: base.images),
            categories: mappedCategories(base: base, classification: classification),
            createdAt: now,
            updatedAt: now,
            lastScannedAt: source == .scan ? now : nil,
            source: source,
            confidence: normalizedConfidence(base.confidence ?? classification.confidence),
            rawTextRefs: sanitized(rawTextRefs)
        )
    }
}

private extension ProductMapper {
    func mappedBarcode(from extraction: BarcodeExtraction?) -> Barcode? {
        guard
            let extraction,
            let value = normalized(extraction.value),
            value.isEmpty == false
        else {
            return nil
        }

        return Barcode(
            value: value,
            symbology: mappedSymbology(extraction.symbology)
        )
    }

    func mappedSymbology(_ symbology: BarcodeSymbologyExtraction?) -> Barcode.Symbology {
        switch symbology ?? .unknown {
        case .ean13:
            return .ean13
        case .ean8:
            return .ean8
        case .upca:
            return .upcA
        case .upce:
            return .upcE
        case .qr:
            return .qr
        case .code128:
            return .code128
        case .unknown:
            return .unknown
        }
    }

    func mappedCategories(
        base: ProductBaseExtraction,
        classification: ProductClassificationExtraction
    ) -> [ProductCategory] {
        let category = classification.category ?? base.category
        guard let category else { return [] }

        return [
            ProductCategory(
                main: mappedMainCategory(category),
                sub: normalized(classification.subCategory ?? base.subCategory)
            )
        ]
    }

    func mappedMainCategory(_ category: MainCategoryExtraction) -> MainCategory {
        switch category {
        case .food:
            return .food
        case .beverage:
            return .beverage
        case .household:
            return .household
        case .personalCare:
            return .personalCare
        case .medicine:
            return .medicine
        case .electronics:
            return .electronics
        case .pet:
            return .pet
        case .other, .unknown:
            return .other
        }
    }

    func mappedImages(from imageURLs: [String]?) -> [ProductImage] {
        guard let imageURLs else { return [] }
        var seen: Set<String> = []
        var result: [ProductImage] = []
        for url in imageURLs {
            guard let value = normalized(url), seen.contains(value) == false else { continue }
            seen.insert(value)
            result.append(ProductImage(urlString: value, localAssetId: nil, kind: .other))
        }
        return result
    }

    func normalized(_ value: String?) -> String? {
        guard let value else { return nil }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    func normalizedConfidence(_ value: Double?) -> Double? {
        guard let value else { return nil }
        return min(max(value, 0.0), 1.0)
    }

    func sanitized(_ refs: [String]) -> [String] {
        var seen: Set<String> = []
        var result: [String] = []
        for ref in refs {
            guard let normalizedRef = normalized(ref), seen.contains(normalizedRef) == false else {
                continue
            }
            seen.insert(normalizedRef)
            result.append(normalizedRef)
        }
        return result
    }
}
