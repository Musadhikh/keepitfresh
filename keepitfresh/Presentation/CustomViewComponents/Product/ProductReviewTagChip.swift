//
//
//  ProductReviewTagChip.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewTagChip
//
    
import SwiftUI

struct ProductReviewTagChip: View {
    let text: String

    var body: some View {
        Text(text)
            .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
            .foregroundStyle(Theme.Colors.accent)
            .padding(.horizontal, Theme.Spacing.s8)
            .padding(.vertical, Theme.Spacing.s4)
            .background(Theme.Colors.accentSoft)
            .clipShape(.capsule)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
