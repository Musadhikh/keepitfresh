//
//  AddProductFlowDraftMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: Maps extraction/search UI inputs into Add Product domain drafts and catalog records.
//

import Foundation
import ProductModule

enum AddProductFlowDraftMapper {
    static func makeDraft(from extraction: AddProductExtractionReviewDraft) -> ProductDraft {
        let barcode = extraction.normalizedBarcode.map { Barcode(value: $0, symbology: .unknown) }
        let category = ProductCategory(main: extraction.category, subCategory: extraction.trimmedSubCategory)

        var dates: [ProductDraftDateEntry] = [
            ProductDraftDateEntry(kind: .expiry, value: extraction.expiryDate, inputMode: .manualCalendar)
        ]
        if extraction.includeManufacturedDate {
            dates.append(.init(kind: .manufactured, value: extraction.manufacturedDate, inputMode: .manualCalendar))
        }

        return ProductDraft(
            id: UUID().uuidString,
            source: .aiExtraction,
            isEditable: true,
            barcode: barcode,
            catalog: nil,
            title: extraction.trimmedProductName,
            brand: extraction.trimmedBrand,
            description: nil,
            categories: [category.main.rawValue],
            category: category,
            productDetail: nil,
            size: nil,
            images: [],
            quantity: 1,
            numberOfItems: 1,
            unit: "Count",
            dateEntries: dates,
            notes: nil,
            lockedFields: [],
            fieldConfidences: [:]
        )
    }

    static func makeCatalogItem(from product: ProductModuleTypes.Product) -> ProductCatalogItem {
        let barcodeValue = product.barcode?.value.trimmingCharacters(in: .whitespacesAndNewlines)
        let resolvedBarcodeValue = barcodeValue?.isEmpty == false ? barcodeValue! : product.productId
        let barcode = Barcode(value: resolvedBarcodeValue, symbology: .unknown)

        let categories: [String] = {
            guard let category = product.category else { return [] }
            if let sub = category.sub, sub.isEmpty == false {
                return [category.main.rawValue, sub]
            }
            return [category.main.rawValue]
        }()

        let imageURLs: [URL] = product.images.compactMap { image in
            guard let value = image.urlString else { return nil }
            return URL(string: value)
        }

        return ProductCatalogItem(
            id: product.productId,
            barcode: barcode,
            title: product.title,
            brand: product.brand,
            description: product.shortDescription,
            images: imageURLs.isEmpty ? nil : imageURLs,
            categories: categories.isEmpty ? nil : categories,
            size: product.size
        )
    }
}
