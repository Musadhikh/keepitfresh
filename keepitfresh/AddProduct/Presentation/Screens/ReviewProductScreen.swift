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

                fieldSection(title: "Size", field: .size, confidence: draft.fieldConfidences[.size]) {
                    TextField("Size", text: Binding(get: { draft.size ?? "" }, set: { draft.size = $0.isEmpty ? nil : $0 }))
                }

                fieldSection(title: "Quantity", field: .quantity, confidence: nil) {
                    Stepper(value: $draft.quantity, in: 1 ... 999) {
                        Text("\(draft.quantity)")
                    }
                }

                fieldSection(title: "Unit", field: .unit, confidence: nil) {
                    TextField("pcs / pack / bottle", text: Binding(get: { draft.unit ?? "" }, set: { draft.unit = $0.isEmpty ? nil : $0 }))
                }

                fieldSection(title: "Date Info", field: .dateInfo, confidence: nil) {
                    VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                        ForEach(Array(draft.dateInfo.enumerated()), id: \.offset) { index, info in
                            VStack(alignment: .leading, spacing: Theme.Spacing.s8) {
                                Picker("Date Kind", selection: Binding(
                                    get: { draft.dateInfo[index].kind },
                                    set: { draft.dateInfo[index].kind = $0 }
                                )) {
                                    ForEach(DateKind.allCases, id: \.self) { kind in
                                        Text(kind.rawValue).tag(kind)
                                    }
                                }

                                TextField("Raw date text", text: Binding(
                                    get: { draft.dateInfo[index].rawText ?? "" },
                                    set: { draft.dateInfo[index].rawText = $0.isEmpty ? nil : $0 }
                                ))

                                if let isoDate = info.isoDate {
                                    Text("ISO: \(isoDate.formatted(date: .abbreviated, time: .omitted))")
                                        .font(Theme.Fonts.caption)
                                        .foregroundStyle(Theme.Colors.textSecondary)
                                }
                            }
                            .padding(Theme.Spacing.s8)
                            .background(Theme.Colors.surfaceAlt)
                            .clipShape(.rect(cornerRadius: Theme.Radius.r12))
                        }

                        HStack(spacing: Theme.Spacing.s8) {
                            Button("Add date") {
                                draft.dateInfo.append(DateInfo(kind: .unknown, rawText: nil, isoDate: nil, confidence: nil))
                            }
                            .font(Theme.Fonts.body(13, weight: .semibold, relativeTo: .caption))
                            .foregroundStyle(Theme.Colors.textPrimary)

                            Button("Clear") {
                                draft.dateInfo.removeAll()
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
}
