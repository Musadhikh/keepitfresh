//
//  ImageDataModuleTests.swift
//  ImageDataModuleTests
//
//  Created by musadhikh on 23/2/26.
//  Summary: Verifies basic package API behavior for instruction and model descriptions.
//

import XCTest
@testable import ImageDataModule

final class ImageDataModuleTests: XCTestCase {
    func test_modelStringConvertible_describesBarcodeCase() {
        let value = ExtractedType.barcode(value: "12345", symbology: .ean13)

        XCTAssertTrue(value.description.contains("barcode"))
        XCTAssertTrue(value.description.contains("12345"))
    }

    func test_extractedData_initializer_assignsValues() {
        let data = ExtractedData(
            title: "Milk",
            brand: "KIF",
            description: "Fresh milk",
            barcodeInfo: BarcodeInfo(barcode: "111", barcodeType: "ean13"),
            dateInfo: [ExtractedDateInfo(dateType: .expiry, date: "23/02/2026")],
            category: ExtractedProductCategory(mainCategory: .beverage, subCategory: "Dairy"),
            storageInstructions: "Keep refrigerated",
            productDetails: .beverage(ExtractedFoodDetails(ingredients: ["Milk"], quantity: "1L", numberOfItems: "1"))
        )

        XCTAssertEqual(data.title, "Milk")
        XCTAssertEqual(data.brand, "KIF")
        XCTAssertEqual(data.barcodeInfo?.barcode, "111")
    }
}
