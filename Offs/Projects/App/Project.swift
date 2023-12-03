//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

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

let roffAppTarget = Target(
    name: "RoffApp",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .app,
    bundleId: "roff.app",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Roff/iOS/Sources/**"],
    resources: ["Roff/iOS/Resources/**"],
    dependencies: [
        
    ],
    settings: nil
)

let project = Project(
    name: "Off",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffAppTarget,
        roffAppTarget
    ]
)
