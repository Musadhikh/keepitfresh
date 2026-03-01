//
//
//  ProductReviewNutritionCard.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewNutritionCard
//
    
import SwiftUI
import ImageDataModule

struct ProductReviewNutritionCard: View {
    let servingSize: String
    let calories: String
    
    let detail: ExtractedFoodDetails.PartiallyGenerated?
    
    private var chipColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 96), spacing: Theme.Spacing.s8)]
    }

    var body: some View {
        ProductReviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: Theme.Spacing.s8),
                    GridItem(.flexible(), spacing: Theme.Spacing.s8)
                ], spacing: Theme.Spacing.s8) {
                    if let servingSize = detail?.servingSize {
                        ProductReviewMetricPill(title: "Serving Size", value: servingSize)
                    }
                    // TODO: for AI Agent. use other info from details to show relevant info
                    ProductReviewMetricPill(title: "Calories", value: calories)
                        
                }

                if let allergens = detail?.allergens {
                    Text("Allergens")
                        .font(Theme.Fonts.body(11, weight: .medium, relativeTo: .caption))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    if allergens.isEmpty {
                        Text("No allergen information available.")
                            .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .subheadline))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    } else {
                        LazyVGrid(columns: chipColumns, alignment: .leading, spacing: Theme.Spacing.s8) {
                            ForEach(allergens, id: \.self) { allergen in
                                ProductReviewTagChip(text: allergen)
                            }
                        }
                    }
                }
            }
        }
    }
}
