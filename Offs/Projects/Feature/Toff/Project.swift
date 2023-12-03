//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 12/4/23.
//

import ProjectDescription
import MyPlugin

let toffFeatureTarget = Target(
    name: "ToffFeature",
    destinations: [.iPhone, .iPad, .appleWatch],
    product: .framework,
    bundleId: "toff.feature",
    deploymentTargets: .init(iOS: "17.0", watchOS: "10.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "ToffCalendarFeature", path: .relativeToRoot("Projects/Feature/Toff/Calendar")),
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
