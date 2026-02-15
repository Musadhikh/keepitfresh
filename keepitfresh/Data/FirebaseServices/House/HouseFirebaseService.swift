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
    
    func getHouse(for houseId: String) async throws -> House {
        let document = try await db
            .collection(FirebaseConstants.Collections.houses)
            .document(houseId)
            .getDocument()
        
        guard document.exists else {
            throw HouseServiceError.houseNotFound(houseId)
        }
        
        return try document.data(as: House.self)
    }
    
    func getHouses(for houseIds: [String]) async throws -> [House] {
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
    
    func createHouse(
        name: String,
        description: String?,
        ownerId: String,
        memberIds: [String]
    ) async throws -> House {
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
