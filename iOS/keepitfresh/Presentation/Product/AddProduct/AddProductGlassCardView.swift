//
//  AddProductGlassCardView.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: Shared glass-style card container for Add Product flow screens.
//

import SwiftUI

struct AddProductGlassCardView<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
            content
        }
        .padding(Theme.Spacing.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r20)
                .stroke(Theme.Colors.glassBorder, lineWidth: Theme.Border.hairline)
        )
        .shadow(
            color: Theme.Elevation.glassShadowColor,
            radius: Theme.Elevation.glassShadowRadius,
            y: Theme.Elevation.glassShadowYOffset
        )
        .clipShape(.rect(cornerRadius: Theme.Radius.r20))
    }
}
