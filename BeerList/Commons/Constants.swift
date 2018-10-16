//
//  Constants.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: Endpoints
    static let scheme = "https"
    static let categories = "/v2/categories"
    static let beers = "/v2/beers"
    static let key = "key"
    static let p = "p"
    static let abv = "abv"
    static let abvPlus10 = "+10"
    static let abvMinus10 = "-10"
    
    // MARK: info-plist keys
    static let hostUrl = "HOST_URL"
    static let apiKey = "BREWERY_API_KEY"
    
    // MARK: Storyboards identifiers
    static let beerCategoriesStoryboard = "BeerCategories"
    static let beerListStoryBoard = "BeerList"
    static let beerDetailStoryboard = "BeerDetail"
    
    // MARK: VC identifieres
    static let beerCategoriesVC = "BeerCategoriesVC"
    static let beerListVC = "BeerListVC"
    static let beerDetail = "BeerDetailVC"
    
    // MARK: Cell identifiers
    static let categoryCell = "CategoryCell"
    static let beerCollectionViewCell = "BeerCollectionViewCell"
    
    // MARK: Cell margins
    static let margin = 10.0
    static let numberOfItems = 3.0
    static let cellHeight = 132.0
}
