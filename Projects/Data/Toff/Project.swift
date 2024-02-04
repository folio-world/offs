//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2/4/24.
//

import ProjectDescription
import OffsPlugin

let toffDataTarget = Target(
    name: "ToffData",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "toff.data",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain"))
    ],
    settings: nil
)

let project = Project(
    name: "ToffData",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffDataTarget
    ]
)