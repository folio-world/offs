//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import OffsPlugin

let shared = Target(
    name: "Shared",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
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

let thirdPartyLibTarget = Target(
    name: "SharedThirdPartyLib",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "off.shared.thirdpartylib",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["ThirdPartyLib/Sources/**"],
    dependencies: [
    ],
    settings: nil
)

let designSystemTarget = Target(
    name: "SharedDesignSystem",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
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
