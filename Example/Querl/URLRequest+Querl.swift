//
//  URLRequest+Querl.swift
//  Querl_Example
//
//  Created by Joel Kin on 8/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Querl

extension URLRequest {
    init<T: Query>(url: URL, query: T) throws {
        self.init(url: url)
        // under the hood, a GraphQL request is just a `POST` with a funky `body`
        httpMethod = "POST"
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        httpBody = try JSONSerialization.data(withJSONObject: query.body)
    }
}

// Alamofire
/*
extension Manager {
    func request<T: Query>(query: T, url: URL, completion: @escaping (Result<T.Response, Error>) -> ()) {
        request(url, method: .post, parameters: query.body).responseJSON {
            response in
            switch response.result {
            case .success: completion(.success(try! T.decodeResponse(response.data)))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
*/
