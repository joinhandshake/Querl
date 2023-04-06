//
//  Query.swift
//  Handshake
//
//  Created by Joel Kin on 8/9/22.
//  Copyright © 2022 Handshake. All rights reserved.
//

import Foundation

/// Represents a GraphQL query
public protocol Query {
    /// The format of the response to expect from the GraphQL request.
    ///
    /// This can be taken straight from the endpoint documentation, with the exception of whatever fields the app doesn't care about.
    associatedtype Response: Decodable

    /// The full string to send in the GraphQL request.
    ///
    /// This will be loaded from a file named `[Query Name].graphql` by default.
    var fullString: String { get }

    /// The arguments to be passed to the server alongside the query.
    ///
    /// Arguments declared in the query will go here:
    ///
    /// `query MyQuery($argument: String = "")` -> `["argument": "queryString"]` or `nil`, which results in the default "" being used
    ///
    /// `query MyQuery($argument: String!)` -> `["argument": "queryString"]`
    var arguments: [String: Any]? { get }
}

public extension Query {
    // turn the human-readable query file into a formatted body for a `POST` request
    var body: [String: Any] {
        ["query": fullString,
         "variables": arguments?.compactMapValues { $0 } as Any].compactMapValues { $0 }
    }

    // By default, a `Query` will not have arguments. To generate arguments automatically from `Query` properties, the `Query` should conform to `HasArguments`.
    var arguments: [String: Any]? { nil }

    // The query file on disk
    var fullString: String {
        // Assume it has the same name as the class
        // swiftlint:disable:next force_try
        try! String(contentsOfFile: Bundle.main.path(forResource: String("\(type(of: self))".split(separator: ".").last!), ofType: "graphql")!)
    }
}

/// Internal representation of the data structure we get back from GraphQL: `["data": actualResults]`.
struct WrappedQueryResponse<T: Decodable>: Decodable {
    public let data: T
}

public extension Query {
    static func decodeResponse(_ data: Data, decoder: JSONDecoder = JSONDecoder()) throws -> Response {
        try decoder.decode(WrappedQueryResponse<Response>.self, from: data).data
    }
}
