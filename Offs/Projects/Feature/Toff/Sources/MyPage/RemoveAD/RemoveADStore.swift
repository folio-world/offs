//
//  PurchaseProStore.swift
//  ToolinderFeatureMyPageDemo
//
//  Created by 송영모 on 10/9/23.
//

import Foundation
import StoreKit

import ComposableArchitecture

import Domain

public struct RemoveADStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var products: [Product] = []
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case purchased(Product)
        case fetchProductsRequest
        case fetchProductResponse(TaskResult<[Product]>)
    }
    
    private enum CancelID { case products }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .purchased(product):
                debugPrint(product)
                return .none
                
            case let .fetchProductResponse(.success(products)):
                state.products = products
                return .none
                
            default:
                return .none
            }
        }
    }
}
