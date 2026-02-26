//
//
//  ProductReviewHouseholdCard.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewHouseholdCard
//
    
import SwiftUI

struct ProductReviewHouseholdCard: View {
    let packagingMaterial: String
    let storageInstructions: String

    var body: some View {
        ProductReviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
                ProductReviewMetricPill(title: "Packaging Material", value: packagingMaterial)
                ProductReviewMetricPill(title: "Storage Instructions", value: storageInstructions)
            }
        }
    }
}
