//
//
//  AIDataGenerating.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: AIDataGenerating
//
    

import Foundation
import FoundationModels

protocol AIDataGenerating: Sendable {
    func generateData<T: Sendable & Generable>(from prompt: PromptType, type: T.Type) -> AsyncThrowingStream<T.PartiallyGenerated?, Error> where T.PartiallyGenerated: Sendable
}
