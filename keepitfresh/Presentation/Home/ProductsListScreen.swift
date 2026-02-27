//
//  ProductsListScreen.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Displays all locally cached catalog products persisted in Realm.
//

import SwiftUI

struct ProductsListScreen: View {
    @State private var viewModel = ProductsListViewModel()

    var body: some View {
        List {
            if viewModel.isLoading && viewModel.products.isEmpty {
                ProgressView("Loading products...")
                    .tint(Theme.Colors.accent)
            } else if let loadErrorMessage = viewModel.loadErrorMessage {
                Text(loadErrorMessage)
                    .font(Theme.Fonts.bodyRegular)
                    .foregroundStyle(Theme.Colors.danger)
            } else if viewModel.products.isEmpty {
                Text("No local products saved yet.")
                    .font(Theme.Fonts.bodyRegular)
                    .foregroundStyle(Theme.Colors.textSecondary)
            } else {
                Section("Products (Realm)") {
                    ForEach(viewModel.products, id: \.id) { product in
                        ProductCatalogRow(product: product)
                    }
                }
            }
        }
        .navigationTitle("Products")
        .task {
            await viewModel.loadProducts()
        }
        .refreshable {
            await viewModel.loadProducts()
        }
        .dynamicTypeSize(.xSmall ... .accessibility2)
    }
}

private struct ProductCatalogRow: View {
    let product: ProductCatalogItem

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
            Text(product.title ?? "Untitled Product")
                .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)

            if let brand = product.brand, brand.isEmpty == false {
                Text(brand)
                    .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }

            Label(product.barcode.value, systemImage: Theme.Icon.productBarcode.systemName)
                .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.textSecondary)

            if let size = product.size, size.isEmpty == false {
                Label(size, systemImage: Theme.Icon.productDetails.systemName)
                    .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
        }
        .padding(.vertical, Theme.Spacing.s4)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ProductsListScreen()
    }
}
#endif
