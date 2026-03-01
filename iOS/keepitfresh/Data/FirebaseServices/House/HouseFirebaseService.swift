//
//  HouseFirebaseService.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Implements household fetch/create operations against Firestore.
//

import FirebaseFirestore
import Foundation

actor HouseFirebaseService: HouseProviding {
    private let db = Firestore.firestore()
    
    func getHouse(for houseId: String) async throws -> House? {
        if FirebaseWritePolicy.isMockWriteEnabled,
           let mockedHouse = await DebugFirestoreStore.shared.getHouseIfPresent(id: houseId) {
            return mockedHouse
        }

        let document = try await db
            .collection(FirebaseConstants.Collections.houses)
            .document(houseId)
            .getDocument()
        
        guard document.exists else {
            return nil
        }
        
        return try document.data(as: House.self)
    }
    
    func getHouses(for houseIds: [String]) async throws -> [House] {
        guard !houseIds.isEmpty else { return [] }

        if FirebaseWritePolicy.isMockWriteEnabled {
            let mocked = await DebugFirestoreStore.shared.getHouses(ids: houseIds)
            let mockedByID = Dictionary(uniqueKeysWithValues: mocked.map { ($0.id, $0) })
            let missingIDs = houseIds.filter { mockedByID[$0] == nil }
            let remote = try await fetchRemoteHouses(for: missingIDs)
            let remoteByID = Dictionary(uniqueKeysWithValues: remote.map { ($0.id, $0) })
            return houseIds.compactMap { mockedByID[$0] ?? remoteByID[$0] }
        }
        
        return try await fetchRemoteHouses(for: houseIds)
    }
    
    func createHouse(
        name: String,
        description: String?,
        ownerId: String,
        memberIds: [String]
    ) async throws -> House {
        if FirebaseWritePolicy.isMockWriteEnabled {
            return await DebugFirestoreStore.shared.createHouse(
                name: name,
                description: description,
                ownerId: ownerId,
                memberIds: memberIds
            )
        }

        let document = db.collection(FirebaseConstants.Collections.houses).document()
        let now = Date()
        let house = House(
            id: document.documentID,
            name: name,
            description: description,
            memberIds: memberIds,
            ownerId: ownerId,
            createdAt: now,
            updatedAt: now
        )
        
        try await document.setData(house.toFirebaseDictionary())
        return house
    }

    private func fetchRemoteHouses(for houseIds: [String]) async throws -> [House] {
        guard !houseIds.isEmpty else { return [] }

        var loaded: [House] = []
        for batch in houseIds.chunked(into: 10) {
            let snapshot = try await db
                .collection(FirebaseConstants.Collections.houses)
                .whereField(FieldPath.documentID(), in: batch)
                .getDocuments()

            let houses = try snapshot.documents.map { document in
                try document.data(as: House.self)
            }
            loaded.append(contentsOf: houses)
        }

        let byId = Dictionary(uniqueKeysWithValues: loaded.map { ($0.id, $0) })
        return houseIds.compactMap { byId[$0] }
    }
}

private enum HouseServiceError: LocalizedError {
    case houseNotFound(String)
    
    var errorDescription: String? {
        switch self {
        case .houseNotFound(let houseID):
            return "House not found for id: \(houseID)"
        }
    }
}

private extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [self] }
        var result: [[Element]] = []
        result.reserveCapacity((count + size - 1) / size)
        
        var index = startIndex
        while index < endIndex {
            let nextIndex = self.index(index, offsetBy: size, limitedBy: endIndex) ?? endIndex
            result.append(Array(self[index..<nextIndex]))
            index = nextIndex
        }
        return result
    }
}
