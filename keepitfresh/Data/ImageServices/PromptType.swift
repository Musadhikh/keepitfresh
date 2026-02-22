//
//
//  PromptType.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: PromptType
//
    
import Foundation
import FoundationModels

enum PromptType {
    case inventory([ExtractedType])
    
    func prompt() -> Prompt {
        switch self {
        case .inventory(let input):
            return Prompt {
                "Generate product details from the provided input."
                input
            }
        }
    }
}


extension ExtractedType: PromptRepresentable {
    var promptRepresentation: Prompt {
        switch self {
        case .barcode(let value, _):
            value.promptRepresentation
        case .paragraph(let value):
            value.promptRepresentation
        }
    }
}
