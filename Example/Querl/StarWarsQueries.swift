//
//  StarWarsQueries.swift
//  Querl_Example
//
//  Created by Joel Kin on 8/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Querl

struct NextFilm: PagedQuery, HasArguments {
    
    typealias PaginatedType = Film
    static var pathToPagination: [String] { ["data", "allFilms"] }
    
    let afterCursor: Pagination.Cursor?
    let pageSize: Int?

    struct Response: Decodable {}
}
