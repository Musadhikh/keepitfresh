//
//  HomeInventorySectionView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Renders a home inventory urgency section and its per-item action rows.
//

import SwiftUI

struct HomeInventorySectionView: View {
    let title: String
    let tint: Color
    let rows: [HomeViewModel.InventoryRowModel]
    let mutatingItemIDs: Set<String>
    let onSelect: (HomeViewModel.InventoryRowModel) -> Void
    let onDiscard: (HomeViewModel.InventoryRowModel) async -> Void
    let onFinished: (HomeViewModel.InventoryRowModel) async -> Void
    let onAddNew: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            Text(title)
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)

            ForEach(rows) { row in
                HomeInventoryRowCard(
                    row: row,
                    isProcessing: mutatingItemIDs.contains(row.id),
                    onSelect: {
                        onSelect(row)
                    },
                    onDiscard: {
                        await onDiscard(row)
                    },
                    onFinished: {
                        await onFinished(row)
                    },
                    onAddNew: onAddNew
                )
            }
        }
        .padding(Theme.Spacing.s12)
        .background(tint, in: .rect(cornerRadius: Theme.Radius.r20))
    }
}

private struct HomeInventoryRowCard: View {
    let row: HomeViewModel.InventoryRowModel
    let isProcessing: Bool
    let onSelect: () -> Void
    let onDiscard: () async -> Void
    let onFinished: () async -> Void
    let onAddNew: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: Theme.Spacing.s12) {
                Image(systemName: row.categorySymbol)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .frame(width: 34, height: 34)
                    .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r12))

                Button(action: onSelect) {
                    VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                        Text(row.title)
                            .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                            .foregroundStyle(Theme.Colors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)

                        Text(row.categoryTitle)
                            .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .subheadline))
                            .foregroundStyle(Theme.Colors.textSecondary)

                        Text(row.relativeExpiryLabel)
                            .font(Theme.Fonts.body(13, weight: .medium, relativeTo: .caption))
                            .foregroundStyle(row.isExpired ? Theme.Colors.danger : Theme.Colors.warning)

                        Text(row.expiryDateText)
                            .font(Theme.Fonts.body(12, weight: .regular, relativeTo: .caption2))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                }
                .buttonStyle(.plain)
            }

            HStack(spacing: Theme.Spacing.s8) {
                actionButton(symbol: .deleteFilled, title: "Discard", disabled: isProcessing) {
                    await onDiscard()
                }

                actionButton(symbol: .doneFilled, title: "Finished", disabled: isProcessing) {
                    await onFinished()
                }

                actionButton(symbol: .addFilled, title: "Add New", disabled: false) {
                    onAddNew()
                }

                if isProcessing {
                    ProgressView()
                        .controlSize(.small)
                        .tint(Theme.Colors.accent)
                        .padding(.leading, Theme.Spacing.s8)
                }
            }
        }
        .padding(Theme.Spacing.s12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r16))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r16)
                .stroke(Theme.Colors.border.opacity(0.4), lineWidth: 1)
        )
    }

    private func actionButton(
        symbol: Theme.Icon,
        title: String,
        disabled: Bool,
        action: @escaping () async -> Void
    ) -> some View {
        Button {
            Task {
                await action()
            }
        } label: {
            HStack(spacing: Theme.Spacing.s4) {
                Image(icon: symbol)
                Text(title)
            }
            .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
            .foregroundStyle(Theme.Colors.textPrimary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
        }
        .disabled(disabled)
        .buttonStyle(.plain)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r12))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r12)
                .stroke(Theme.Colors.border.opacity(0.45), lineWidth: 1)
        )
        .shadow(color: Theme.Colors.textPrimary.opacity(0.08), radius: 1, y: 1)
        .opacity(disabled ? 0.45 : 1)
    }
}
