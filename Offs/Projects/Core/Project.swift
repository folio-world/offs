//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 12/10/23.
//

import ProjectDescription
import OffsPlugin

let coreTarget = Target(
    name: "Core",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.core",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
    ],
    settings: nil
)

let project = Project(
    name: "Core",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        coreTarget
    ]
)
