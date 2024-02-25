// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OffSharedThirdPartyLib",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OffSharedThirdPartyLib",
            targets: ["OffSharedThirdPartyLib"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.8.2"
        ),
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads",
            from: "10.14.0"
        ),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            from: "10.19.0"
        ),
        .package(
            url: "https://github.com/supabase-community/supabase-swift.git",
            from: "2.1.0"
        )
    ],
    targets: [
        .target(
            name: "OffSharedThirdPartyLib",
            dependencies: [
                .composableArchitecture,
                .googleMobileAds,
                .supabase,
//                .firebaseCore
            ]
        )
    ]
)

extension Target.Dependency {
    static let composableArchitecture: Self = .product(
        name: "ComposableArchitecture",
        package: "swift-composable-architecture"
    )
    static let googleMobileAds: Self = .product(
        name: "GoogleMobileAds",
        package: "swift-package-manager-google-mobile-ads"
    )
    static let supabase: Self = .product(
        name: "Supabase",
        package: "supabase-swift"
    )
    static let firebaseCore: Self = .product(
        name: "FirebaseCore",
        package: "firebase-ios-sdk"
    )
}
