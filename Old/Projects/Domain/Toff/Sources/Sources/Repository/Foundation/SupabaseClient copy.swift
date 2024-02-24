//
//  SupabaseClient.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import Supabase

import Shared

public class SupabaseClientProvider {
    static let client = SupabaseClient(
        supabaseURL: URL(string: Environment.supabaseProjectURL)!,
        supabaseKey: Environment.supabaseAPIpublicKey)
}
