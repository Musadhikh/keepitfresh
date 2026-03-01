//
//  FirestoreDebugMockServices.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Debug-only in-memory mock providers that replace Firestore-backed metadata, profile, and house requests.
//

import Foundation

/// Shared in-memory store used by debug mock services to mimic Firestore documents.
actor DebugFirestoreStore {
    static let shared = DebugFirestoreStore()

    private var metadata = AppMetadata(
        message: "Debug mode metadata (Firestore mocked)",
        minimumVersion: "0.0.0",
        appStoreUrl: "",
        isUnderMaintenance: false
    )
    private var profiles: [String: Profile] = [:]
    private var houses: [String: House] = [:]

    func getMetadata() -> AppMetadata {
        metadata
    }

    func getProfile(userId: String) -> Profile? {
        profiles[userId]
    }

    func createProfile(_ profile: Profile) {
        profiles[profile.userId] = profile
    }

    func updateProfile(_ profile: Profile) {
        profiles[profile.userId] = profile
    }

    func deleteProfile(userId: String) {
        profiles[userId] = nil
    }

    func getHouse(id: String) throws -> House {
        guard let house = houses[id] else {
            throw DebugFirestoreStoreError.houseNotFound(id)
        }
        return house
    }

    func getHouseIfPresent(id: String) -> House? {
        houses[id]
    }

    func getHouses(ids: [String]) -> [House] {
        ids.compactMap { houses[$0] }
    }

    func createHouse(
        name: String,
        description: String?,
        ownerId: String,
        memberIds: [String]
    ) -> House {
        let now = Date()
        let id = "debug-house-\(UUID().uuidString)"
        let house = House(
            id: id,
            name: name,
            description: description,
            memberIds: memberIds,
            ownerId: ownerId,
            createdAt: now,
            updatedAt: now
        )
        houses[id] = house
        return house
    }
}

private enum DebugFirestoreStoreError: LocalizedError {
    case houseNotFound(String)

    var errorDescription: String? {
        switch self {
        case .houseNotFound(let houseID):
            return "Debug mock house not found for id: \(houseID)"
        }
    }
}

actor DebugAppMetadataService: AppMetadataProviding {
    private let store: DebugFirestoreStore

    init(store: DebugFirestoreStore = .shared) {
        self.store = store
    }

    func getAppMetadata() async throws -> AppMetadata {
        await store.getMetadata()
    }
}

actor DebugProfileService: ProfileProviding {
    private let store: DebugFirestoreStore

    init(store: DebugFirestoreStore = .shared) {
        self.store = store
    }

    func getProfile(for userId: String) async throws -> Profile? {
        await store.getProfile(userId: userId)
    }

    func create(profile: Profile) async throws {
        await store.createProfile(profile)
    }

    func update(profile: Profile) async throws {
        await store.updateProfile(profile)
    }

    func delete(userId: String) async throws {
        await store.deleteProfile(userId: userId)
    }
}

actor DebugHouseService: HouseProviding {
    private let store: DebugFirestoreStore

    init(store: DebugFirestoreStore = .shared) {
        self.store = store
    }

    func getHouse(for houseId: String) async throws -> House? {
        try await store.getHouse(id: houseId)
    }

    func getHouses(for houseIds: [String]) async throws -> [House] {
        await store.getHouses(ids: houseIds)
    }

    func createHouse(
        name: String,
        description: String?,
        ownerId: String,
        memberIds: [String]
    ) async throws -> House {
        await store.createHouse(
            name: name,
            description: description,
            ownerId: ownerId,
            memberIds: memberIds
        )
    }
}
