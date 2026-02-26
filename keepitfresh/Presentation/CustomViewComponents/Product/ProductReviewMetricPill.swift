//
//
//  ProductReviewMetricPill.swift
//  keepitfresh
//
//  Created by musadhikh on 26/2/26.
//  Summary: ProductReviewMetricPill
//
    
import SwiftUI

struct ProductReviewMetricPill: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
            Text(title.uppercased())
                .font(Theme.Fonts.body(11, weight: .medium, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.textSecondary)

            Text(value)
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.Spacing.s12)
        .background(Theme.Colors.surfaceAlt)
        .clipShape(.rect(cornerRadius: Theme.Radius.r12))
    }
}
