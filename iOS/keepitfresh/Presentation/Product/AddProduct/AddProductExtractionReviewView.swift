//
//  AddProductExtractionReviewView.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: S3 extraction review sheet that edits extracted fields before confirmation.
//

import SwiftUI

struct AddProductExtractionReviewView: View {
    @Binding var draft: AddProductExtractionReviewDraft
    let onContinue: () -> Void
    let onBack: () -> Void

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

                Text("Review Details")
                    .font(Theme.Fonts.title)
                    .foregroundStyle(Theme.Colors.textPrimary)

                AddProductGlassCardView {
                    Text("Product Info")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    TextField("Product Name", text: $draft.productName)
                        .textFieldStyle(.roundedBorder)
                    categoryPicker
                    TextField("Brand", text: $draft.brand)
                        .textFieldStyle(.roundedBorder)
                }

                AddProductGlassCardView {
                    Text("Dates")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    DatePicker("Expiry Date", selection: $draft.expiryDate, displayedComponents: .date)
                    Toggle("Include Manufactured Date", isOn: $draft.includeManufacturedDate)
                    if draft.includeManufacturedDate {
                        DatePicker("Manufactured Date", selection: $draft.manufacturedDate, displayedComponents: .date)
                    }
                }

                AddProductGlassCardView {
                    Text("Barcode")
                        .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
                    TextField("Barcode", text: $draft.barcode)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.asciiCapable)
                }
            }
            .padding(Theme.Spacing.s16)
        }
        .safeAreaInset(edge: .bottom) {
            Button("Continue", action: onContinue)
                .primaryButtonStyle(height: 50)
                .padding(.horizontal, Theme.Spacing.s16)
                .padding(.vertical, Theme.Spacing.s12)
                .background(Theme.Colors.background)
        }
        .background(Theme.Colors.background)
    }

    private var categoryPicker: some View {
        Picker("Category", selection: $draft.category) {
            ForEach(MainCategory.allCases, id: \.self) { category in
                Text(category.rawValue.capitalized)
                    .tag(category)
            }
        }
        .pickerStyle(.menu)

    }
}
