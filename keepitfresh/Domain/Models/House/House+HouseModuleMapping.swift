//
//  House+HouseModuleMapping.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Maps HouseModule household models to app-level house models.
//

import Foundation
import HouseModule

extension House {
    init(moduleHousehold household: Household) {
        self.init(
            id: household.id,
            name: household.name,
            description: household.description,
            memberIds: household.memberIds,
            ownerId: household.ownerId,
            createdAt: household.createdAt,
            updatedAt: household.updatedAt
        )
    }
}
