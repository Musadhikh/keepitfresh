//
//  Profile+Sync.swift
//  keepitfresh
//
//  Created by musadhikh on 22/2/26.
//  Summary: Provides profile normalization helpers used by offline-first sync logic.
//

import Foundation

extension Profile {
    /// Returns a remote-safe profile payload by stripping local-only fields.
    func remoteNormalized() -> Profile {
        Profile(
            id: id,
            userId: userId,
            name: name,
            email: email,
            avatarURL: avatarURL,
            householdIds: householdIds,
            lastSelectedHouseholdId: nil,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }

    /// Returns a copy with a local-only selected household value.
    func withLocalSelectedHouseholdId(_ householdId: String?) -> Profile {
        Profile(
            id: id,
            userId: userId,
            name: name,
            email: email,
            avatarURL: avatarURL,
            householdIds: householdIds,
            lastSelectedHouseholdId: householdId,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

