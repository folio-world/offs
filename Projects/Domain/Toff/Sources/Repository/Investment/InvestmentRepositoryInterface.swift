//
//  InvestmentRepositoryInterface.swift
//  ToffDomain
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

public protocol InvestmentRepositoryInterface {
    func fetches() async throws -> [Investment]
    func insert(investment: Investment) async throws -> Void
}
