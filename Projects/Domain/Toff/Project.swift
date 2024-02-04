//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2/4/24.
//

import ProjectDescription
import OffsPlugin

let toffDomainTarget = Target(
    name: "ToffDomain",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "toff.domain",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Core", path: .relativeToRoot("Projects/Core")),
    ],
    settings: nil
)

let project = Project(
    name: "ToffDomain",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffDomainTarget
    ]
)
