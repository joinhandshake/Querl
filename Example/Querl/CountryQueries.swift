//
//  CountryQueries.swift
//  Querl_Example
//
//  Created by Joel Kin on 8/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Querl

struct CountryForCode: Query, HasArguments {
    struct Response: Decodable {
        let country: Country?
    }
    let code: String
}
