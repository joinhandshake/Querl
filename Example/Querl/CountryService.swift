//
//  CountryService.swift
//  Querl_Example
//
//  Created by Joel Kin on 8/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Querl

struct CountryService {
    static func query<Q: Query>(_ query: Q) async throws -> Q.Response {
        let request = try URLRequest(url: URL(string: "https://countries.trevorblades.com/graphql")!, query: query)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try Q.decodeResponse(data)
    }
}
