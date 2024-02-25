// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToffDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ToffDomain",
            targets: ["ToffDomain"]),
    ],
    dependencies: [
        .package(path: "../../../Common/OffCore")
    ],
    targets: [
        .target(
            name: "ToffDomain",
            dependencies: [
                .product(name: "OffCore", package: "OffCore")
            ]
        )
    ]
)
