//
//
//  ProductReviewInfoTile.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewInfoTile
//
    
import SwiftUI

struct ProductReviewInfoTile: View {
    let icon: Theme.Icon
    let title: String
    let value: String

    var body: some View {
        ProductReviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                Image(icon: icon)
                    .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.accent)

                Text(title.uppercased())
                    .font(Theme.Fonts.body(11, weight: .medium, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.textSecondary)

                Text(value)
                    .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
