//
//  SupabaseHelper.swift
//  Core
//
//  Created by 송영모 on 1/27/24.
//

import Foundation
import Supabase

public struct SupabaseHelper {
    static let client = SupabaseClient(supabaseURL: URL(string: "https://xyzcompany.supabase.co")!, supabaseKey: "")
    
    static func getInvestments() {
        
    }
}
