// swift-tools-version: 6.2
//
//  Package.swift
//  keepitfresh
//
//  Created by musadhikh on 28/2/26.
//  Summary: Declares InventoryModule package with domain, application, data, and facade targets.
//

import PackageDescription

let package = Package(
    name: "InventoryModule",
    platforms: [
        .iOS(.v26),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "InventoryModule",
            targets: ["InventoryModule"]
        )
    ],
    targets: [
        .target(
            name: "InventoryDomain"
        ),
        .target(
            name: "InventoryApplication",
            dependencies: ["InventoryDomain"]
        ),
        .target(
            name: "InventoryData",
            dependencies: ["InventoryDomain"]
        ),
        .target(
            name: "InventoryModule",
            dependencies: ["InventoryDomain", "InventoryApplication", "InventoryData"]
        ),
        .testTarget(
            name: "InventoryDomainTests",
            dependencies: ["InventoryDomain"]
        ),
        .testTarget(
            name: "InventoryApplicationTests",
            dependencies: ["InventoryApplication", "InventoryData", "InventoryDomain"]
        ),
        .testTarget(
            name: "InventoryDataTests",
            dependencies: ["InventoryData"]
        )
    ]
)
