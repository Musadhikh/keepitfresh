//
//  File.swift
//  ImageDataModule
//
//  Created by Musadhikh Muhammed on 24/2/26.
//

import Foundation
import FoundationModels

@Generable(description: "When the category cannot be determined")
public struct ExtractedUnknownDetails: Sendable {
    @Guide(description: "Collect all possible data available")
    public var raw: [KeyValueEntry]?
    
    @Guide(description: "Possible category")
    public var category: String?
}

extension ExtractedUnknownDetails.PartiallyGenerated: Sendable {}

@Generable
public struct KeyValueEntry: Sendable, Equatable {
    @Guide(description: "Field Name or Label")
    public var key: String
    
    @Guide(description: "Field value extracted from the label")
    public var value: String
}

extension KeyValueEntry.PartiallyGenerated: Sendable {}
