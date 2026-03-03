//
//  AddProductActionSheetView.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: S1 Add action sheet with entry points for scan/search/manual/quick-add paths.
//

import SwiftUI

struct AddProductActionSheetView: View {
    let householdName: String
    let onClose: () -> Void
    let onScanLabel: () -> Void
    let onScanBarcode: () -> Void
    let onSearchProducts: () -> Void
    let onManualAdd: () -> Void
    let onQuickAdd: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                header
                householdPill
                actionRow(icon: .textViewfinder, title: "Scan Label", subtitle: "Detect name and expiry", action: onScanLabel, accessibilityID: "addFlow.action.scanLabel")
                actionRow(icon: .scanTab, title: "Scan Barcode", subtitle: "Find product instantly", action: onScanBarcode, accessibilityID: "addFlow.action.scanBarcode")
                actionRow(icon: .magnifyingGlass, title: "Search Products", subtitle: "Browse saved items", action: onSearchProducts, accessibilityID: "addFlow.action.searchProducts")
                actionRow(icon: .squareAndPencil, title: "Manual Add", subtitle: "Enter details yourself", action: onManualAdd, accessibilityID: "addFlow.action.manualAdd")
                actionRow(icon: .sparkles, title: "Quick Add", subtitle: "Eggs, Milk, Tomato…", action: onQuickAdd, accessibilityID: "addFlow.action.quickAdd")
            }
            .padding(Theme.Spacing.s16)
        }
        .background(Theme.Colors.background)
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                Text("Add")
                    .font(Theme.Fonts.titleLarge)
                    .foregroundStyle(Theme.Colors.textPrimary)
                Text("Scan a label or add manually")
                    .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
            Spacer()
//            Button(action: onClose) {
//                Image(icon: .close)
//                    .font(.system(size: 14, weight: .semibold))
//                    .foregroundStyle(Theme.Colors.textPrimary)
//                    .frame(width: 32, height: 32)
//                    .background(Theme.Colors.surfaceAlt)
//                    .clipShape(.circle)
//            }
//            .buttonStyle(.plain)
            .accessibilityLabel("Close")
        }
    }

    private var householdPill: some View {
        HStack(spacing: Theme.Spacing.s8) {
            Image(icon: .houseFill)
                .foregroundStyle(Theme.Colors.accent)
            Text(householdName)
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
            Spacer(minLength: 0)
            Image(icon: .chevronDown)
                .foregroundStyle(Theme.Colors.textSecondary)
        }
        .padding(.horizontal, Theme.Spacing.s12)
        .padding(.vertical, Theme.Spacing.s8)
        .background(Theme.Colors.surface)
        .overlay(
            Capsule().stroke(Theme.Colors.border, lineWidth: Theme.Border.hairline)
        )
        .clipShape(.capsule)
    }

    private func actionRow(icon: Theme.Icon, title: String, subtitle: String, action: @escaping () -> Void, accessibilityID: String) -> some View {
        Button(action: action) {
            AddProductGlassCardView {
                HStack(spacing: Theme.Spacing.s12) {
                    Image(icon: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Theme.Colors.accent)
                        .frame(width: 40, height: 40)
                        .background(Theme.Colors.accentSoft)
                        .clipShape(.circle)

                    VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                        Text(title)
                            .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                            .foregroundStyle(Theme.Colors.textPrimary)
                        Text(subtitle)
                            .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .caption))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }

                    Spacer()
                    Image(icon: .chevronRight)
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier(accessibilityID)
    }
}
