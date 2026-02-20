//
//  FirestorePaths.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Path helpers for product base and category-details documents.
//

import Foundation

enum FirestorePaths {
    static let productsCollection = "products"
    static let detailsCollection = "details"

    static func productDoc(_ id: String) -> String {
        "\(productsCollection)/\(id)"
    }

    static func detailsDoc(productId: String, category: MainCategory) -> String {
        "\(productDoc(productId))/\(detailsCollection)/\(category.rawValue)"
    }
}
