//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 12/4/23.
//

import ProjectDescription
import MyPlugin

let toffCalendarFeatureTarget = Target(
    name: "ToffCalendarFeature",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "toff.feature.calendar",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Projects/Domain")),
    ],
    settings: nil
)

let project = Project(
    name: "ToffCalendarFeature",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffCalendarFeatureTarget
    ]
)
