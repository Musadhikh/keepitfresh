// swift-tools-version: 6.2
//
//  Package.swift
//  keepitfresh
//
//  Created by musadhikh on 27/2/26.
//  Summary: Declares ProductModule package with domain, application, and facade targets.
//

import PackageDescription

let package = Package(
    name: "ProductModule",
    platforms: [
        .iOS(.v26),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "ProductModule",
            targets: ["ProductModule"]
        )
    ],
    targets: [
        .target(
            name: "ProductDomain"
        ),
        .target(
            name: "ProductApplication",
            dependencies: ["ProductDomain"]
        ),
        .target(
            name: "ProductModule",
            dependencies: ["ProductDomain", "ProductApplication"]
        ),
        .testTarget(
            name: "ProductModuleTests",
            dependencies: ["ProductModule"]
        )
    ]
)
