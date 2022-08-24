//
//  CountryModels.swift
//  Querl_Example
//
//  Created by Joel Kin on 8/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let capital: String
    let currency: String
    let emoji: String
    let name: String
    let languages: [Language]
}

struct Language: Decodable {
    let code: String
    let name: String
}
