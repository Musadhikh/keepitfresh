//
//  PromptType.swift
//  keepitfresh
//
//  Created by musadhikh on 23/2/26.
//  Summary: Defines prompt builders for extraction results consumed by FoundationModels.
//

import Foundation
import FoundationModels

public protocol PromptProviding: Sendable {
    func prompt() -> Prompt
}

public enum PromptType: PromptProviding {
    case inventory([ExtractedType])

    public func prompt() -> Prompt {
        switch self {
        case .inventory(let input):
            return Prompt {
                "Generate product details from the provided input."
                input
            }
        }
    }
}
