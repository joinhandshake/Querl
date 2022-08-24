//
//  Pagination.swift
//  Pods-Querl_Example
//
//  Created by Joel Kin on 8/9/22.
//

import Foundation

/// Metadata built from a paginated GraphQL endpoint
public struct Pagination: Codable {
    public typealias Cursor = String

    public let endCursor: Cursor?
    public let hasNextPage: Bool?
    public let startCursor: Cursor?
    public let hasPreviousPage: Bool?

    init(endCursor: Cursor?, hasNextPage: Bool?, hasPreviousPage: Bool?, startCursor: Cursor?) {
        self.endCursor = endCursor
        self.hasNextPage = hasNextPage
        self.hasPreviousPage = hasPreviousPage
        self.startCursor = startCursor
    }
}

/// A decodable container for a paged response from a GraphQL endpoint. Contains both the decoded model objects and pagination metadata.
/// Parameters:
/// - `Q`: The GraphQL query containing the paginated objects.
public struct PagedResponse<Q: PagedQuery> where Q.PaginatedType: Decodable {
    /// The pagination metadata from the endpoint, containing cursors and availability.
    public let pageInfo: Pagination
    
    /// The paginated resource.
    /// 
    /// Note that this may not be the top-level model retrieved from the endpoint.
    public let nodes: [Q.PaginatedType]
    
    /// The standard GraphQL response from the query, as defined in the query `Q`.
    public let response: Q.Response
}

public enum PagedResponseError: Error {
    case incorrectFormat
    case pageInfoNotFound
    case nodesNotFound
}

public extension PagedResponse {
    /// Generate a `PagedResponse` container
    /// - Parameters:
    ///   - result: The result of a GraphQL network request
    /// - Throws: This initializer throws the usual JSON decoding errors, as well as errors if the given `connectionPath` does not end in a decodable `Connection` section.
    init(_ data: Data) throws {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw PagedResponseError.incorrectFormat
        }
        var connectionRoot: [String: Any] = json
        for component in Q.pathToPagination {
            guard let newRoot = connectionRoot[component] as? [String: Any] else { throw PagedResponseError.pageInfoNotFound }
            connectionRoot = newRoot
        }
        
        if let pageInfoJSON = connectionRoot["pageInfo"] {
            let pageInfoData = try JSONSerialization.data(withJSONObject: pageInfoJSON)
            pageInfo = try JSONDecoder().decode(Pagination.self, from: pageInfoData)
        } else {
            throw PagedResponseError.pageInfoNotFound
        }
        
        if let nodesJSON = connectionRoot["nodes"] {
            let nodesData = try JSONSerialization.data(withJSONObject: nodesJSON)
            nodes = try JSONDecoder().decode([Q.PaginatedType].self, from: nodesData)
                response = try Q.decodeResponse(data)
        } else {
            throw PagedResponseError.nodesNotFound
        }
    }
}
