// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.8.2"),
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                .composableArchitecture
            ]
        ),
    ]
)

extension Target.Dependency {
    static let composableArchitecture: Self = .product(
        name: "ComposableArchitecture", package: "swift-composable-architecture"
    )
}
