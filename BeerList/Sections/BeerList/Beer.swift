//
//  Beer.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct Beer: Codable {
    let name: String
    let beerDescription: String
    let label: BeerLabel
    let category: BeerCategory
    var favorite: Bool
}
