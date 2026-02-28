//
//  InventoryMergePolicyEvaluator.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Evaluates whether two inventory batches are eligible to merge.
//

import Foundation
import InventoryDomain

public enum InventoryMergePolicyEvaluator {
    public static func key(for item: InventoryItem) -> InventoryMergeKey {
        InventoryMergeKey(
            householdId: item.householdId,
            productId: item.productRef.productId,
            expiryDate: item.expiryInfo?.isoDate,
            openedAt: item.openedInfo?.isoDate,
            storageLocationId: item.storageLocationId,
            lotOrBatchCode: item.lotOrBatchCode
        )
    }

    public static func canMerge(existing item: InventoryItem, with key: InventoryMergeKey) -> Bool {
        item.status == .active && self.key(for: item) == key
    }
}
