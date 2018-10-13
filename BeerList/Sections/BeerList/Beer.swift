//
//  Beer.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct BeerList: Codable {
    enum CodingKeys : String, CodingKey {
        case beers = "data"
    }
    let beers: [Beer]?
}

struct Style: Codable {
    let category: BeerCategory
}

struct BeerLabel: Codable {
    enum CodingKeys : String, CodingKey {
        case iconUrl = "icon"
        case mediumUrl = "medium"
        case largeUrl = "large"
    }
    let iconUrl: String
    let mediumUrl: String
    let largeUrl: String
}

class Beer: Codable {
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case beerDescription = "description"
        case label = "labels"
        case style
        case favorite
    }
    
    let id: String
    let name: String
    let beerDescription: String?
    let label: BeerLabel?
    let style: Style?
    var favorite: Bool?
    
    init(id: String,
         name: String,
         beerDescription: String?,
         label: BeerLabel?,
         style: Style?,
         favorite: Bool?) {
        self.id = id
        self.name = name
        self.beerDescription = beerDescription
        self.label = label
        self.style = style
        self.favorite = favorite
    }
}
