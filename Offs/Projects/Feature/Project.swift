//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import OffsPlugin

let featureTarget = Target(
    name: "Feature",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.feature",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "ToffFeature", path: .relativeToRoot("Projects/Feature/Toff")),
    ],
    settings: nil
)

let project = Project(
    name: "Feature",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        featureTarget
    ]
)
