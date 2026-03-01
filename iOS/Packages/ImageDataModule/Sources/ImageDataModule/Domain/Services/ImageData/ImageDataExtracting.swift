//
//  ImageDataExtracting.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Defines an abstraction for OCR/barcode extraction from captured images.
//

import Foundation

public protocol ImageDataExtracting: Sendable {
    func extract(from images: [any ImageData]) async throws -> [ExtractedType]
}
