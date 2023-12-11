//
//  Project.swift
//  AppManifests
//
//  Created by 송영모 on 12/10/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import OffsPlugin

let toffAppTarget = Target(
    name: "ToffApp",
    destinations: [.iPhone, .iPad, .macWithiPadDesign],
    product: .app,
    bundleId: "com.tamsadan.toolinder",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .file(path: .relativeToRoot("Projects/App/Toff/iOS/Resources/InfoPlist/ToffAppIOS-Info.plist")),
    sources: ["iOS/Sources/**"],
    resources: ["iOS/Resources/**"],
    entitlements: .file(path: .relativeToRoot("Projects/App/Toff/iOS/Resources/ToffIOS.entitlements")),
    dependencies: [
        .project(target: "ToffFeature", path: .relativeToRoot("Projects/Feature/Toff")),
    ],
    settings: .settings(
        base: SettingsDictionary().otherLinkerFlags(["-ObjC"]),
        configurations: [
            .debug(
                name: "Debug",
                xcconfig: .relativeToRoot("Projects/App/Toff/iOS/Resources/Config/Debug.xcconfig")
            ),
            .release(
                name: "Release",
                xcconfig: .relativeToRoot("Projects/App/Toff/iOS/Resources/Config/Release.xcconfig")
            ),
        ]
    )
)

let project = Project(
    name: "Toff",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffAppTarget
    ]
)
