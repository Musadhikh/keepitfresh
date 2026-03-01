// swift-tools-version: 6.2
//
//  Package.swift
//  keepitfresh
//
//  Created by musadhikh on 19/2/26.
//  Summary: Declares the BarcodeScannerModule package for low-latency live barcode scanning.
//

import PackageDescription

let package = Package(
    name: "BarcodeScannerModule",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "BarcodeScannerModule",
            targets: ["BarcodeScannerModule"]
        )
    ],
    targets: [
        .target(
            name: "BarcodeScannerModule"
        ),
        .testTarget(
            name: "BarcodeScannerModuleTests",
            dependencies: ["BarcodeScannerModule"]
        )
    ]
)
