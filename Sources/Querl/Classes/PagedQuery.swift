//
//  PagedQuery.swift
//  Handshake
//
//  Created by Joel Kin on 8/9/22.
//  Copyright © 2022 Handshake. All rights reserved.
//

import Foundation

/// Represents a GraphQL query that returns a paginated response.
public protocol PagedQuery: Query {
    /// The JSON path to the `Connection` section of the response.
    static var pathToPagination: [String] { get }

    /// The model type that's paginated in this query.
    ///
    /// Not necessarily the same as `Response` or the top-level data type in `Response`.
    associatedtype PaginatedType

    /// The cursor indicating which page to retrieve.
    var afterCursor: Pagination.Cursor? { get }

    /// The number of results to fetch per page.
    var pageSize: Int? { get }
}
