//
//
//  ProductReviewSectionHeader.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewSectionHeader
//
    
import SwiftUI

struct ProductReviewSectionHeader: View {
    let title: String

    var body: some View {
        HStack(spacing: Theme.Spacing.s8) {
            Image(icon: .splashLeaf)
                .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.accent)
            Text(title)
                .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
            Spacer()
        }
    }
}
