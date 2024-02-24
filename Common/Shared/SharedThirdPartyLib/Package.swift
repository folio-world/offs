// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedThirdPartyLib",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SharedThirdPartyLib",
            targets: ["SharedThirdPartyLib"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.8.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SharedThirdPartyLib"),
        .testTarget(
            name: "SharedThirdPartyLibTests",
            dependencies: ["SharedThirdPartyLib"]),
    ]
)

extension Target.Dependency {
    static let composableArchitecture: Self = .product(
        name: "ComposableArchitecture", package: "swift-composable-architecture"
    )
}
