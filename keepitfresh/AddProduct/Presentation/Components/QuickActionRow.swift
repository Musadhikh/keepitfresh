//
//  QuickActionRow.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Inventory quick actions for +1, add batch, and edit dates.
//

import SwiftUI

struct QuickActionRow: View {
    let onPlusOne: () -> Void
    let onAddBatch: () -> Void
    let onEditDates: () -> Void

    var body: some View {
        HStack(spacing: Theme.Spacing.s8) {
            Button("+1", action: onPlusOne)
                .primaryButtonStyle(height: 42)

            Button("Add batch", action: onAddBatch)
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(Theme.Colors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.r16)
                        .stroke(Theme.Colors.border, lineWidth: 1)
                )
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))

            Button("Edit dates", action: onEditDates)
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(Theme.Colors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.r16)
                        .stroke(Theme.Colors.border, lineWidth: 1)
                )
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))
        }
    }
}
