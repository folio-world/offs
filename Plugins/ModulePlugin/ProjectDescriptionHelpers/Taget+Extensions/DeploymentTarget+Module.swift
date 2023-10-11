//
//  DeploymentTarget+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

public extension DeploymentTarget {
    private static func iOS(_ product: Module.Product) -> Self {
        switch product {
        case .Off: return .iOS(targetVersion: "17.0", devices: [.iphone, .ipad])
        case .Toff: return .iOS(targetVersion: "17.0", devices: [.iphone, .ipad])
        case .Soff: return .iOS(targetVersion: "17.0", devices: [.iphone, .ipad])
        default: return .iOS(targetVersion: "16.0", devices: [.iphone])
        }
    }
    
    private static func watchOS(_ product: Module.Product) -> Self {
        switch product {
        case .Off: return .watchOS(targetVersion: "9.0")
        case .Toff: return .watchOS(targetVersion: "9.0")
        case .Soff: return .watchOS(targetVersion: "10.0")
        default: return .watchOS(targetVersion: "9.0")
        }
    }
    
    private static func resolve(_ product: Module.Product, platform: Platform) -> Self? {
        switch platform {
        case .iOS: return .iOS(product)
        case .macOS: return nil
        case .watchOS: return .watchOS(product)
        case .tvOS: return nil
        case .visionOS: return nil
        @unknown default: return nil
        }
    }
}

//MARK: App

public extension DeploymentTarget {
    static func app(_ product: Module.Product) -> Self {
        return .iOS(product)
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        switch module {
        case .IOS: return .iOS(product)
        case .Watch: return .watchOS(product)
        case .WatchExtension: return .watchOS(product)
        }
    }
}

//MARK: Feature

public extension DeploymentTarget {
    static func feature(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .feature(product))
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self? {
        return resolve(product, platform: .feature(product, module: module))
    }
}

//MARK: Domain

public extension DeploymentTarget {
    static func domain(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .domain(product))
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self? {
        return resolve(product, platform: .domain(product, module: module))
    }
}

//MARK: Core

public extension DeploymentTarget {
    static func core(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .core(product))
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self? {
        return resolve(product, platform: .core(product, module: module))
    }
}

//MARK: Shared

public extension DeploymentTarget {
    static func shared(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .shared(product))
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self? {
        return resolve(product, platform: .shared(product, module: module))
    }
}
