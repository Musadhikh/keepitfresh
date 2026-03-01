//
//  ProductQuery.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Defines pagination, sorting, filtering, and lookup contracts for product retrieval.
//

import Foundation

public struct ProductQuery: Sendable, Codable, Equatable {
    public var page: PageRequest
    public var sort: ProductSort
    public var filters: [ProductFilter]

    public init(
        page: PageRequest = .init(),
        sort: ProductSort = .updatedAt(order: .descending),
        filters: [ProductFilter] = []
    ) {
        self.page = page
        self.sort = sort
        self.filters = filters
    }
}

public struct PageRequest: Sendable, Codable, Equatable {
    public var limit: Int
    public var cursor: PageCursor?

    public init(limit: Int = 25, cursor: PageCursor? = nil) {
        self.limit = limit
        self.cursor = cursor
    }
}

public struct PageCursor: Sendable, Codable, Equatable {
    public var value: String

    public init(value: String) {
        self.value = value
    }
}

public struct ProductPage: Sendable, Codable, Equatable {
    public var items: [Product]
    public var nextCursor: PageCursor?
    public var totalCount: Int?

    public init(items: [Product], nextCursor: PageCursor? = nil, totalCount: Int? = nil) {
        self.items = items
        self.nextCursor = nextCursor
        self.totalCount = totalCount
    }
}

public enum ProductSort: Sendable, Codable, Equatable {
    case updatedAt(order: SortOrder)
    case title(order: SortOrder)
    case brand(order: SortOrder)
    case createdAt(order: SortOrder)
}

public enum SortOrder: String, Sendable, Codable, Equatable {
    case ascending
    case descending
}

public enum ProductFilter: Sendable, Codable, Equatable {
    case status(ProductStatus)
    case category(MainCategory)
    case brand(String)
    case hasBarcode(Bool)
    case textSearch(String)
    case source(ProductSource)
}

public enum ProductLookup: Sendable, Codable, Equatable {
    case productId(String)
    case barcode(String)
}
