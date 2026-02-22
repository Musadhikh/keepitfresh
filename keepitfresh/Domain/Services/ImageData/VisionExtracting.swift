//
//  VisionExtracting.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Vision/LLM extraction abstraction for image fallback path.
//

import Foundation

protocol VisionExtracting: Sendable {
    func extract(from images: [ImagesCaptured]) async throws -> [ExtractedType]
}
