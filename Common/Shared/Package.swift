// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]
        ),
    ],
    dependencies: [
        .sharedThirdPartyLib,
        .sharedDesignSystem,
        .sharedFoundation,
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                .sharedThirdPartyLib,
                .sharedDesignSystem,
                .sharedFoundation,
            ]
        ),
    ]
)

//MARK: Package.Dependency
extension Package.Dependency {
    static let sharedThirdPartyLib: Package.Dependency = .package(path: "SharedThirdPartyLib")
    static let sharedDesignSystem: Package.Dependency = .package(path: "SharedDesignSystem")
    static let sharedFoundation: Package.Dependency = .package(path: "SharedFoundation")
}

//MARK: Target.Dependency
extension Target.Dependency {
    static let sharedThirdPartyLib: Self = .product(name: "SharedThirdPartyLib", package: "SharedThirdPartyLib")
    static let sharedDesignSystem: Self = .product(name: "SharedDesignSystem", package: "SharedDesignSystem")
    static let sharedFoundation: Self = .product(name: "SharedFoundation", package: "SharedFoundation")
}
