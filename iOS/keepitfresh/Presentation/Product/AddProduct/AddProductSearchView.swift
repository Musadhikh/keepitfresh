//
//  AddProductSearchView.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: S4 product search screen with category chips and selectable product rows.
//

import SwiftUI

struct AddProductSearchView: View {
    @State var viewModel: AddProductSearchViewModel
    let onBack: () -> Void
    let onSelectProduct: (AddProductSearchViewModel.SearchResultRow) -> Void

    var body: some View {
        VStack(spacing: 0) {
            header

            switch viewModel.uiState {
            case .idle, .loading:
                ProgressView()
                    .tint(Theme.Colors.accent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .empty:
                ContentUnavailableView(
                    "No Products Found",
                    systemImage: Theme.Icon.productCategory.systemName,
                    description: Text("Try a different query or filter.")
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .error(let message):
                ContentUnavailableView(
                    "Search Failed",
                    systemImage: Theme.Icon.warning.systemName,
                    description: Text(message)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .content:
                List(viewModel.rows) { row in
                    Button(action: { onSelectProduct(row) }) {
                        HStack(spacing: Theme.Spacing.s12) {
                            Image(icon: .productCategory)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Theme.Colors.accent)
                                .frame(width: 36, height: 36)
                                .background(Theme.Colors.surfaceAlt)
                                .clipShape(.circle)

                            VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                                Text(row.title)
                                    .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                                    .foregroundStyle(Theme.Colors.textPrimary)
                                Text("\(row.categoryTitle) • \(row.brand)")
                                    .font(Theme.Fonts.body(12, weight: .regular, relativeTo: .caption))
                                    .foregroundStyle(Theme.Colors.textSecondary)
                            }

                            Spacer()
                            Image(icon: .chevronRight)
                                .foregroundStyle(Theme.Colors.textSecondary)
                        }
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Theme.Colors.background)
                }
                .listStyle(.plain)
            }
        }
        .background(Theme.Colors.background)
        .task(id: taskID) {
            await viewModel.loadProducts()
        }
    }

    private var taskID: String {
        "\(viewModel.selectedFilter.rawValue)-\(viewModel.searchText)"
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
            HStack {
                Button(action: onBack) {
                    HStack(spacing: Theme.Spacing.s8) {
                        Image(icon: .productBack)
                        Text("Back")
                    }
                    .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textSecondary)
                }
                .buttonStyle(.plain)
                Spacer()
            }

            TextField("Search products", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Theme.Spacing.s8) {
                    ForEach(AddProductSearchFilter.allCases) { filter in
                        Button(filter.title) {
                            viewModel.selectedFilter = filter
                        }
                        .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
                        .foregroundStyle(viewModel.selectedFilter == filter ? Theme.Colors.textOnAccent : Theme.Colors.textPrimary)
                        .padding(.horizontal, Theme.Spacing.s12)
                        .padding(.vertical, Theme.Spacing.s8)
                        .background(viewModel.selectedFilter == filter ? Theme.Colors.accent : Theme.Colors.surface)
                        .clipShape(.capsule)
                        .overlay(
                            Capsule().stroke(Theme.Colors.border, lineWidth: Theme.Border.hairline)
                        )
                    }
                }
            }
        }
        .padding(Theme.Spacing.s16)
        .background(Theme.Colors.background)
    }
}
