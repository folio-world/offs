// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToffFeature",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "ToffFeature",
            type: .static,
            targets: ["ToffFeature"]),
    ],
    dependencies: [
        .package(path: "ToffDomain")
    ],
    targets: [
        .target(
            name: "ToffFeature",
            dependencies: [
                .product(name: "ToffDomain", package: "ToffDomain")
            ]
        ),
    ]
)
