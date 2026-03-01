//
//  HomeUndoBannerView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Displays transient undo feedback and action on Home.
//

import SwiftUI

struct HomeUndoBannerView: View {
    let message: String
    let onUndo: () -> Void

    var body: some View {
        HStack(spacing: Theme.Spacing.s12) {
            Text(message)
                .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)

            Spacer(minLength: Theme.Spacing.s12)

            Button("Undo", action: onUndo)
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.accent)
        }
        .padding(.horizontal, Theme.Spacing.s16)
        .padding(.vertical, Theme.Spacing.s12)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r16))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r16)
                .stroke(Theme.Colors.border.opacity(0.5), lineWidth: 1)
        )
    }
}
