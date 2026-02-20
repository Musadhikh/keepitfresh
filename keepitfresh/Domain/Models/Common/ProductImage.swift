//
//  ProductImage.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Product image references for remote/local assets.
//

import Foundation

struct ProductImage: Codable, Equatable, Sendable {
    var urlString: String?
    var localAssetId: String?
    var kind: Kind

    init(urlString: String? = nil, localAssetId: String? = nil, kind: Kind = .other) {
        self.urlString = urlString
        self.localAssetId = localAssetId
        self.kind = kind
    }
}

extension ProductImage {
    enum Kind: String, Codable, CaseIterable, Sendable {
        case front
        case back
        case label
        case nutrition
        case ingredients
        case other
    }
}
