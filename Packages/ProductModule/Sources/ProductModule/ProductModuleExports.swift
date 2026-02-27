//
//  ProductModuleExports.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Provides stable facade exports so consumers only import ProductModule.
//

import Foundation
import ProductApplication
import ProductDomain

// MARK: Application Exports

public typealias ProductModuleServicing = ProductApplication.ProductModuleServicing
public typealias DefaultProductModuleService = ProductApplication.DefaultProductModuleService
public typealias ProductModuleError = ProductApplication.ProductModuleError
public typealias ProductSyncStrategy = ProductApplication.ProductSyncStrategy
public typealias ProductReadPolicy = ProductApplication.ProductReadPolicy
public typealias ProductWritePolicy = ProductApplication.ProductWritePolicy
public typealias ProductConflictPolicy = ProductApplication.ProductConflictPolicy
public typealias AddProductsResult = ProductApplication.AddProductsResult
public typealias UpdateProductsResult = ProductApplication.UpdateProductsResult
public typealias SyncPendingResult = ProductApplication.SyncPendingResult

// MARK: Domain Exports

public typealias Product = ProductDomain.Product
public typealias Barcode = ProductDomain.Barcode
public typealias ProductCategory = ProductDomain.ProductCategory
public typealias MainCategory = ProductDomain.MainCategory
public typealias ProductDetails = ProductDomain.ProductDetails
public typealias FoodDetails = ProductDomain.FoodDetails
public typealias HouseholdDetails = ProductDomain.HouseholdDetails
public typealias PersonalCareDetails = ProductDomain.PersonalCareDetails
public typealias UnknownDetails = ProductDomain.UnknownDetails
public typealias NutritionFacts = ProductDomain.NutritionFacts
public typealias ProductPackaging = ProductDomain.ProductPackaging
public typealias ProductImage = ProductDomain.ProductImage
public typealias ProductExtractionMetadata = ProductDomain.ProductExtractionMetadata
public typealias ProductQualitySignals = ProductDomain.ProductQualitySignals
public typealias ProductCompliance = ProductDomain.ProductCompliance
public typealias ProductSource = ProductDomain.ProductSource
public typealias ProductStatus = ProductDomain.ProductStatus
public typealias ProductQuery = ProductDomain.ProductQuery
public typealias PageRequest = ProductDomain.PageRequest
public typealias PageCursor = ProductDomain.PageCursor
public typealias ProductPage = ProductDomain.ProductPage
public typealias ProductSort = ProductDomain.ProductSort
public typealias SortOrder = ProductDomain.SortOrder
public typealias ProductFilter = ProductDomain.ProductFilter
public typealias ProductLookup = ProductDomain.ProductLookup
public typealias ProductSyncState = ProductDomain.ProductSyncState
public typealias ProductSyncMetadata = ProductDomain.ProductSyncMetadata
public typealias ProductLocalStore = ProductDomain.ProductLocalStore
public typealias ProductRemoteGateway = ProductDomain.ProductRemoteGateway
public typealias ProductSyncStateStore = ProductDomain.ProductSyncStateStore
public typealias ConnectivityProviding = ProductDomain.ConnectivityProviding
public typealias ClockProviding = ProductDomain.ClockProviding
public typealias SystemClock = ProductDomain.SystemClock
public typealias AssumeOnlineConnectivityProvider = ProductDomain.AssumeOnlineConnectivityProvider

public enum ProductIdentity {
    public static func normalizeBarcode(_ rawValue: String?) -> String? {
        ProductDomain.ProductIdentity.normalizeBarcode(rawValue)
    }

    public static func normalizedProductID(from productID: String) -> String {
        ProductDomain.ProductIdentity.normalizedProductID(from: productID)
    }
}

// MARK: - Namespaced Exports

public enum ProductModuleTypes {
    public typealias Product = ProductDomain.Product
    public typealias Barcode = ProductDomain.Barcode
    public typealias ProductCategory = ProductDomain.ProductCategory
    public typealias MainCategory = ProductDomain.MainCategory
    public typealias ProductDetails = ProductDomain.ProductDetails
    public typealias FoodDetails = ProductDomain.FoodDetails
    public typealias HouseholdDetails = ProductDomain.HouseholdDetails
    public typealias PersonalCareDetails = ProductDomain.PersonalCareDetails
    public typealias UnknownDetails = ProductDomain.UnknownDetails
    public typealias NutritionFacts = ProductDomain.NutritionFacts
    public typealias ProductPackaging = ProductDomain.ProductPackaging
    public typealias ProductImage = ProductDomain.ProductImage
    public typealias ProductExtractionMetadata = ProductDomain.ProductExtractionMetadata
    public typealias ProductQualitySignals = ProductDomain.ProductQualitySignals
    public typealias ProductCompliance = ProductDomain.ProductCompliance
    public typealias ProductSource = ProductDomain.ProductSource
    public typealias ProductStatus = ProductDomain.ProductStatus
    public typealias ProductQuery = ProductDomain.ProductQuery
    public typealias PageRequest = ProductDomain.PageRequest
    public typealias PageCursor = ProductDomain.PageCursor
    public typealias ProductPage = ProductDomain.ProductPage
    public typealias ProductSort = ProductDomain.ProductSort
    public typealias SortOrder = ProductDomain.SortOrder
    public typealias ProductFilter = ProductDomain.ProductFilter
    public typealias ProductLookup = ProductDomain.ProductLookup
    public typealias ProductSyncState = ProductDomain.ProductSyncState
    public typealias ProductSyncMetadata = ProductDomain.ProductSyncMetadata
}
