//
//  InventoryItemDetailView.swift
//  keepitfresh
//
//  Created by musadhikh on 1/3/26.
//  Summary: Simple detail screen for a single inventory batch item.
//

import SwiftUI
import InventoryModule

struct InventoryItemDetailView: View {
    let item: InventoryModuleTypes.InventoryItem

    var body: some View {
        List {
            Section("Product") {
                LabeledContent("Title", value: item.productRef.snapshot?.title?.trimmedNonEmpty ?? item.productRef.productId)
                LabeledContent("Product ID", value: item.productRef.productId)
                LabeledContent("Brand", value: item.productRef.snapshot?.brand?.trimmedNonEmpty ?? "-")
            }

            Section("Batch") {
                LabeledContent("Batch ID", value: item.id)
                LabeledContent("Status", value: item.status.rawValue.capitalized)
                LabeledContent("Quantity", value: "\(item.quantity.value.formatted()) \(item.quantity.unit.rawValue)")
                LabeledContent("Location", value: item.storageLocationId)
                LabeledContent("Lot/Batch Code", value: item.lotOrBatchCode?.trimmedNonEmpty ?? "-")
            }

            Section("Dates") {
                LabeledContent("Expiry", value: formattedDateInfo(item.expiryInfo))
                LabeledContent("Opened", value: formattedDateInfo(item.openedInfo))
                LabeledContent("Created", value: formattedDate(item.createdAt))
                LabeledContent("Updated", value: formattedDate(item.updatedAt))
                LabeledContent("Consumed", value: item.consumedAt.map(formattedDate) ?? "-")
            }

            if let notes = item.notes?.trimmedNonEmpty {
                Section("Notes") {
                    Text(notes)
                        .font(Theme.Fonts.bodyRegular)
                        .foregroundStyle(Theme.Colors.textPrimary)
                }
            }
        }
        .navigationTitle("Inventory Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formattedDateInfo(_ info: InventoryDateInfo?) -> String {
        guard let info else { return "-" }
        guard let isoDate = info.isoDate else {
            return info.rawText.isEmpty ? "-" : info.rawText
        }

        return "\(formattedDate(isoDate)) (\(Int((info.confidence * 100).rounded()))%)"
    }

    private func formattedDate(_ date: Date) -> String {
        date.formatted(.dateTime.year().month(.abbreviated).day())
    }
}

private extension String {
    var trimmedNonEmpty: String? {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        InventoryItemDetailView(
            item: InventoryModuleTypes.InventoryItem(
                id: "item-1",
                householdId: "house-1",
                productRef: ProductRef(
                    productId: "product-1",
                    snapshot: ProductRef.Snapshot(title: "Organic Eggs", imageURL: nil, brand: "Farm Fresh")
                ),
                quantity: .init(value: 12, unit: .piece),
                status: .active,
                storageLocationId: "fridge",
                lotOrBatchCode: "LOT-001",
                expiryInfo: .init(kind: .expiry, rawText: "2026-03-04", confidence: 0.98, isoDate: Date()),
                openedInfo: nil,
                notes: "Use before weekend",
                createdAt: Date(),
                updatedAt: Date(),
                consumedAt: nil
            )
        )
    }
}
#endif
