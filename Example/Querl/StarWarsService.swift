//
//  StarWarsService.swift
//  Querl_Example
//
//  Created by Joel Kin on 8/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Querl

struct StarWarsService {
    static func query<Q: Query>(_ query: Q) async throws -> Q.Response {
        let request = try URLRequest(url: URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!, query: query)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try Q.decodeResponse(data)
    }
    
    static func query<Q: PagedQuery>(_ query: Q) async throws -> PagedResponse<Q> {
        let request = try URLRequest(url: URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!, query: query)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try PagedResponse(data)
    }
}
