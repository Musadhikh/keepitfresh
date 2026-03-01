//
//  HomeInventoryStateView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Renders Home inventory sections from a typed Home UI state.
//

import SwiftUI

struct HomeInventoryStateView: View {
    let uiState: HomeViewModel.UIState
    let mutatingItemIDs: Set<String>
    let onSelect: (HomeViewModel.InventoryRowModel) -> Void
    let onDiscard: (HomeViewModel.InventoryRowModel) async -> Void
    let onFinished: (HomeViewModel.InventoryRowModel) async -> Void
    let onAddNew: () -> Void

    var body: some View {
        switch uiState {
        case .loading:
            ProgressView("Loading inventory...")
                .tint(Theme.Colors.accent)
                .padding(.top, Theme.Spacing.s12)

        case let .error(loadErrorMessage):
            HomeStatusCardView(
                title: "Could not refresh inventory",
                subtitle: loadErrorMessage,
                symbol: .warning,
                tint: Theme.Colors.danger.opacity(0.15)
            )

        case .empty:
            HomeStatusCardView(
                title: "You're all good",
                subtitle: "No items expiring soon.",
                symbol: .success,
                tint: Theme.Colors.success.opacity(0.12)
            )

        case let .content(expired, expiringIn3Days, expiringIn7Days):
            VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                if expired.isNotEmpty {
                    HomeInventorySectionView(
                        title: "Expired",
                        tint: Theme.Colors.danger.opacity(0.14),
                        rows: expired,
                        mutatingItemIDs: mutatingItemIDs,
                        onSelect: onSelect,
                        onDiscard: onDiscard,
                        onFinished: onFinished,
                        onAddNew: onAddNew
                    )
                }

                if expiringIn3Days.isNotEmpty {
                    HomeInventorySectionView(
                        title: "Expiring Soon (3 Days)",
                        tint: Theme.Colors.warning.opacity(0.12),
                        rows: expiringIn3Days,
                        mutatingItemIDs: mutatingItemIDs,
                        onSelect: onSelect,
                        onDiscard: onDiscard,
                        onFinished: onFinished,
                        onAddNew: onAddNew
                    )
                }

                if expiringIn7Days.isNotEmpty {
                    HomeInventorySectionView(
                        title: "Expiring In 7 Days",
                        tint: Theme.Colors.warning.opacity(0.08),
                        rows: expiringIn7Days,
                        mutatingItemIDs: mutatingItemIDs,
                        onSelect: onSelect,
                        onDiscard: onDiscard,
                        onFinished: onFinished,
                        onAddNew: onAddNew
                    )
                }
            }
        }
    }
}
