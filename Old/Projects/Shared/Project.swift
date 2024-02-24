//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import OffsPlugin

let shared = Target.target(
    name: "Shared",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.shared",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    dependencies: [
        .target(name: "SharedThirdPartyLib"),
        .target(name: "SharedDesignSystem")
    ],
    settings: nil
)

let thirdPartyLibTarget = Target.target(
    name: "SharedThirdPartyLib",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.shared.thirdpartylib",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["ThirdPartyLib/Sources/**"],
    dependencies: [
        .external(name: "ComposableArchitecture"),
        .external(name: "GoogleMobileAds"),
        .external(name: "FirebaseAnalytics"),
        .external(name: "Supabase")
    ],
    settings: .settings(
        base: SettingsDictionary().otherLinkerFlags(["-ObjC"])
    )
)

let designSystemTarget = Target.target(
    name: "SharedDesignSystem",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.shared.designSystem",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["DesignSystem/Sources/**"],
    resources: ["DesignSystem/Resources/**"],
    dependencies: [

    ],
    settings: nil
)

let project = Project(
    name: "Shared",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        shared,
        thirdPartyLibTarget,
        designSystemTarget,
    ]
)
