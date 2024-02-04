//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 12/4/23.
//

import ProjectDescription
import OffsPlugin

let toffFeatureTarget = Target(
    name: "ToffFeature",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "toff.feature",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "ToffPresentation", path: .relativeToRoot("Projects/Presentation/Toff")),
        .project(target: "ToffData", path: .relativeToRoot("Projects/Data/Toff")),
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
