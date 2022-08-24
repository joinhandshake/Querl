//
//  StarWarsModels.swift
//  Querl_Example
//
//  Created by Joel Kin on 8/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

struct Film: Decodable {
    let id: String
    let title: String
    let openingCrawl: String
}
