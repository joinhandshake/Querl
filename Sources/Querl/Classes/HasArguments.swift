//
//  HasArguments.swift
//  Handshake
//
//  Created by Joel Kin on 8/9/22.
//  Copyright © 2022 Handshake. All rights reserved.
//

import Foundation

/// Represents a `Query` (usually) that has arguments that must be passed to the GraphQL endpoint.
///
/// By default, all properties will be automatically encoded as arguments.
public protocol HasArguments: Encodable {}

public extension Query where Self: HasArguments {
    var arguments: [String: Any]? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        do {
            let data = try encoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dictionary
        } catch {
            assertionFailure("Failed to encode the following model: \(self)\n\(error)")
            return nil
        }
    }
}
