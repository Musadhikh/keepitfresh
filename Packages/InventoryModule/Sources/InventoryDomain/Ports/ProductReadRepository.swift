//
//  ProductReadRepository.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Defines read-only product lookup dependency used by inventory composition logic.
//

import Foundation

public struct ProductReadModel: Sendable, Codable, Equatable, Hashable {
    public var productId: String
    public var title: String?
    public var brand: String?
    public var imageURL: URL?

    public init(productId: String, title: String? = nil, brand: String? = nil, imageURL: URL? = nil) {
        self.productId = productId
        self.title = title
        self.brand = brand
        self.imageURL = imageURL
    }
}

public protocol ProductReadRepository: Sendable {
    func getProduct(by productId: String) async throws -> ProductReadModel?
    func getProducts(by productIDs: [String]) async throws -> [ProductReadModel]
}
