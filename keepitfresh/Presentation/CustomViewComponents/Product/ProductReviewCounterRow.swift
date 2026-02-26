//
//
//  ProductReviewCounterRow.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewCounterRow
//
    
import SwiftUI

struct ProductReviewCounterRow: View {
    @Binding var itemCount: Int

    var body: some View {
        HStack(spacing: Theme.Spacing.s12) {
            Text("Number of Items")
                .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.textPrimary)

            Spacer()

            Button {
                if itemCount > 1 {
                    itemCount -= 1
                }
            } label: {
                Text("−")
                    .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .body))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .frame(width: 28, height: 28)
                    .background(Theme.Colors.surfaceAlt)
                    .clipShape(.circle)
            }
            .disabled(itemCount <= 1)

            Text(itemCount.formatted())
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .body))
                .foregroundStyle(Theme.Colors.textPrimary)
                .monospacedDigit()

            Button {
                itemCount += 1
            } label: {
                Text("+")
                    .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .body))
                    .foregroundStyle(.white)
                    .frame(width: 28, height: 28)
                    .background(Theme.Colors.accent)
                    .clipShape(.circle)
            }
        }
        .padding(.horizontal, Theme.Spacing.s12)
        .padding(.vertical, Theme.Spacing.s8)
        .background(Theme.Colors.surfaceAlt)
        .clipShape(.rect(cornerRadius: Theme.Radius.r12))
    }
}
