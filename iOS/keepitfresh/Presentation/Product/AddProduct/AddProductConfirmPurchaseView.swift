//
//  AddProductConfirmPurchaseView.swift
//  keepitfresh
//
//  Created by musadhikh on 2/3/26.
//  Summary: S6 confirm purchase screen for final quantity/date/storage/reminder edits before save.
//

import SwiftUI

struct AddProductConfirmPurchaseView: View {
    @Binding var draft: ProductDraft
    let isSaving: Bool
    let onBack: () -> Void
    let onSaveDraft: () -> Void
    let onAddToInventory: () -> Void

    @State private var storageChoice: StorageChoice = .pantry
    @State private var locationText: String = ""
    @State private var remindMe: Bool = true
    @State private var reminderChoice: ReminderChoice = .onExpiry
    @State private var showManufacturedDate = false

    enum StorageChoice: String, CaseIterable, Identifiable {
        case freezer
        case fridge
        case pantry

        var id: String { rawValue }
        var title: String { rawValue.capitalized }
    }

    enum ReminderChoice: String, CaseIterable, Identifiable {
        case onExpiry
        case oneDayBefore
        case threeDaysBefore
        case custom

        var id: String { rawValue }

        var title: String {
            switch self {
            case .onExpiry: return "On expiry"
            case .oneDayBefore: return "1 day before"
            case .threeDaysBefore: return "3 days before"
            case .custom: return "Custom"
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.s16) {
                navHeader
                hero
                quantityCard
                expiryCard
                storageCard
                remindersCard
                notesCard
            }
            .padding(Theme.Spacing.s16)
        }
        .safeAreaInset(edge: .bottom) {
            bottomActions
        }
        .background(Theme.Colors.background)
        .navigationTitle(draft.title?.nilIfEmpty ?? "Confirm Purchase")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var navHeader: some View {
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
    }

    private var hero: some View {
        HStack(spacing: Theme.Spacing.s12) {
            Image(icon: .productCategory)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Theme.Colors.accent)
                .frame(width: 56, height: 56)
                .background(Theme.Colors.accentSoft)
                .clipShape(.circle)

            VStack(alignment: .leading, spacing: Theme.Spacing.s4) {
                Text(draft.title?.nilIfEmpty ?? "Untitled Product")
                    .font(Theme.Fonts.body(18, weight: .semibold, relativeTo: .title3))
                    .foregroundStyle(Theme.Colors.textPrimary)
                Text((draft.category?.main.rawValue.capitalized ?? "").nilIfEmpty ?? "Uncategorized")
                    .font(Theme.Fonts.body(13, weight: .regular, relativeTo: .caption))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
            Spacer()
        }
    }

    private var quantityCard: some View {
        AddProductGlassCardView {
            Text("Quantity")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
            Stepper(value: $draft.quantity, in: 1 ... 500) {
                Text("\(draft.quantity)")
            }
            Picker("Unit", selection: unitSelection) {
                Text("Count").tag("Count")
                Text("Weight").tag("Weight")
                Text("Volume").tag("Volume")
            }
            .pickerStyle(.segmented)
        }
    }

    private var expiryCard: some View {
        AddProductGlassCardView {
            Text("Expiry")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))

            DatePicker("Expiry Date", selection: expiryDateSelection, displayedComponents: .date)
            Toggle("Add manufactured date", isOn: $showManufacturedDate)
            if showManufacturedDate {
                DatePicker("Manufactured Date", selection: manufacturedDateSelection, displayedComponents: .date)
            }
            HStack(spacing: Theme.Spacing.s8) {
                quickDateChip("+3 days", daysToAdd: 3)
                quickDateChip("+7 days", daysToAdd: 7)
                quickDateChip("+30 days", daysToAdd: 30)
            }
        }
    }

    private var storageCard: some View {
        AddProductGlassCardView {
            Text("Storage")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
            Picker("Storage", selection: $storageChoice) {
                ForEach(StorageChoice.allCases) { choice in
                    Text(choice.title).tag(choice)
                }
            }
            .pickerStyle(.segmented)

            TextField("Optional location", text: $locationText)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var remindersCard: some View {
        AddProductGlassCardView {
            Toggle("Remind me", isOn: $remindMe)
                .font(Theme.Fonts.body(14, weight: .medium, relativeTo: .subheadline))

            if remindMe {
                Picker("Reminder", selection: $reminderChoice) {
                    ForEach(ReminderChoice.allCases) { choice in
                        Text(choice.title).tag(choice)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }

    private var notesCard: some View {
        AddProductGlassCardView {
            Text("Notes")
                .font(Theme.Fonts.body(16, weight: .semibold, relativeTo: .headline))
            TextField("Optional notes", text: notesSelection, axis: .vertical)
                .lineLimit(3)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var bottomActions: some View {
        VStack(spacing: Theme.Spacing.s8) {
            Button(action: onAddToInventory) {
                if isSaving {
                    ProgressView()
                        .tint(.white)
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Add to Inventory")
                }
            }
            .primaryButtonStyle(height: 50)
            .accessibilityIdentifier("addFlow.confirm.addToInventory")
            .disabled(isSaving)

            Button("Save Draft", action: onSaveDraft)
                .secondaryButtonStyle(height: 46)
                .disabled(isSaving)
        }
        .padding(.horizontal, Theme.Spacing.s16)
        .padding(.vertical, Theme.Spacing.s12)
        .background(Theme.Colors.background)
    }

    private var unitSelection: Binding<String> {
        Binding(
            get: { draft.unit?.nilIfEmpty ?? "Count" },
            set: { draft.unit = $0 }
        )
    }

    private var notesSelection: Binding<String> {
        Binding(
            get: { draft.notes ?? "" },
            set: { draft.notes = $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : $0 }
        )
    }

    private var expiryDateSelection: Binding<Date> {
        Binding(
            get: { draft.dateEntries.first(where: { $0.kind == .expiry })?.value ?? Date() },
            set: { setDate($0, kind: .expiry) }
        )
    }

    private var manufacturedDateSelection: Binding<Date> {
        Binding(
            get: { draft.dateEntries.first(where: { $0.kind == .manufactured })?.value ?? Date() },
            set: { setDate($0, kind: .manufactured) }
        )
    }

    private func quickDateChip(_ title: String, daysToAdd: Int) -> some View {
        Button(title) {
            let date = Calendar(identifier: .gregorian).date(byAdding: .day, value: daysToAdd, to: Date()) ?? Date()
            setDate(date, kind: .expiry)
        }
        .font(Theme.Fonts.body(12, weight: .semibold, relativeTo: .caption))
        .foregroundStyle(Theme.Colors.textPrimary)
        .padding(.horizontal, Theme.Spacing.s8)
        .padding(.vertical, Theme.Spacing.s8)
        .background(Theme.Colors.surfaceAlt)
        .clipShape(.capsule)
    }

    private func setDate(_ value: Date, kind: ProductDateInfo.Kind) {
        if let index = draft.dateEntries.firstIndex(where: { $0.kind == kind }) {
            draft.dateEntries[index].value = value
        } else {
            draft.dateEntries.append(.init(kind: kind, value: value, inputMode: .manualCalendar))
        }
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
