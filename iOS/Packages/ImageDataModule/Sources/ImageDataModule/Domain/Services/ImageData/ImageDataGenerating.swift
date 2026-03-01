//
//  ImageDataGenerating.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Defines an abstraction for schema-constrained data generation from prompts.
//

import Foundation
import FoundationModels

public protocol ImageDataGenerating: Sendable {
    func generateData<T: Sendable & Generable>(
        from prompt: any PromptProviding,
        type: T.Type
    ) -> AsyncThrowingStream<T.PartiallyGenerated?, Error> where T.PartiallyGenerated: Sendable
}
