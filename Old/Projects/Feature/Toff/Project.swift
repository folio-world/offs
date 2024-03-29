//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 12/4/23.
//

import ProjectDescription
import OffsPlugin

let toffFeatureTarget = Target.target(
    name: "ToffFeature",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "toff.feature",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "ToffDomain", path: .relativeToRoot("Projects/Domain/Toff"))
    ],
    settings: nil
)

let project = Project(
    name: "ToffFeature",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffFeatureTarget
    ]
)
