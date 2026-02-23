// swift-tools-version: 6.2
//
//  Package.swift
//  ImageDataModule
//
//  Created by musadhikh on 23/2/26.
//  Summary: Declares the ImageDataModule package for Vision extraction and FoundationModels generation.
//

import PackageDescription

let package = Package(
    name: "ImageDataModule",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        .library(
            name: "ImageDataModule",
            targets: ["ImageDataModule"]
        )
    ],
    targets: [
        .target(
            name: "ImageDataModule"
        ),
        .testTarget(
            name: "ImageDataModuleTests",
            dependencies: ["ImageDataModule"]
        )
    ]
)
