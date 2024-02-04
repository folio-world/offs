//
//  SupabaseHelper.swift
//  Core
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import Supabase

import Shared

public struct SupabaseHelper {
    static let client = SupabaseClient(
        supabaseURL: URL(string: Environment.supabaseProjectURL)!,
        supabaseKey: Environment.supabaseAPIpublicKey
    )
}

func countNodes(in tree: Node, matching predicate: (Node) throws -> Bool) rethrows -> Int {
  class MyNodeVisitor: NodeVisitor {
    var error: (any Error)? = nil
    var count: Int = 0
    var predicate: (Node) throws -> Bool

    init(predicate: @escaping (Node) throws -> Bool) {
      self.predicate = predicate
    }
    
    override func visit(node: Node) {
      do {
        if try predicate(node) {
          count = count + 1
        }
      } catch let localError {
        error = error ?? localError
      }
    }
  }
  
  return try withoutActuallyEscaping(predicate) { predicate in
    let visitor = MyNodeVisitor(predicate: predicate)
    visitor.visitTree(node)
    if let error = visitor.error {
      throw error // error: is not throwing as a consequence of 'predicate' throwing.
    } else {
      return visitor.count
    }
  }
}
