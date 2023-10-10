//
//  Modules.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

public enum MicroTargetType: String, CaseIterable {
    case demo = "Demo"
    case interface = "Interface"
    case implement = ""
    case tests = "Tests"
    case testing = "Testing"
    
    public func dependencies() -> [MicroTargetType] {
        switch self {
        case .demo: return [.implement, .interface]
        case .interface: return []
        case .implement: return [.interface]
        case .tests: return [.testing]
        case .testing: return [.interface]
        }
    }
}

public enum Module {
    case product(Product)
    case app(App)
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
    
    public typealias AppPackage = (Product, App)
    public typealias FeaturePackage = (Product, Feature)
    public typealias DomainPackage = (Product, Domain)
    public typealias CorePackage = (Product, Core)
    public typealias SharedPackage = (Product, Shared)
}

public extension Module {
    static func appPackages(_ product: Product) -> [AppPackage] {
        switch product {
        case .Offs:
            return [
                (.Offs, .IOS)
            ]
        case .Off: return []
        case .Toff:
            return [
                (.Toff, .IOS)
            ]
        case .Soff:
            return [
                (.Soff, .IOS)
            ]
        }
    }
    
    static func featurePackages(_ product: Product) -> [FeaturePackage] {
        switch product {
        case .Offs: return [] + featurePackages(.Toff) + featurePackages(.Soff)
        case .Off: return []
        case .Toff:
            return [
                (.Toff, .Calendar),
                (.Toff, .Portfolio),
                (.Toff, .MyPage),
                (.Toff, .Trade),
            ]
        case .Soff:
            return [
                (.Soff, .Calendar),
                (.Soff, .Portfolio),
                (.Soff, .MyPage),
                (.Soff, .Study),
            ]
        }
    }
    
    static func domainPackages(_ product: Product) -> [DomainPackage] {
        switch product {
        case .Offs:
            return [] + domainPackages(.Toff) + domainPackages(.Soff)
        case .Off: return []
        case .Toff:
            return [
                (.Toff, .Trade)
            ]
        case .Soff:
            return [
                (.Soff, .Study)
            ]
        }
    }
    
    static func corePackages(_ product: Product) -> [CorePackage] {
        switch product {
        case .Offs: return [] + corePackages(.Toff) + corePackages(.Soff)
        case .Off:
            return [
                (.Off, .OPENAI),
                (.Off, .Admob)
            ]
        case .Toff: return [] + corePackages(.Off)
        case .Soff: return [] + corePackages(.Off)
        }
    }
    
    static func sharedPackages(_ product: Product) -> [SharedPackage] {
        switch product {
        case .Offs: return [] + sharedPackages(.Toff) + sharedPackages(.Soff)
        case .Off:
            return [
                (.Off, .DesignSystem),
                (.Off, .Network),
                (.Off, .Util),
                (.Off, .Foundation),
                (.Off, .ThirdPartyLib)
            ]
        case .Toff:
            return [
                (.Toff, .ThirdPartyLib),
                (.Toff, .Util)
            ] + sharedPackages(.Off)
        case .Soff:
            return [
                (.Soff, .ThirdPartyLib),
                (.Soff, .Util)
            ] + sharedPackages(.Off)
        }
    }
}

// MARK: Product

public extension Module {
    enum Product: String, CaseIterable {
        case Offs
        case Off
        case Toff
        case Soff
        
        public static let name: String = "Product"
    }
}

// MARK: App

public extension Module {
    enum App: String, CaseIterable {
        case IOS
        case Watch
        case WatchExtension
        
        public static let name: String = "App"
    }
}


// MARK: Feature

public extension Module {
    enum Feature: String, CaseIterable {
        case Calendar
        case Portfolio
        case MyPage
        
        case Trade
        case Study
        
        public static let name: String = "Feature"
        
        public var microTargetTypes: [MicroTargetType] {
            return MicroTargetType.allCases
        }
        
        func dependencies(_ product: Product) -> [Feature] {
            switch product {
            case .Offs: return []
            case .Off: return []
            case .Toff:
                switch self {
                case .Calendar: return [.Trade]
                case .Portfolio: return [.Trade]
                default: return []
                }
            case .Soff:
                switch self {
                case .Calendar: return [.Study]
                case .Portfolio: return [.Study]
                default: return []
                }
            }
        }
    }
}

// MARK: Domain

public extension Module {
    enum Domain: String, CaseIterable {
        case Trade
        case Study
        
        public static let name: String = "Domain"
        
        public var microTargetTypes: [MicroTargetType] {
            return [.implement, .interface, .testing, .tests]
        }
    }
}

// MARK: Core

public extension Module {
    enum Core: String, CaseIterable {
        case OPENAI
        case Admob
        
        public static let name: String = "Core"
        
        public var microTargetTypes: [MicroTargetType] {
            return [.implement, .interface, .testing, .tests]
        }
    }
}

// MARK: Shared

public extension Module {
    enum Shared: String, CaseIterable {
        case Foundation
        case Util
        case DesignSystem
        case ThirdPartyLib
        case Network
        
        public static let name: String = "Shared"
        
        public var microTargetTypes: [MicroTargetType] {
            return [.implement, .interface]
        }
    }
}

