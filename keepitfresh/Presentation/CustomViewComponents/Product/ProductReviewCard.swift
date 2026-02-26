//
//
//  ProductReviewCard.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewCard
//
    

import SwiftUI

struct ProductReviewCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(Theme.Spacing.s12)
            .background(Theme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Radius.r16)
                    .stroke(Theme.Colors.border, lineWidth: 1)
            )
            .clipShape(.rect(cornerRadius: Theme.Radius.r16))
    }
}
