//
//  HomeStatusCardView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//

import SwiftUI

struct HomeStatusCardView: View {
    let title: String
    let subtitle: String
    let symbol: Theme.Icon
    let tint: Color

    var body: some View {
        HStack(spacing: Theme.Spacing.s12) {
            Image(icon: symbol)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r12))

            VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                Text(title)
                    .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    .foregroundStyle(Theme.Colors.textPrimary)
                Text(subtitle)
                    .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
        }
        .padding(Theme.Spacing.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(tint, in: .rect(cornerRadius: Theme.Radius.r20))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r20)
                .stroke(Theme.Colors.border.opacity(0.4), lineWidth: 1)
        )
    }
}
