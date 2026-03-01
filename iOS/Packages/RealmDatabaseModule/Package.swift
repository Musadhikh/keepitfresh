// swift-tools-version: 6.2
//
//  Package.swift
//  RealmDatabaseModule
//
//  Created by musadhikh on 22/2/26.
//  Summary: Clean-architecture Realm persistence module with actor-isolated repository APIs.
//

import PackageDescription

let package = Package(
    name: "RealmDatabaseModule",
    platforms: [
        .iOS(.v26),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "RealmDatabaseModule",
            targets: ["RealmDatabaseModule"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.54.0")
    ],
    targets: [
        .target(
            name: "RealmDatabaseModule",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        ),
        .testTarget(
            name: "RealmDatabaseModuleTests",
            dependencies: [
                "RealmDatabaseModule",
                .product(name: "RealmSwift", package: "realm-swift")
            ]
        )
    ]
)
