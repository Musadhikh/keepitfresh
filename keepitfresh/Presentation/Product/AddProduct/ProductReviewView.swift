//
//
//  ProductReviewView.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Product review screen styled from design/screen.png and powered by extracted image data.
//

import SwiftUI
import UIKit
import ImageDataModule

struct ProductReviewView: View {
    @State private var viewModel: ProductReviewViewModel
    let onAdd: () -> Void

    @State private var selectedImageIndex: Int = 0
    @State private var hasStartedReview: Bool = false

    init(viewModel: ProductReviewViewModel, onAdd: @escaping () -> Void) {
        _viewModel = State(initialValue: viewModel)
        self.onAdd = onAdd
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: Theme.Spacing.s16) {
                    ProductReviewHeroSection(
                        images: viewModel.capturedImages.map(\.image),
                        selectedImageIndex: $selectedImageIndex,
                        title: titleText,
                        subtitle: subtitleText,
                        summary: summaryText,
                        itemCount: $viewModel.numberOfItems
                    )

                    LazyVGrid(columns: metricColumns, spacing: Theme.Spacing.s12) {
                        ProductReviewInfoTile(
                            icon: .productBarcode,
                            title: "Barcode",
                            value: barcodeText
                        )

                        ProductReviewInfoTile(
                            icon: .productDetails,
                            title: "Unit",
                            value: unitText
                        )

                        ProductReviewInfoTile(
                            icon: .productDates,
                            title: "Packed Date",
                            value: packedDateText
                        )

                        ProductReviewInfoTile(
                            icon: .productDates,
                            title: "Expiry Date",
                            value: expiryDateText
                        )

                        ProductReviewInfoTile(
                            icon: .productCategory,
                            title: "Category",
                            value: mainCategoryText
                        )

                        ProductReviewInfoTile(
                            icon: .productCategory,
                            title: "Sub-Category",
                            value: subCategoryText
                        )
                    }

                    ProductReviewSectionHeader(title: "Nutritional Information")
                    ProductReviewNutritionCard(
                        servingSize: servingSizeText,
                        calories: caloriesText,
                        allergens: allergens
                    )

                    ProductReviewSectionHeader(title: "Household Details")
                    ProductReviewHouseholdCard(
                        packagingMaterial: packagingMaterialText,
                        storageInstructions: storageInstructionsText
                    )
                }
                .padding(.horizontal, Theme.Spacing.s16)
                .padding(.top, Theme.Spacing.s12)
                .padding(.bottom, Theme.Spacing.s32 + 84)
            }
            .scrollIndicators(.hidden)

            VStack(spacing: Theme.Spacing.s8) {
                Button("Add") {
                    viewModel.prepareData()
                    onAdd()
                }
                .primaryButtonStyle(height: 50)
            }
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.vertical, Theme.Spacing.s12)
            .background(Theme.Colors.background.opacity(0.96))
        }
        .background(
            LinearGradient(
                colors: [Theme.Colors.background, Theme.Colors.surfaceAlt],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .task {
            guard !hasStartedReview else { return }
            hasStartedReview = true
            await viewModel.startReviewProcess()
        }
        .dynamicTypeSize(.xSmall ... .accessibility2)
    }

    private var generatedData: ExtractedData.PartiallyGenerated? {
        viewModel.generatedData
    }

    private var metricColumns: [GridItem] {
        [
            GridItem(.flexible(), spacing: Theme.Spacing.s12),
            GridItem(.flexible(), spacing: Theme.Spacing.s12)
        ]
    }

    private var titleText: String {
        generatedData?.title ?? "Reviewing product details..."
    }

    private var subtitleText: String {
        // TODO: Add dedicated quality/claim fields in ExtractedData (e.g., "100% Organic", "Stone-Ground").
        generatedData?.brand ?? "Generated from captured product labels"
    }

    private var summaryText: String {
        generatedData?.shortDescription ?? "We are extracting details from the captured images."
    }

    private var barcodeText: String {
        generatedData?.barcodeInfo?.barcode ?? "Not available"
    }

    private var unitText: String {
        // TODO: Use a dedicated extracted unit field once ExtractedData includes one.
        switch (foodDetails?.quantity, foodDetails?.numberOfItems) {
        case let (.some(quantity), .some(items)):
            return "\(quantity) / \(items)"
        case let (.some(quantity), nil):
            return quantity
        case let (nil, .some(items)):
            return items
        default:
            return "\(viewModel.numberOfItems) item(s)"
        }
    }

    private var mainCategoryText: String {
        guard let rawValue = generatedData?.category?.mainCategory?.rawValue else {
            return "Not available"
        }

        if rawValue == "personalCare" {
            return "Personal Care"
        }

        return rawValue.capitalized
    }

    private var subCategoryText: String {
        generatedData?.category?.subCategory ?? "Not available"
    }

    private var packedDateText: String {
        dateText(matching: ["packed", "manufactured"])
    }

    private var expiryDateText: String {
        dateText(matching: ["expiry", "bestbefore", "usebefore", "useby"])
    }

    private var servingSizeText: String {
        foodDetails?.servingSize ?? "Not available"
    }

    private var caloriesText: String {
        guard let energy = foodDetails?.nutritionPer100gOrMl?.energyKcal else {
            return "Not available"
        }
        return "\(energy.formatted(.number.precision(.fractionLength(0 ... 1)))) kcal"
    }

    private var allergens: [String] {
        guard let values = foodDetails?.allergens else { return [] }
        let sanitized = values.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        return sanitized.filter { !$0.isEmpty }
    }

    private var packagingMaterialText: String {
        guard let materials = householdDetails?.materials, !materials.isEmpty else {
            return "Not available"
        }
        return materials.joined(separator: ", ")
    }

    private var storageInstructionsText: String {
        if let storageInstructions = generatedData?.storageInstructions, !storageInstructions.isEmpty {
            return storageInstructions
        }

        if let usage = householdDetails?.usageInstructions, !usage.isEmpty {
            return usage.joined(separator: " ")
        }

        return "Not available"
    }

    private var foodDetails: ExtractedFoodDetails.PartiallyGenerated? {
        guard let productDetails = generatedData?.productDetails else { return nil }
        switch productDetails {
        case .food(let details):
            return details
        case .beverage(let details):
            return details
        default:
            return nil
        }
    }

    private var householdDetails: ExtractedHouseholdDetails.PartiallyGenerated? {
        guard let productDetails = generatedData?.productDetails else { return nil }
        switch productDetails {
        case .household(let details):
            return details
        default:
            return nil
        }
    }

    private func dateText(matching preferredTypes: Set<String>) -> String {
        guard let dateInfo = generatedData?.dateInfo else {
            return "Not available"
        }

        if let preferred = dateInfo.first(where: { info in
            guard let rawType = info.dateType?.rawValue.lowercased(),
                  let date = info.date,
                  !date.isEmpty else {
                return false
            }
            return preferredTypes.contains(rawType)
        })?.date {
            return preferred
        }

        if let fallback = dateInfo.first(where: { ($0.date?.isEmpty == false) })?.date {
            return fallback
        }

        return "Not available"
    }
}

private struct ProductReviewHeroSection: View {
    let images: [UIImage]
    @Binding var selectedImageIndex: Int
    let title: String
    let subtitle: String
    let summary: String
    @Binding var itemCount: Int

    private var pageCount: Int {
        max(images.count, 1)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedImageIndex) {
                if images.isEmpty {
                    ZStack {
                        Theme.Colors.surfaceAlt
                        Image(icon: .analyserResult)
                            .font(Theme.Fonts.display(36, weight: .semibold, relativeTo: .title))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                    .tag(0)
                } else {
                    ForEach(images.enumerated(), id: \.offset) { index, image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 240)
            .clipShape(.rect(cornerRadius: Theme.Radius.r20))

            HStack(spacing: Theme.Spacing.s8) {
                ForEach(0 ..< pageCount, id: \.self) { index in
                    Circle()
                        .fill(index == selectedImageIndex ? Theme.Colors.accent : Theme.Colors.border)
                        .frame(width: Theme.Spacing.s8, height: Theme.Spacing.s8)
                }
            }
            .padding(.bottom, Theme.Spacing.s8)

            ProductReviewCard {
                VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                    Text(title)
                        .font(Theme.Fonts.body(24, weight: .semibold, relativeTo: .title2))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .lineLimit(2)

                    Text(subtitle)
                        .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .subheadline))
                        .foregroundStyle(Theme.Colors.accent)

                    Text(summary)
                        .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .subheadline))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .lineLimit(3)

                    ProductReviewCounterRow(itemCount: $itemCount)
                }
            }
            .padding(.horizontal, Theme.Spacing.s12)
            .offset(y: Theme.Spacing.s20)
        }
        .padding(.bottom, Theme.Spacing.s20)
    }
}

private struct ProductReviewCounterRow: View {
    @Binding var itemCount: Int

    var body: some View {
        HStack(spacing: Theme.Spacing.s12) {
            Text("Number of Items")
                .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.textPrimary)

            Spacer()

            Button {
                if itemCount > 1 {
                    itemCount -= 1
                }
            } label: {
                Text("−")
                    .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .body))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .frame(width: 28, height: 28)
                    .background(Theme.Colors.surfaceAlt)
                    .clipShape(.circle)
            }
            .disabled(itemCount <= 1)

            Text(itemCount.formatted())
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .body))
                .foregroundStyle(Theme.Colors.textPrimary)
                .monospacedDigit()

            Button {
                itemCount += 1
            } label: {
                Text("+")
                    .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .body))
                    .foregroundStyle(.white)
                    .frame(width: 28, height: 28)
                    .background(Theme.Colors.accent)
                    .clipShape(.circle)
            }
        }
        .padding(.horizontal, Theme.Spacing.s12)
        .padding(.vertical, Theme.Spacing.s8)
        .background(Theme.Colors.surfaceAlt)
        .clipShape(.rect(cornerRadius: Theme.Radius.r12))
    }
}

private struct ProductReviewInfoTile: View {
    let icon: Theme.Icon
    let title: String
    let value: String

    var body: some View {
        ProductReviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                Image(icon: icon)
                    .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.accent)

                Text(title.uppercased())
                    .font(Theme.Fonts.body(11, weight: .medium, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.textSecondary)

                Text(value)
                    .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct ProductReviewSectionHeader: View {
    let title: String

    var body: some View {
        HStack(spacing: Theme.Spacing.s8) {
            Image(icon: .splashLeaf)
                .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.accent)
            Text(title)
                .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                .foregroundStyle(Theme.Colors.textPrimary)
            Spacer()
        }
    }
}

private struct ProductReviewNutritionCard: View {
    let servingSize: String
    let calories: String
    let allergens: [String]

    private var chipColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 96), spacing: Theme.Spacing.s8)]
    }

    var body: some View {
        ProductReviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: Theme.Spacing.s8),
                    GridItem(.flexible(), spacing: Theme.Spacing.s8)
                ], spacing: Theme.Spacing.s8) {
                    ProductReviewMetricPill(title: "Serving Size", value: servingSize)
                    ProductReviewMetricPill(title: "Calories", value: calories)
                }

                Text("Allergens")
                    .font(Theme.Fonts.body(11, weight: .medium, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.textSecondary)

                if allergens.isEmpty {
                    Text("No allergen information available.")
                        .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .subheadline))
                        .foregroundStyle(Theme.Colors.textSecondary)
                } else {
                    LazyVGrid(columns: chipColumns, alignment: .leading, spacing: Theme.Spacing.s8) {
                        ForEach(allergens, id: \.self) { allergen in
                            ProductReviewTagChip(text: allergen)
                        }
                    }
                }
            }
        }
    }
}

private struct ProductReviewHouseholdCard: View {
    let packagingMaterial: String
    let storageInstructions: String

    var body: some View {
        ProductReviewCard {
            VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
                ProductReviewMetricPill(title: "Packaging Material", value: packagingMaterial)
                ProductReviewMetricPill(title: "Storage Instructions", value: storageInstructions)
            }
        }
    }
}

private struct ProductReviewMetricPill: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
            Text(title.uppercased())
                .font(Theme.Fonts.body(11, weight: .medium, relativeTo: .caption))
                .foregroundStyle(Theme.Colors.textSecondary)

            Text(value)
                .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                .foregroundStyle(Theme.Colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.Spacing.s12)
        .background(Theme.Colors.surfaceAlt)
        .clipShape(.rect(cornerRadius: Theme.Radius.r12))
    }
}

private struct ProductReviewTagChip: View {
    let text: String

    var body: some View {
        Text(text)
            .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
            .foregroundStyle(Theme.Colors.accent)
            .padding(.horizontal, Theme.Spacing.s8)
            .padding(.vertical, Theme.Spacing.s4)
            .background(Theme.Colors.accentSoft)
            .clipShape(.capsule)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct ProductReviewCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(Theme.Spacing.s12)
            .background(Theme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Radius.r16)
                    .stroke(Theme.Colors.border, lineWidth: 1)
            )
            .clipShape(.rect(cornerRadius: Theme.Radius.r16))
    }
}
