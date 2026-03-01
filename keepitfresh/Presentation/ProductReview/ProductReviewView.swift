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
    @Environment(AppState.self) private var appState
    
    @State private var viewModel: ProductReviewViewModel
    let onAdd: (Product) -> Void

    @State private var selectedImageIndex: Int = 0
    @State private var hasStartedReview: Bool = false

    init(viewModel: ProductReviewViewModel, onAdd: @escaping (Product) -> Void) {
        _viewModel = State(initialValue: viewModel)
        self.onAdd = onAdd
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: Theme.Spacing.s16) {
                    ProductReviewHeroSection(
                        images: viewModel.displayImages,
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
                    
                    if let generatedData = viewModel.generatedData {
                        switch generatedData.productDetails {
                            case .food(let detail), .beverage(let detail):
                                ProductReviewSectionHeader(title: "Nutritional Information")
                                ProductReviewNutritionCard(
                                    servingSize: servingSizeText,
                                    calories: caloriesText,
                                    detail: detail
                                )
                            
                            case .household(_):
                                ProductReviewSectionHeader(title: "Household Details")
                                ProductReviewHouseholdCard(
                                    packagingMaterial: packagingMaterialText,
                                    storageInstructions: storageInstructionsText
                                )
                            case .personalCare(_): Text("Personal care UI goes here")
                            case .other(_): Text("Other UI goes here")
                            case nil: EmptyView()
                        }
                    }
                }
                .padding(.horizontal, Theme.Spacing.s16)
                .padding(.top, Theme.Spacing.s12)
                .padding(.bottom, Theme.Spacing.s32 + 84)
            }
            .scrollIndicators(.hidden)

            VStack(spacing: Theme.Spacing.s8) {
                Button("Add") {
                    if let product = viewModel.prepareData() {
                        onAdd(product)
                        appState.navigateBack()
                    }
                }
                .primaryButtonStyle(height: 50)
            }
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.vertical, Theme.Spacing.s12)
            .background(Theme.Colors.background.opacity(0.96))
            .disabled(viewModel.generatedData.isNil)
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
