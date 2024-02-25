//
//  Environmnet.swift
//  ToolinderShared
//
//  Created by 송영모 on 10/8/23.
//

import Foundation

public struct Environment {
    public static var supabaseProjectURL: String {
        print(Bundle.main.infoDictionary?["SUPABASE_PROJECT_URL"] as? String ?? "")
        return Bundle.main.infoDictionary?["SUPABASE_PROJECT_URL"] as? String ?? ""
    }
    
    public static var supabaseAPIpublicKey: String {
        return Bundle.main.infoDictionary?["SUPABASE_API_PUBLIC_KEY"] as? String ?? ""
    }
    
    public static var supabaseAPIsecretKey: String {
        return Bundle.main.infoDictionary?["SUPABASE_API_SECRET_KEY"] as? String ?? ""
    }
}
