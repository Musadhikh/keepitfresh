//
//  InventoryView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Displays active household inventory with pagination, sorting, and filtering controls.
//

import SwiftUI

struct InventoryView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = InventoryViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Theme.Spacing.s12) {
                controlsSection

                if viewModel.isLoading {
                    ProgressView("Loading inventory...")
                        .tint(Theme.Colors.accent)
                        .padding(.top, Theme.Spacing.s12)
                } else if let errorMessage = viewModel.errorMessage {
                    InventoryStatusCardView(
                        title: "Could not load inventory",
                        subtitle: errorMessage,
                        symbol: .warning,
                        tint: Theme.Colors.danger.opacity(0.15)
                    )
                } else if viewModel.rows.isEmpty {
                    InventoryStatusCardView(
                        title: "No active inventory",
                        subtitle: "Add products to see your household inventory here.",
                        symbol: .stock,
                        tint: Theme.Colors.success.opacity(0.10)
                    )
                } else {
                    inventoryRows
                }
            }
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.top, Theme.Spacing.s16)
            .padding(.bottom, Theme.Spacing.s20)
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.large)
        .refreshable {
            await viewModel.loadInitial(householdId: appState.selectedHouse?.id)
        }
        .task(id: appState.selectedHouse?.id) {
            await viewModel.loadInitial(householdId: appState.selectedHouse?.id)
        }
    }

    private var controlsSection: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
            Text("Filters & Sort")
                .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)

            HStack(spacing: Theme.Spacing.s12) {
                LabeledContent("Sort") {
                    Picker("Sort", selection: $viewModel.selectedSort) {
                        ForEach(InventoryViewModel.SortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .labelsHidden()
                }

                LabeledContent("Expiry") {
                    Picker("Expiry", selection: $viewModel.selectedExpiryFilter) {
                        ForEach(InventoryViewModel.ExpiryFilter.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .labelsHidden()
                }
            }

            LabeledContent("Category") {
                Picker("Category", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categoryOptions, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .labelsHidden()
            }
        }
        .font(Theme.Fonts.body(13, weight: .medium, relativeTo: .subheadline))
        .padding(Theme.Spacing.s12)
        .background(Theme.Colors.surface, in: .rect(cornerRadius: Theme.Radius.r16))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r16)
                .stroke(Theme.Colors.border.opacity(0.5), lineWidth: 1)
        )
    }

    private var inventoryRows: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            ForEach(viewModel.rows) { row in
                InventoryListRowView(row: row)
                    .onAppear {
                        Task {
                            await viewModel.loadMoreIfNeeded(currentRow: row)
                        }
                    }
            }

            if viewModel.isLoadingMore {
                HStack {
                    Spacer()
                    ProgressView()
                        .tint(Theme.Colors.accent)
                    Spacer()
                }
                .padding(.vertical, Theme.Spacing.s8)
            }
        }
    }
}

private struct InventoryListRowView: View {
    let row: InventoryViewModel.InventoryListRow

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            Text(row.title)
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: Theme.Spacing.s8) {
                Label(row.categoryTitle, systemImage: Theme.Icon.productCategory.systemName)
                Label(row.expiryText, systemImage: Theme.Icon.productDates.systemName)
            }
            .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .subheadline))
            .foregroundStyle(Theme.Colors.textSecondary)
        }
        .padding(Theme.Spacing.s12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: Theme.Radius.r16))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.r16)
                .stroke(Theme.Colors.border.opacity(0.4), lineWidth: 1)
        )
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        InventoryView()
            .environment(AppState())
    }
}
#endif
