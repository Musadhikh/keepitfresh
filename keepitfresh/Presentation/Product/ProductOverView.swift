//
//  ProductOverView.swift
//  keepitfresh
//
//  Created by musadhikh on 16/2/26.
//  Summary: ProductOverView
//
    

import SwiftUI
import CameraModule

struct ProductOverView: View {
    @Environment(\.dismiss) private var dismiss

    @State var viewModel: ProductOverViewModel
    @State private var isSaveConfirmationPresented = false

    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.s12) {
                ProductOverviewHeader(
                    onBack: { dismiss() },
                    onMore: {}
                )

                ProductOverviewImageCard(
                    images: viewModel.displayImages,
                    selectedImageIndex: $viewModel.selectedImageIndex
                )

                VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
                    ProductOverviewStatusChip(
                        statusText: viewModel.statusText,
                        isError: viewModel.hasError
                    )

                    if let title = viewModel.title {
                        Text(title)
                            .font(Theme.Fonts.titleLarge)
                            .foregroundStyle(Theme.Colors.textPrimary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                            .minimumScaleFactor(0.85)
                    }
                    
                    if let barcode = viewModel.barcode {
                        ProductOverviewBarcodeCard(
                            barcode: barcode
                        )
                    }
                    
                    if let dateInfo = viewModel.dateInfo {
                        ProductOverviewDatesCard(dateInfo: dateInfo)
                    }

                    if let category = viewModel.category {
                        ProductOverviewCategoryCard(category: category)
                    }

                    ProductOverviewDetailsCard(
                        details: viewModel.detailRows
                    )
                }
            }
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.top, Theme.Spacing.s20)
            .padding(.bottom, Theme.Spacing.s24)
        }
        .safeAreaInset(edge: .bottom) {
            ProductOverviewActionBar(
                onDiscard: { dismiss() },
                onSave: { isSaveConfirmationPresented = true }
            )
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.vertical, Theme.Spacing.s12)
            .background(Theme.Colors.background)
        }
        .background(Theme.Colors.background)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .dynamicTypeSize(.xSmall ... .accessibility2)
        .task {
            await viewModel.start()
        }
        .alert("Item saved", isPresented: $isSaveConfirmationPresented) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Product details were saved successfully.")
        }
    }
}

private struct ProductOverviewHeader: View {
    let onBack: () -> Void
    let onMore: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: Theme.Spacing.s12) {
            Button("Back", systemImage: Theme.Icon.productBack.systemName, action: onBack)
                .labelStyle(.iconOnly)
                .font(Theme.Fonts.body(20, weight: .semibold, relativeTo: .title2))
                .foregroundStyle(Theme.Colors.textPrimary)

            Text("Product Overview")
                .font(Theme.Fonts.title)
                .foregroundStyle(Theme.Colors.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.85)

            Spacer(minLength: Theme.Spacing.s8)

            Button("More", systemImage: Theme.Icon.productMore.systemName, action: onMore)
                .labelStyle(.iconOnly)
                .font(Theme.Fonts.body(20, weight: .semibold, relativeTo: .title2))
                .foregroundStyle(Theme.Colors.textSecondary)
        }
    }
}

private struct ProductOverviewStatusChip: View {
    let statusText: String
    let isError: Bool

    var body: some View {
        HStack(spacing: Theme.Spacing.s8) {
            Image(icon: .productGenerating)
                .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .caption))
            Text(statusText)
                .font(Theme.Fonts.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
        .foregroundStyle(isError ? Theme.Colors.danger : Theme.Colors.accent)
        .padding(.vertical, Theme.Spacing.s4)
        .padding(.horizontal, Theme.Spacing.s12)
        .background(isError ? Theme.Colors.danger.opacity(0.12) : Theme.Colors.accentSoft)
        .clipShape(.rect(cornerRadius: Theme.Radius.pill))
    }
}

private struct ProductOverviewBarcodeCard: View {
    let barcode: BarcodeExtraction.PartiallyGenerated

    var body: some View {
        ProductOverviewCard {
            HStack(alignment: .center, spacing: Theme.Spacing.s12) {
                VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                    if let barcodeText = barcode.value {
                        Text("Barcode")
                            .font(Theme.Fonts.caption)
                            .foregroundStyle(Theme.Colors.textSecondary)
                        Text(barcodeText)
                            .font(Theme.Fonts.body(18, weight: .semibold, relativeTo: .headline))
                            .foregroundStyle(Theme.Colors.textPrimary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        if let type = barcode.symbology {
                            Text(type.rawValue)
                                .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .headline))
                                .foregroundStyle(Theme.Colors.textPrimary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                    }
                }

                Spacer(minLength: Theme.Spacing.s8)

                Image(icon: .productBarcode)
                    .font(Theme.Fonts.body(22, weight: .regular, relativeTo: .title3))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
        }
    }
}

private struct ProductOverviewDatesCard: View {
    let dateInfo: [ProductDateInfoExtraction].PartiallyGenerated

    var body: some View {
        ProductOverviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                HStack(spacing: Theme.Spacing.s8) {
                    Image(icon: .productDates)
                        .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .caption))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    Text("Dates")
                        .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .caption))
                        .foregroundStyle(Theme.Colors.textPrimary)
                }
                
                if let packedDate = dateInfo.first(where: { $0.kind == .manufactured || $0.kind == .packedOn }), let date = packedDate.isoDate {
                    ProductOverviewDateRow(label: "Packed", value: date, valueColor: Theme.Colors.textPrimary)
                }
                
                if let expiryDate = dateInfo.first(where: { $0.kind == .bestBefore || $0.kind == .expiry || $0.kind == .useBy }), let date = expiryDate.isoDate {
                    ProductOverviewDateRow(label: "Expiry", value: date, valueColor: Theme.Colors.danger)
                }
            }
        }
    }
}

private struct ProductOverviewDateRow: View {
    let label: String
    let value: String
    let valueColor: Color

    var body: some View {
        HStack {
            Text(label)
                .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.textSecondary)

            Spacer(minLength: Theme.Spacing.s8)

            Text(value)
                .font(Theme.Fonts.body(13, weight: .medium, relativeTo: .caption))
                .foregroundStyle(valueColor)
                .multilineTextAlignment(.trailing)
        }
    }
}

private struct ProductOverviewCategoryCard: View {
    let category: MainCategoryExtraction

    var body: some View {
        ProductOverviewCard {
            HStack(alignment: .center, spacing: Theme.Spacing.s12) {
                Image(icon: .productCategory)
                    .font(Theme.Fonts.body(18, weight: .regular, relativeTo: .body))
                    .foregroundStyle(Theme.Colors.textSecondary)

                VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                    Text("Product Category")
                        .font(Theme.Fonts.caption)
                        .foregroundStyle(Theme.Colors.textSecondary)
                    Text(category.rawValue.uppercased())
                        .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .body))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                }
            }
        }
    }
}

private struct ProductOverviewDetailsCard: View {
    let details: [String]

    var body: some View {
        ProductOverviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                HStack(spacing: Theme.Spacing.s8) {
                    Image(icon: .productDetails)
                        .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .caption))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    Text("Other Product Details")
                        .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .caption))
                        .foregroundStyle(Theme.Colors.textPrimary)
                }

                VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                    ForEach(details, id: \.self) { detail in
                        Text(detail)
                            .font(Theme.Fonts.body(13, weight: .medium, relativeTo: .caption))
                            .foregroundStyle(
                                detail.localizedStandardContains("Source:")
                                ? Theme.Colors.textSecondary
                                : Theme.Colors.textPrimary
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
    }
}

private struct ProductOverviewCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Theme.Spacing.s12)
            .background(Theme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Radius.r16)
                    .stroke(Theme.Colors.border, lineWidth: 1)
            )
            .clipShape(.rect(cornerRadius: Theme.Radius.r16))
    }
}

private struct ProductOverviewActionBar: View {
    let onDiscard: () -> Void
    let onSave: () -> Void

    var body: some View {
        HStack(spacing: Theme.Spacing.s12) {
            Button("Discard", action: onDiscard)
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .body))
                .foregroundStyle(Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 52)
                .background(Theme.Colors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.r16)
                        .stroke(Theme.Colors.border, lineWidth: 1)
                )
                .clipShape(.rect(cornerRadius: Theme.Radius.r16))

            Button("Save Item", action: onSave)
                .primaryButtonStyle(height: 52)
        }
    }
}

#Preview {
    ProductOverView(viewModel: ProductOverViewModel(capturedImages: []))
}
