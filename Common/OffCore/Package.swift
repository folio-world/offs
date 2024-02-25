// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OffCore",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "OffCore",
            type: .static,
            targets: ["OffCore"]
        ),
    ],
    dependencies: [
        .package(path: "../OffShared")
    ],
    targets: [
        .target(
            name: "OffCore",
            dependencies: [
                .product(name: "OffShared", package: "OffShared")
            ]
        )
    ]
)
