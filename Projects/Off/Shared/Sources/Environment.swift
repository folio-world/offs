//
//  Environmnet.swift
//  ToolinderShared
//
//  Created by 송영모 on 10/8/23.
//

import Foundation

public struct Environment {
    public static var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
}
