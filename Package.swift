// swift-tools-version:5.7
//
//  Package.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "DNSCore",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .tvOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
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
        .package(url: "https://github.com/DoubleNode/DNSCoreThreading.git", from: "1.11.1"),
        .package(url: "https://github.com/DoubleNode/DNSError.git", from: "1.11.1"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "4.0.2"),
        .package(url: "https://github.com/Nirma/SFSymbol", from: "2.3.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.58.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DNSCore",
            dependencies: ["AtomicSwift", "DNSCoreThreading", "DNSError", "PhoneNumberKit", "SFSymbol"],
            resources: [
                .process("Resources"),
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins"),
            ]),
        .testTarget(
            name: "DNSCoreTests",
            dependencies: ["DNSCore"],
            exclude: ["TestViewController.xib"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
