//
//  AddProductLookupContext.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: Flow context models describing barcode miss handling and image-capture plan.
//

import Foundation

enum AddProductNotFoundAction: String, Codable, Sendable, Equatable, Hashable, CaseIterable {
    case captureAndAnalyze
    case addManually
}

struct AddProductNotFoundContext: Codable, Sendable, Equatable, Hashable {
    var barcode: Barcode?
    var message: String
    var availableActions: [AddProductNotFoundAction]

    static func barcodeMiss(_ barcode: Barcode?) -> Self {
        Self(
            barcode: barcode,
            message: "No product data found for this barcode.",
            availableActions: [.captureAndAnalyze, .addManually]
        )
    }
}

struct AddProductCapturePlan: Codable, Sendable, Equatable, Hashable {
    var minimumImageCount: Int
    var maximumImageCount: Int

    static var productAnalysisDefault: Self {
        Self(minimumImageCount: 1, maximumImageCount: 6)
    }
}
