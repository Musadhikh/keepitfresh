//
//
//  Playground.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Playground
//
    

import Foundation
import Playgrounds
import FoundationModels

@Generable
struct PlaygroundProductDetails {
    @Guide(description: "Product title or name")
    let title: String?
    
    @Guide(description: "Brand of the product")
    let brand: String?
    
    @Guide(description: "Describe the product briefly")
    let description: String?
    
    @Guide(description: "Barcode/UPC details")
    let barcodeInfo: BarcodeInfo?
    
    @Guide(description: "All date information printed on the product. Keep same date format for all dates in the list. Preferred date format is dd/MM/yyyy")
    let dateInfo: [PlaygroundProductDateInfo]?
    
    @Guide(description: "Net Weight of the product")
    let netWeight: String?
    
    @Guide(description: "Quantity of the product")
    let quantity: Int?
    
    @Guide(description: "Ingredients of the product")
    let ingredients: [String]?

    @Guide(description: "Storage instructions for the product")
    let storageInstructions: String?
}

@Generable
struct PlaygroundProductDateInfo {
    @Guide(description: "Type of Date (Packed, Expiry, etc.) printed on the product")
    let dateType: DateTypeEnum?
    @Guide(description: "Date printed on the product. Always convert to the format: dd/MM/yyyy")
    let date: String?
}


extension ObservedType: PromptRepresentable {
    var promptRepresentation: Prompt {
        switch self {
        case .barcode(let value, _):
            value.promptRepresentation
        case .text(let value):
            value.promptRepresentation
        case .paragraph(let value):
            value.promptRepresentation
        }
    }
}

#Playground {
    func generateData(from data: [ObservedType]) async {
        let instructions =
        """
        You are Inventory Assistant.
        Your job is to extract product details from the provided input (OCR text and barcode results). Keep the values close the given input as possible as you can. Fix broken texts if there is any. 
        Take extra care with dates and provide result as accurate as you can. Make assumptions if necessary.
        You must produce a single structured output that conforms to the target schema.
        """
        
        let session = LanguageModelSession(instructions: instructions)
        
        
        let prompt = Prompt {
            "Generate product details from the provided input."
            data
        }
        do {
//            let content = try await session.respond(to: prompt, generating: PlaygroundProductDetails.self)
            
            let stream = session.streamResponse(to: prompt, generating: PlaygroundProductDetails.self)
            
            for try await snapShot in stream {
                _ = snapShot
            }
        } catch {
            print("error: \(error)")
        }
        
    }
    
    
    let data =  [
        [ObservedType.paragraph(value: ["RICH TASTE & AROMA", "Lipton", "YELLOW LABEL", "INTERNATIONAL", "LEND", "50"]),
                  ObservedType.paragraph(value: ["RICH TASTE & AROMA", "Lipton", "YELLOW LABEL", "INTERNATIONAL", "LEND", "50"])],
                 [ObservedType.paragraph(value: ["Imported by:", "MALAYSIA: ekaterra Malaysia Son. Bnd.", "Uhit 6.01, Level 6, Mercu 2, No 3, Jalan Bangsar,", "Kampung Haji Abdullah Hukum, 59200\nKuala Lumpur, Malaysia Malaysia Consumer Careline:", "mmsa sabpaa", "Jistnbuted Dy", "BRUNEI: M.S. Makmur Trading Compeny Unit No. 9, 10, 11 & 12, Biock A, Kg Salambigar Light Industry, Lot 60363, JIn Muara, Berakas B,", "Brunei Muara, BC1515, Brunei Darussalam", "Distributed by:", "SINGAPORE: Lim Siang Huat Pte Ltd", "6 Fishery Port Road #02M, Singapore 619747", "singapore Consumer bareline.", "heilo.singapore@lipton.com", "Imported & Distributed by:", "PHILIPPINES: Manila Taste Curators Ventures, Inc.", "Bay 1, LSMRI Compound Ortigas Avenue", "Extension, Barangay Santo Domingo, Cainta,\nRizal 1900", "+632 86722881 to 84", "+639171448832", "info@mnitaste.com", "Produced by:", "United Arab Emirates by ekaterra Gulf", "FZE, Jebel All Free Zone", "P.O.Bax No. 61272 Dubai", "Country of origin: United Arab Emirates", "Ingredients: 100% black tea", "Store in a cool and dry place.", "SERVING SUGGESTION", "facebook.com/lipton", "Net Weight:", "50 x 2 g bags (100 g)"]),
                  ObservedType.paragraph(value: ["Imported by:", "MALAYSIA: ekaterra Malaysia Son. Bnd.", "Uhit 6.01, Level 6, Mercu 2, No 3, Jalan Bangsar,", "Kampung Haji Abdullah Hukum, 59200\nKuala Lumpur, Malaysia Malaysia Consumer Careline:", "mmsa sabpaa", "Jistnbuted Dy", "BRUNEI: M.S. Makmur Trading Compeny Unit No. 9, 10, 11 & 12, Biock A, Kg Salambigar Light Industry, Lot 60363, JIn Muara, Berakas B,", "Brunei Muara, BC1515, Brunei Darussalam", "Distributed by:", "SINGAPORE: Lim Siang Huat Pte Ltd", "6 Fishery Port Road #02M, Singapore 619747", "singapore Consumer bareline.", "heilo.singapore@lipton.com", "Imported & Distributed by:", "PHILIPPINES: Manila Taste Curators Ventures, Inc.", "Bay 1, LSMRI Compound Ortigas Avenue", "Extension, Barangay Santo Domingo, Cainta,\nRizal 1900", "+632 86722881 to 84", "+639171448832", "info@mnitaste.com", "Produced by:", "United Arab Emirates by ekaterra Gulf", "FZE, Jebel All Free Zone", "P.O.Bax No. 61272 Dubai", "Country of origin: United Arab Emirates", "Ingredients: 100% black tea", "Store in a cool and dry place.", "SERVING SUGGESTION", "facebook.com/lipton", "Net Weight:", "50 x 2 g bags (100 g)"])],
                 [ObservedType.paragraph(value: ["nod Date DOMMITTAL", "02 NOV 2024", "L4307 4 XG05 03:53", "01 NO Y 2026"]),
                  ObservedType.paragraph(value: ["nod Date DOMMITTAL", "02 NOV 2024", "L4307 4 XG05 03:53", "01 NO Y 2026"])],
                 [ObservedType.barcode(value: "8720608629091", symbology: .ean13),
                  ObservedType.paragraph(value: ["TASTE THE SUNSHINE", "...in every cup of Lipton Yellow Label Tea.", "Made with the top tea leaves sourced from plantations around the world, for a rich, natural taste and aroma A sunny sip to awaken you to the people and things that really matter."]),
                  ObservedType.paragraph(value: ["TASTE THE SUNSHINE", "...in every cup of Lipton Yellow Label Tea.", "Made with the top tea leaves sourced from plantations around the world, for a rich, natural taste and aroma A sunny sip to awaken you to the people and things that really matter."])]]
    
    let info = data.flatMap(\.self)
    Task {
        await generateData(from: info)
    }
}
