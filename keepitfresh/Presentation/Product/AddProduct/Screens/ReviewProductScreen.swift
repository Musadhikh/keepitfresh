//
//  ReviewProductScreen.swift
//  keepitfresh
//
//  Created by musadhikh on 20/2/26.
//  Summary: Unified review/edit form with field locking and confidence badges.
//

import SwiftUI

struct ReviewProductScreen: View {
    @Binding var draft: ProductDraft
    let onSave: () -> Void
    let onSaveAndAddAnother: () -> Void
    let onBack: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.s12) {
                HStack {
                    Button("Back", action: onBack)
                        .font(Theme.Fonts.body(15, weight: .semibold, relativeTo: .headline))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    Spacer()
                }

                Text("Review Product")
                    .font(Theme.Fonts.title)
                    .foregroundStyle(Theme.Colors.textPrimary)

                fieldSection(
                    title: "Barcode",
                    field: .barcode,
                    confidence: draft.fieldConfidences[.barcode]
                ) {
                    TextField(
                        "Barcode",
                        text: Binding(
                            get: { draft.barcode?.value ?? "" },
                            set: { draft.barcode = $0.isEmpty ? nil : Barcode(value: $0, symbology: .unknown) }
                        )
                    )
                    .textInputAutocapitalization(.never)
                    .keyboardType(.asciiCapable)
                }

                fieldSection(title: "Title", field: .title, confidence: draft.fieldConfidences[.title]) {
                    TextField("Title", text: Binding(get: { draft.title ?? "" }, set: { draft.title = $0.isEmpty ? nil : $0 }))
                }

                fieldSection(title: "Brand", field: .brand, confidence: draft.fieldConfidences[.brand]) {
                    TextField("Brand", text: Binding(get: { draft.brand ?? "" }, set: { draft.brand = $0.isEmpty ? nil : $0 }))
                }

                fieldSection(title: "Description", field: .description, confidence: draft.fieldConfidences[.description]) {
                    TextField("Description", text: Binding(get: { draft.description ?? "" }, set: { draft.description = $0.isEmpty ? nil : $0 }), axis: .vertical)
                        .lineLimit(3)
                }

                fieldSection(title: "Categories (comma separated)", field: .categories, confidence: draft.fieldConfidences[.categories]) {
                    TextField("Categories", text: Binding(get: {
                        (draft.categories ?? []).joined(separator: ", ")
                    }, set: {
                        let values = $0.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
                        draft.categories = values.isEmpty ? nil : values
                    }))
                }

                fieldSection(title: "Category", field: .category, confidence: nil) {
                    Picker(
                        "Category",
                        selection: Binding(
                            get: { draft.category?.main ?? .other },
                            set: { newValue in
                                draft.category = ProductCategory(main: newValue, subCategory: draft.category?.subCategory)
                                ensureProductDetailShape(for: newValue)
                            }
                        )
                    ) {
                        ForEach(MainCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }

                fieldSection(title: "Subcategory", field: .category, confidence: nil) {
                    TextField(
                        "Optional subcategory",
                        text: Binding(
                            get: { draft.category?.subCategory ?? "" },
                            set: { draft.category = ProductCategory(main: draft.category?.main ?? .other, subCategory: $0.isEmpty ? nil : $0) }
                        )
                    )
                }

                categoryDetailSection

                fieldSection(title: "Size", field: .size, confidence: draft.fieldConfidences[.size]) {
                    TextField("Size", text: Binding(get: { draft.size ?? "" }, set: { draft.size = $0.isEmpty ? nil : $0 }))
                }

                fieldSection(title: "Quantity", field: .quantity, confidence: nil) {
                    Stepper(value: $draft.quantity, in: 1 ... 999) {
                        Text("\(draft.quantity)")
                    }
                }

                fieldSection(title: "Number of Items", field: .numberOfItems, confidence: nil) {
                    Stepper(value: $draft.numberOfItems, in: 1 ... 999) {
                        Text("\(draft.numberOfItems)")
                    }
                }

                fieldSection(title: "Unit", field: .unit, confidence: nil) {
                    TextField("pcs / pack / bottle", text: Binding(get: { draft.unit ?? "" }, set: { draft.unit = $0.isEmpty ? nil : $0 }))
                }

                fieldSection(title: "Date Info", field: .dateEntries, confidence: nil) {
                    VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                        ForEach(draft.dateEntries.indices, id: \.self) { index in
                            VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                                Picker(
                                    "Date Kind",
                                    selection: Binding(
                                        get: { draft.dateEntries[index].kind },
                                        set: { draft.dateEntries[index].kind = $0 }
                                    )
                                ) {
                                    ForEach(ProductDateInfo.Kind.allCases, id: \.self) { kind in
                                        Text(kind.rawValue).tag(kind)
                                    }
                                }
                                .pickerStyle(.menu)

                                Picker(
                                    "Input Mode",
                                    selection: Binding(
                                        get: { draft.dateEntries[index].inputMode },
                                        set: { draft.dateEntries[index].inputMode = $0 }
                                    )
                                ) {
                                    Text("Manual Calendar").tag(ProductDraftDateInputMode.manualCalendar)
                                    Text("Scan Image").tag(ProductDraftDateInputMode.scanImage)
                                }
                                .pickerStyle(.segmented)

                                if draft.dateEntries[index].inputMode == .manualCalendar {
                                    DatePicker(
                                        "Select Date",
                                        selection: Binding(
                                            get: { draft.dateEntries[index].value ?? Date() },
                                            set: { draft.dateEntries[index].value = $0 }
                                        ),
                                        displayedComponents: .date
                                    )
                                } else {
                                    Button("Scan date from image") {
                                        // TODO: Integrate image date scanner for date fields.
                                    }
                                    .buttonStyle(.bordered)
                                }
                            }
                            .padding(Theme.Spacing.s8)
                            .background(Theme.Colors.surfaceAlt)
                            .clipShape(.rect(cornerRadius: Theme.Radius.r12))
                        }

                        HStack(spacing: Theme.Spacing.s8) {
                            Button("Add date") {
                                draft.dateEntries.append(ProductDraftDateEntry(kind: .unknown))
                            }
                            .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .caption))
                            .foregroundStyle(Theme.Colors.textPrimary)

                            Button("Clear") {
                                draft.dateEntries.removeAll()
                            }
                            .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .caption))
                            .foregroundStyle(Theme.Colors.textSecondary)
                        }
                    }
                }

                fieldSection(title: "Notes", field: .notes, confidence: nil) {
                    TextField("Optional notes", text: Binding(get: { draft.notes ?? "" }, set: { draft.notes = $0.isEmpty ? nil : $0 }), axis: .vertical)
                        .lineLimit(3)
                }
            }
            .padding(Theme.Spacing.s16)
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: Theme.Spacing.s12) {
                Button("Save", action: onSave)
                    .primaryButtonStyle(height: 48)

                Button("Save & Add Another", action: onSaveAndAddAnother)
                    .font(Theme.Fonts.body(14, weight: .semibold, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Theme.Colors.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.Radius.r16)
                            .stroke(Theme.Colors.border, lineWidth: 1)
                    )
                    .clipShape(.rect(cornerRadius: Theme.Radius.r16))
            }
            .padding(.horizontal, Theme.Spacing.s16)
            .padding(.vertical, Theme.Spacing.s12)
            .background(Theme.Colors.background)
        }
        .background(Theme.Colors.background)
    }

    @ViewBuilder
    private func fieldSection<Content: View>(
        title: String,
        field: ProductField,
        confidence: Double?,
        @ViewBuilder content: () -> Content
    ) -> some View {
        LockedFieldView(title: title, isLocked: draft.lockedFields.contains(field)) {
            VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                HStack {
                    ConfidenceBadgeView(confidence: confidence)
                    Spacer()
                }
                content()
                    .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .padding(Theme.Spacing.s12)
                    .background(Theme.Colors.surfaceAlt)
                    .clipShape(.rect(cornerRadius: Theme.Radius.r12))
            }
        }
    }

    @ViewBuilder
    private var categoryDetailSection: some View {
        switch draft.category?.main {
        case .food, .beverage:
            fieldSection(title: "Food Details", field: .productDetail, confidence: nil) {
                VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                    TextField(
                        "Ingredients (comma separated)",
                        text: Binding(
                            get: { foodDetail?.ingredients.joined(separator: ", ") ?? "" },
                            set: { setFoodIngredients(from: $0) }
                        )
                    )
                    TextField(
                        "Allergens (comma separated)",
                        text: Binding(
                            get: { foodDetail?.allergens.joined(separator: ", ") ?? "" },
                            set: { setFoodAllergens(from: $0) }
                        )
                    )
                }
            }
        case .household:
            fieldSection(title: "Household Details", field: .productDetail, confidence: nil) {
                TextField(
                    "Usage Instructions (comma separated)",
                    text: Binding(
                        get: { householdDetail?.usageInstructions.joined(separator: ", ") ?? "" },
                        set: { setHouseholdUsageInstructions(from: $0) }
                    )
                )
            }
        case .personalCare:
            fieldSection(title: "Personal Care Details", field: .productDetail, confidence: nil) {
                TextField(
                    "Usage Directions (comma separated)",
                    text: Binding(
                        get: { personalCareDetail?.usageDirections?.joined(separator: ", ") ?? "" },
                        set: { setPersonalCareUsageDirections(from: $0) }
                    )
                )
            }
        default:
            EmptyView()
        }
    }

    private var foodDetail: FoodDetail? {
        switch draft.productDetail {
        case .food(let detail), .beverage(let detail):
            return detail
        default:
            return nil
        }
    }

    private var householdDetail: HouseholdDetail? {
        guard case .household(let detail) = draft.productDetail else { return nil }
        return detail
    }

    private var personalCareDetail: PersonalCareDetail? {
        guard case .personalCare(let detail) = draft.productDetail else { return nil }
        return detail
    }

    private func ensureProductDetailShape(for category: MainCategory) {
        switch category {
        case .food:
            if case .food = draft.productDetail { return }
            draft.productDetail = .food(FoodDetail(ingredients: [], allergens: [], nutritionPer100gOrMl: nil, servingSize: nil, countryOfOrigin: nil))
        case .beverage:
            if case .beverage = draft.productDetail { return }
            draft.productDetail = .beverage(FoodDetail(ingredients: [], allergens: [], nutritionPer100gOrMl: nil, servingSize: nil, countryOfOrigin: nil))
        case .household:
            if case .household = draft.productDetail { return }
            draft.productDetail = .household(HouseholdDetail(usageInstructions: [], safetyWarnings: [], materials: []))
        case .personalCare:
            if case .personalCare = draft.productDetail { return }
            draft.productDetail = .personalCare(PersonalCareDetail(usageDirections: [], ingredients: [], warnings: [], skinType: []))
        default:
            draft.productDetail = .other(nil)
        }
    }

    private func setFoodIngredients(from rawValue: String) {
        let values = commaSplit(rawValue)
        var detail = foodDetail ?? FoodDetail(ingredients: [], allergens: [], nutritionPer100gOrMl: nil, servingSize: nil, countryOfOrigin: nil)
        detail.ingredients = values

        switch draft.category?.main {
        case .beverage:
            draft.productDetail = .beverage(detail)
        default:
            draft.productDetail = .food(detail)
        }
    }

    private func setFoodAllergens(from rawValue: String) {
        let values = commaSplit(rawValue)
        var detail = foodDetail ?? FoodDetail(ingredients: [], allergens: [], nutritionPer100gOrMl: nil, servingSize: nil, countryOfOrigin: nil)
        detail.allergens = values

        switch draft.category?.main {
        case .beverage:
            draft.productDetail = .beverage(detail)
        default:
            draft.productDetail = .food(detail)
        }
    }

    private func setHouseholdUsageInstructions(from rawValue: String) {
        let values = commaSplit(rawValue)
        var detail = householdDetail ?? HouseholdDetail(usageInstructions: [], safetyWarnings: [], materials: [])
        detail.usageInstructions = values
        draft.productDetail = .household(detail)
    }

    private func setPersonalCareUsageDirections(from rawValue: String) {
        let values = commaSplit(rawValue)
        var detail = personalCareDetail ?? PersonalCareDetail(usageDirections: [], ingredients: [], warnings: [], skinType: [])
        detail.usageDirections = values
        draft.productDetail = .personalCare(detail)
    }

    private func commaSplit(_ value: String) -> [String] {
        value
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}
