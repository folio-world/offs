//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import OffsPlugin

let domainTarget = Target(
    name: "Domain",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .staticFramework,
    bundleId: "off.domain",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "ToffDomain", path: .relativeToRoot("Projects/Domain/Toff")),
    ],
    settings: nil
)

let project = Project(
    name: "Domain",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        domainTarget
    ]
)
