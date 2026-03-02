//
//  AddProductManualAddView.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: S5 manual add form for product details, expiry, storage, and quantity defaults.
//

import SwiftUI

struct AddProductManualAddView: View {
    @Binding var draft: ProductDraft
    let onBack: () -> Void
    let onContinue: () -> Void

    @State private var storageSelection: InventoryStorageChoice = .pantry

    enum InventoryStorageChoice: String, CaseIterable, Identifiable {
        case freezer
        case fridge
        case pantry

        var id: String { rawValue }
        var title: String {
            switch self {
            case .freezer: return "Freezer"
            case .fridge: return "Fridge"
            case .pantry: return "Pantry"
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
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

                Text("Manual Add")
                    .font(Theme.Fonts.title)
                    .foregroundStyle(Theme.Colors.textPrimary)

                AddProductGlassCardView {
                    Text("Product Details")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    TextField("Product Name", text: bindString(\.title))
                        .textFieldStyle(.roundedBorder)
                    Picker("Category", selection: categorySelection) {
                        ForEach(MainCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                    TextField("Brand", text: bindString(\.brand))
                        .textFieldStyle(.roundedBorder)
                }

                AddProductGlassCardView {
                    Text("Expiry")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    DatePicker("Expiry Date", selection: expiryDateSelection, displayedComponents: .date)
                    HStack(spacing: Theme.Spacing.s8) {
                        quickDateChip(title: "+3 days", daysToAdd: 3)
                        quickDateChip(title: "+7 days", daysToAdd: 7)
                        quickDateChip(title: "+30 days", daysToAdd: 30)
                    }
                }

                AddProductGlassCardView {
                    Text("Storage")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    Picker("Storage", selection: $storageSelection) {
                        ForEach(InventoryStorageChoice.allCases) { choice in
                            Text(choice.title).tag(choice)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                AddProductGlassCardView {
                    Text("Quantity")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    Stepper(value: $draft.quantity, in: 1 ... 500) {
                        Text("\(draft.quantity)")
                    }
                    Picker("Unit", selection: bindString(\.unit, defaultValue: "Count")) {
                        Text("Count").tag("Count")
                        Text("Weight").tag("Weight")
                        Text("Volume").tag("Volume")
                    }
                    .pickerStyle(.segmented)
                }

                Toggle("Save as reusable product", isOn: .constant(true))
                    .font(Theme.Fonts.body(14, weight: .regular, relativeTo: .subheadline))
            }
            .padding(Theme.Spacing.s16)
        }
        .safeAreaInset(edge: .bottom) {
            Button("Add to Inventory", action: onContinue)
                .primaryButtonStyle(height: 50)
                .accessibilityIdentifier("addFlow.manualAdd.continue")
                .padding(.horizontal, Theme.Spacing.s16)
                .padding(.vertical, Theme.Spacing.s12)
                .background(Theme.Colors.background)
        }
        .background(Theme.Colors.background)
    }

    private var categorySelection: Binding<MainCategory> {
        Binding(
            get: { draft.category?.main ?? .other },
            set: { draft.category = ProductCategory(main: $0, subCategory: draft.category?.subCategory) }
        )
    }

    private var expiryDateSelection: Binding<Date> {
        Binding(
            get: {
                draft.dateEntries.first(where: { $0.kind == .expiry })?.value ?? Date()
            },
            set: { newDate in
                if let idx = draft.dateEntries.firstIndex(where: { $0.kind == .expiry }) {
                    draft.dateEntries[idx].value = newDate
                } else {
                    draft.dateEntries.append(.init(kind: .expiry, value: newDate, inputMode: .manualCalendar))
                }
            }
        )
    }

    private func bindString(
        _ keyPath: WritableKeyPath<ProductDraft, String?>,
        defaultValue: String = ""
    ) -> Binding<String> {
        Binding(
            get: { draft[keyPath: keyPath] ?? defaultValue },
            set: { draft[keyPath: keyPath] = $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : $0 }
        )
    }

    private func quickDateChip(title: String, daysToAdd: Int) -> some View {
        Button(title) {
            let calendar = Calendar(identifier: .gregorian)
            let date = calendar.date(byAdding: .day, value: daysToAdd, to: Date()) ?? Date()
            expiryDateSelection.wrappedValue = date
        }
        .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
        .foregroundStyle(Theme.Colors.textPrimary)
        .padding(.horizontal, Theme.Spacing.s8)
        .padding(.vertical, Theme.Spacing.s8)
        .background(Theme.Colors.surfaceAlt)
        .clipShape(.capsule)
    }
}
