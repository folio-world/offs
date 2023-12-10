//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import OffsPlugin

let toffAppTarget = Target(
    name: "ToffApp",
    destinations: [.iPhone, .iPad],
    product: .app,
    bundleId: "toff.app",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Toff/iOS/Sources/**"],
    resources: ["Toff/iOS/Resources/**"],
    dependencies: [
        .project(target: "ToffFeature", path: .relativeToRoot("Projects/Feature/Toff")),
    ],
    settings: nil
)

let project = Project(
    name: "Off",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffAppTarget
    ]
)
