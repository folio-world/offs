// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ThirdPartyLib",
    dependencies: [
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads",
            from: "10.14.0"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.8.2"
        ),
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            from: "10.19.0"
        ),
        .package(
            url: "https://github.com/supabase-community/supabase-swift.git",
            from: "2.1.0"
        )
    ]
)
