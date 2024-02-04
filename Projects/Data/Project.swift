//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import OffsPlugin

let dataTarget = Target(
    name: "Data",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.data",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "ToffData", path: .relativeToRoot("Projects/Data/Toff")),
    ],
    settings: nil
)

let project = Project(
    name: "Data",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        dataTarget
    ]
)
