//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/04/24.
//


import ProjectDescription

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: .init(
        [
            .remote(
                url: "https://github.com/googleads/swift-package-manager-google-mobile-ads",
                requirement: .upToNextMajor(from: "10.14.0")
            ),
            .remote(
                url: "https://github.com/pointfreeco/swift-composable-architecture",
                requirement: .upToNextMajor(from: "1.5.3")
            ),
            .remote(
                url: "https://github.com/firebase/firebase-ios-sdk",
                requirement: .upToNextMajor(from: "10.19.0")
            ),
            .remote(
                url: "https://github.com/supabase-community/supabase-swift.git",
                requirement: .upToNextMajor(from: "2.1.0")
            )
        ]
    ),
    platforms: [.iOS]
)
