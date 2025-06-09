//
//  Block.swift
//  FewCuts
//
//  Created by 송영모 on 6/9/25.
//

import Foundation

public protocol Block {
    var id: UUID { get }
    var rect: CGRect { get set }
}
