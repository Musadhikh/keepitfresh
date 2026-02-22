//
//
//  Instruction.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Instruction <#brief summary#>
//
    


enum Instruction {
    case inventoryAssistant

    func instructions() -> String {
        switch self {
        case .inventoryAssistant:
            return """
        You are Inventory Assistant.
        Your job is to extract product details from the provided input (OCR text and barcode results). Keep the values close the given input as possible as you can. Fix broken texts if there is any. 
        Take extra care with dates and provide result as accurate as you can. Make assumptions if necessary.
        You must produce a single structured output that conforms to the target schema.
        """
        }
    }
}