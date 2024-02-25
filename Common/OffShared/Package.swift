// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OffShared",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "OffShared",
            type: .static,
            targets: ["OffShared"]
        ),
    ],
    dependencies: [
        .offSharedThirdPartyLib,
        .offSharedDesignSystem,
        .offSharedFoundation,
    ],
    targets: [
        .target(
            name: "OffShared",
            dependencies: [
                .offSharedThirdPartyLib,
                .offSharedDesignSystem,
                .offSharedFoundation,
            ]
        ),
    ]
)

//MARK: Package.Dependency
extension Package.Dependency {
    static let offSharedThirdPartyLib: Package.Dependency = .package(path: "OffSharedThirdPartyLib")
    static let offSharedDesignSystem: Package.Dependency = .package(path: "OffSharedDesignSystem")
    static let offSharedFoundation: Package.Dependency = .package(path: "OffSharedFoundation")
}

//MARK: Target.Dependency
extension Target.Dependency {
    static let offSharedThirdPartyLib: Self = .product(
        name: "OffSharedThirdPartyLib",
        package: "OffSharedThirdPartyLib"
    )
    static let offSharedDesignSystem: Self = .product(
        name: "OffSharedDesignSystem",
        package: "OffSharedDesignSystem"
    )
    static let offSharedFoundation: Self = .product(
        name: "OffSharedFoundation",
        package: "OffSharedFoundation"
    )
}
