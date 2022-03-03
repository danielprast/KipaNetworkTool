// swift-tools-version:5.3
//
//  Package@5.3.swift
//  KipaNetworkTool
//
//  Created by Daniel Prastiwa on 03/03/22.
//

import PackageDescription

let package = Package(
    name: "KipaNetworkTool",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "KipaNetworkTool",
            targets: ["KipaNetworkTool"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "KipaNetworkTool",
            dependencies: []),
        .testTarget(
            name: "KipaNetworkingTests",
            dependencies: ["KipaNetworkTool"]),
    ]
)
