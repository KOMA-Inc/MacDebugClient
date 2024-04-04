// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MacDebugClient",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "MacDebugClient",
            targets: ["MacDebugClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/KOMA-Inc/Networking", branch: "main"),
        .package(url: "https://github.com/KOMA-Inc/CombinePlus", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MacDebugClient",
            dependencies: ["Networking", "CombinePlus"]
        ),
        .testTarget(
            name: "MacDebugClientTests",
            dependencies: ["MacDebugClient"]
        )
    ]
)
