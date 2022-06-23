// swift-tools-version:5.3
//
//  Package.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "DNSCore",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DNSCore",
            type: .static,
            targets: ["DNSCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/DoubleNodeOpen/AtomicSwift.git", from: "1.2.2"),
        .package(url: "https://github.com/DoubleNode/DNSCoreThreading.git", from: "1.8.0"),
        .package(url: "https://github.com/DoubleNode/DNSError.git", from: "1.8.0"),
        .package(url: "https://github.com/Nirma/SFSymbol", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DNSCore",
            dependencies: ["AtomicSwift", "DNSCoreThreading", "DNSError", "SFSymbol"],
            resources: [
                .process("Resources"),
            ]),
        .testTarget(
            name: "DNSCoreTests",
            dependencies: ["DNSCore"],
            exclude: ["TestViewController.xib"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
