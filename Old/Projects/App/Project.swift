//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 11/2/23.
//

import ProjectDescription
import OffsPlugin

let toffAppTarget = Target.target(
    name: "ToffApp",
    destinations: [],
    product: .app,
    bundleId: "com.tamsadan.toolinder",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .file(path: .relativeToRoot("Projects/App/Toff/iOS/Resources/InfoPlist/ToffAppIOS-Info.plist")),
    sources: ["Toff/iOS/Sources/**"],
    resources: ["Toff/iOS/Resources/**"],
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
    name: "Offs",
    organizationName: "",
    packages: [],
    settings: nil,
    targets: [
        toffAppTarget
    ]
)
