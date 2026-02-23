//
//  ProductDetailsMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Maps category-specific extraction output into ProductDetails domain models.
//

import Foundation
import ImageDataModule

struct ProductDetailsMapper {
    func makeDetails(
        productId: String,
        classification: ExtractedProductCategory,
    ) -> ProductDetails? {
        fatalError("Missing implementation")
    }
}
