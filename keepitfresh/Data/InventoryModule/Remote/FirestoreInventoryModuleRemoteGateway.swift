//
//  FirestoreInventoryModuleRemoteGateway.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Firestore-backed InventoryModule remote gateway scoped under each house document.
//

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif
import Foundation
import InventoryModule

typealias IMRemoteItem = InventoryModuleTypes.InventoryItem

enum FirestoreInventoryModuleRemoteGatewayError: LocalizedError {
    case firestoreUnavailable

    var errorDescription: String? {
        switch self {
        case .firestoreUnavailable:
            return "Firestore is unavailable for InventoryModule remote operations."
        }
    }
}

actor FirestoreInventoryModuleRemoteGateway: InventoryModuleTypes.InventoryRemoteGateway {
#if canImport(FirebaseFirestore)
    private let db: Firestore

    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }
#else
    init() {}
#endif

    func upsert(_ items: [IMRemoteItem]) async throws {
#if canImport(FirebaseFirestore)
        guard items.isEmpty == false else { return }

        if FirebaseWritePolicy.isMockWriteEnabled {
            return
        }

        for chunk in items.chunked(into: 400) {
            let batch = db.batch()
            for item in chunk {
                let reference = itemDocument(
                    householdId: item.householdId,
                    itemId: item.id
                )
                let payload = try FirestoreCodableHelpers.encode(item)
                batch.setData(payload, forDocument: reference, merge: true)
            }
            try await batch.commit()
        }
#else
        _ = items
        throw FirestoreInventoryModuleRemoteGatewayError.firestoreUnavailable
#endif
    }

    func fetchActiveItems(householdId: String) async throws -> [IMRemoteItem] {
#if canImport(FirebaseFirestore)
        guard householdId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            return []
        }

        let snapshot = try await itemsCollection(householdId: householdId)
            .whereField("status", isEqualTo: "active")
            .getDocuments()

        return try snapshot.documents.map { document in
            try FirestoreCodableHelpers.decodeDocument(
                IMRemoteItem.self,
                from: document,
                injectingDocumentIdTo: "id"
            )
        }
#else
        _ = householdId
        throw FirestoreInventoryModuleRemoteGatewayError.firestoreUnavailable
#endif
    }
}

extension FirestoreInventoryModuleRemoteGateway {
    static func houseItemsCollectionPath(householdId: String) -> String {
        "\(FirebaseConstants.Collections.houses)/\(householdId)/\(FirebaseConstants.Collections.items)"
    }
}

#if canImport(FirebaseFirestore)
private extension FirestoreInventoryModuleRemoteGateway {
    func housesCollection() -> CollectionReference {
        db.collection(FirebaseConstants.Collections.houses)
    }

    func itemsCollection(householdId: String) -> CollectionReference {
        housesCollection().document(householdId).collection(FirebaseConstants.Collections.items)
    }

    func itemDocument(householdId: String, itemId: String) -> DocumentReference {
        itemsCollection(householdId: householdId)
            .document(itemId)
    }
}

private extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0, isEmpty == false else { return [self] }

        var chunks: [[Element]] = []
        chunks.reserveCapacity((count + size - 1) / size)

        var index = startIndex
        while index < endIndex {
            let next = self.index(index, offsetBy: size, limitedBy: endIndex) ?? endIndex
            chunks.append(Array(self[index..<next]))
            index = next
        }
        return chunks
    }
}
#endif
