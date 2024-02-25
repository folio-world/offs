//
//  SupabaseHelper.swift
//  Core
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import Supabase

import OffShared

public struct SupabaseHelper {
    static let client = SupabaseClient(
        supabaseURL: URL(string: Environment.supabaseProjectURL)!,
        supabaseKey: Environment.supabaseAPIpublicKey
    )
}
