// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToffApp",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ToffApp",
            type: .static,
            targets: ["ToffApp"]),
    ],
    dependencies: [
        .package(path: "ToffFeature")
    ],
    targets: [
        .target(
            name: "ToffApp",
            dependencies: [
                .product(name: "ToffFeature", package: "ToffFeature")
            ],
            resources: [.process("Resources")]
        )
    ]
)
