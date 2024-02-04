//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import OffsPlugin

let presentationTarget = Target(
    name: "Presentation",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.data",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "ToffPresentation", path: .relativeToRoot("Projects/Presentation/Toff")),
    ],
    settings: nil
)

let project = Project(
    name: "Presentation",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        presentationTarget
    ]
)
