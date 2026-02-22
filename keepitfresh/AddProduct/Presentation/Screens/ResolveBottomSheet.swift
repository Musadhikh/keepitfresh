//
//  ResolveBottomSheet.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Inline resolve status/actions surface for scanner flow.
//

import SwiftUI

struct ResolveBottomSheet: View {
    let state: AddProductState
    let onRetry: () -> Void
    let onManual: () -> Void
    let onContinueCatalog: () -> Void
    let onContinueCamera: () -> Void
    let onQuickAddOne: () -> Void
    let onQuickAddBatch: () -> Void
    let onEditDates: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.Spacing.s16)
        .background(Theme.Colors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r24)
                .stroke(Theme.Colors.border, lineWidth: 1)
        )
        .clipShape(.rect(cornerRadius: Theme.Radius.r24))
        .padding(.horizontal, Theme.Spacing.s16)
        .padding(.bottom, Theme.Spacing.s16)
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .resolving(let barcode):
            Text("Looking up \(barcode.value)...")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
            ProgressView()
                .tint(Theme.Colors.accent)

        case .inventoryFound(let item, let source):
            Text("Found in inventory")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
            Text("Source: \(source.rawValue)")
                .font(Theme.Fonts.caption)
                .foregroundStyle(Theme.Colors.textSecondary)
            Text("Batches: \(item.batches.count)")
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
            QuickActionRow(onPlusOne: onQuickAddOne, onAddBatch: onQuickAddBatch, onEditDates: onEditDates)

        case .catalogFound(let item, let source):
            Text("Found in catalog")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
            Text(item.title ?? item.barcode.value)
                .font(Theme.Fonts.body(15, weight: .medium, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
            Text("Source: \(source.rawValue)")
                .font(Theme.Fonts.caption)
                .foregroundStyle(Theme.Colors.textSecondary)
            Button("Continue", action: onContinueCatalog)
                .primaryButtonStyle(height: 44)

        case .captureImages:
            Text("No inventory/catalog match")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
            Text("Continue to image capture for AI extraction.")
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
            Button("Continue to camera", action: onContinueCamera)
                .primaryButtonStyle(height: 44)

        case .failure(let message):
            Text("Something went wrong")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.danger)
            Text(message)
                .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
            HStack(spacing: Theme.Spacing.s8) {
                Button("Retry", action: onRetry)
                    .primaryButtonStyle(height: 42)
                Button("Manual", action: onManual)
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

        default:
            Text("Scan a barcode to start")
                .font(Theme.Fonts.body(15, weight: .regular, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textSecondary)
        }
    }
}
