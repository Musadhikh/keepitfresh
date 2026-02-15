// swift-tools-version: 6.2
//
//  Package.swift
//  keepitfresh
//
//  Created by musadhikh on 15/2/26.
//  Summary: Declares the CameraModule Swift package for camera capture and scanner UI.
//

import PackageDescription

let package = Package(
    name: "CameraModule",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "CameraModule",
            targets: ["CameraModule"]
        )
    ],
    targets: [
        .target(
            name: "CameraModule"
        )
    ]
)
