// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DNSCore",
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
            targets: ["DNSCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/MarioIannotta/AtomicSwift.git", from: "1.2.1"),
        .package(url: "https://github.com/DoubleNode/DNSCoreThreading.git", from: "1.0.0"),
        .package(url: "https://github.com/Nirma/SFSymbol", from: "0.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DNSCore",
            dependencies: ["AtomicSwift", "DNSCoreThreading", "SFSymbol"]),
        .testTarget(
            name: "DNSCoreTests",
            dependencies: ["DNSCore"]),
    ],
    swiftLanguageVersions: [.v5]
)
