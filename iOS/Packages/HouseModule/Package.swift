// swift-tools-version: 6.2
//
//  Package.swift
//  HouseModule
//
//  Created by musadhikh on 15/2/26.
//  Summary: Declares the HouseModule Swift package for household domain logic with constructor-injected services.
//

import PackageDescription

let package = Package(
    name: "HouseModule",
    platforms: [
        .iOS(.v26),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "HouseModule",
            targets: ["HouseModule"]
        )
    ],
    targets: [
        .target(
            name: "HouseModule"
        ),
        .testTarget(
            name: "HouseModuleTests",
            dependencies: ["HouseModule"]
        )
    ]
)

