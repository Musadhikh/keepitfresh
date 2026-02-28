//
//  ProductRef.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Stores product identity reference and optional snapshot for inventory rows.
//

import Foundation

public struct ProductRef: Sendable, Codable, Equatable, Hashable {
    public struct Snapshot: Sendable, Codable, Equatable, Hashable {
        public var title: String?
        public var imageURL: URL?
        public var brand: String?

        public init(title: String? = nil, imageURL: URL? = nil, brand: String? = nil) {
            self.title = title
            self.imageURL = imageURL
            self.brand = brand
        }
    }

    public var productId: String
    public var snapshot: Snapshot?

    public init(productId: String, snapshot: Snapshot? = nil) {
        self.productId = productId
        self.snapshot = snapshot
    }
}

