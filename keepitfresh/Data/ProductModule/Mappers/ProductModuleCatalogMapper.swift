//
//  ProductModuleCatalogMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Maps between app catalog models and ProductModule product models for adapter interoperability.
//

import Foundation
import ProductModule

typealias PMMapperBarcode = ProductModuleTypes.Barcode
typealias PMMapperMainCategory = ProductModuleTypes.MainCategory
typealias PMMapperProduct = ProductModuleTypes.Product
typealias PMMapperProductCategory = ProductModuleTypes.ProductCategory
typealias PMMapperProductImage = ProductModuleTypes.ProductImage

extension ProductCatalogItem {
    func asProductModuleProduct() -> PMMapperProduct {
        let normalizedBarcodeValue = ProductIdentity.normalizeBarcode(barcode.value)
            ?? ProductIdentity.normalizedProductID(from: barcode.value)

        let moduleBarcode = PMMapperBarcode(
            value: normalizedBarcodeValue,
            symbology: barcode.symbology.asProductModuleSymbology()
        )

        return PMMapperProduct(
            productId: normalizedBarcodeValue,
            barcode: moduleBarcode,
            title: title,
            brand: brand,
            shortDescription: description,
            category: categories.asProductModuleCategory(),
            size: size,
            images: images.asProductModuleImages(),
            source: .barcodeLookup,
            status: .active
        )
    }
}

extension PMMapperProduct {
    func asCatalogItemForRepository() -> ProductCatalogItem? {
        guard let barcode else { return nil }

        let normalizedBarcode = ProductIdentity.normalizeBarcode(barcode.value)
            ?? ProductIdentity.normalizedProductID(from: productId)
        guard normalizedBarcode.isEmpty == false else {
            return nil
        }

        let catalogBarcode = Barcode(
            value: normalizedBarcode,
            symbology: barcode.symbology.asAppSymbology()
        )

        let mappedImages = images
            .compactMap { image -> URL? in
                guard let urlString = image.urlString else { return nil }
                return URL(string: urlString)
            }
        let mappedCategories = category?.asRepositoryCategories()

        return ProductCatalogItem(
            id: productId,
            barcode: catalogBarcode,
            title: title,
            brand: brand,
            description: shortDescription,
            images: mappedImages.isEmpty ? nil : mappedImages,
            categories: mappedCategories,
            size: size
        )
    }
}

private extension Barcode.Symbology {
    func asProductModuleSymbology() -> PMMapperBarcode.Symbology {
        PMMapperBarcode.Symbology(rawValue: rawValue) ?? .unknown
    }
}

private extension PMMapperBarcode.Symbology {
    func asAppSymbology() -> Barcode.Symbology {
        Barcode.Symbology(rawValue: rawValue) ?? .unknown
    }
}

private extension Array where Element == URL {
    func asProductModuleImages() -> [PMMapperProductImage] {
        map { url in
            PMMapperProductImage(urlString: url.absoluteString, kind: .other)
        }
    }
}

private extension Optional where Wrapped == [URL] {
    func asProductModuleImages() -> [PMMapperProductImage] {
        self?.asProductModuleImages() ?? []
    }
}

private extension PMMapperProductCategory {
    func asRepositoryCategories() -> [String] {
        var categories: [String] = [main.rawValue]
        if let sub, sub.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            categories.append(sub)
        }
        return categories
    }
}

private extension Optional where Wrapped == [String] {
    func asProductModuleCategory() -> PMMapperProductCategory? {
        guard
            let rawValues = self,
            rawValues.isEmpty == false
        else {
            return nil
        }

        let normalizedValues = rawValues
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
            .filter { $0.isEmpty == false }

        guard normalizedValues.isEmpty == false else {
            return nil
        }

        if let mainCategory = PMMapperMainCategory(rawValue: normalizedValues[0]) {
            let subCategory = normalizedValues.dropFirst().first
            return PMMapperProductCategory(main: mainCategory, sub: subCategory)
        }

        return PMMapperProductCategory(main: .other, sub: normalizedValues[0])
    }
}
