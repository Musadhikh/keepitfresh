//
//  LockedFieldView.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Wrapper that visually marks fields as locked in review UI.
//

import SwiftUI

struct LockedFieldView<Content: View>: View {
    let title: String
    let isLocked: Bool
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            HStack(spacing: Theme.Spacing.s8) {
                Text(title)
                    .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textPrimary)

                if isLocked {
                    Image(icon: .lock)
                        .font(Theme.Fonts.body(12, weight: .medium, relativeTo: .caption))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
            }

            content
                .disabled(isLocked)
                .opacity(isLocked ? 0.8 : 1.0)
        }
        .padding(Theme.Spacing.s12)
        .background(Theme.Colors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r16)
                .stroke(Theme.Colors.border, lineWidth: 1)
        )
        .clipShape(.rect(cornerRadius: Theme.Radius.r16))
    }
}
