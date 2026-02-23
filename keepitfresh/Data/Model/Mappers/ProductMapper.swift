//
//  ProductMapper.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Maps LLM extraction output into stable Product domain models.
//

import Foundation
import ImageDataModule

struct ProductMapper {
    func makeProduct(
        id: String,
        from extracted: ExtractedData,
        source: ProductSource
    ) -> Product {
        fatalError("Missing implementation")
    }
}
