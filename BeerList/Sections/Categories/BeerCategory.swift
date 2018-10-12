//
//  BeerCategory.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct BeerCategoryList: Codable {
    enum CodingKeys : String, CodingKey {
        case categories = "data"
    }
    let categories: [BeerCategory]
}

struct BeerCategory: Codable {
    let id: Int
    let name: String
}
