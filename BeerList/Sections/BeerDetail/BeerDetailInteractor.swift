//
//  BeerDetailInteractor.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol BeerDetailInteractorInput {
    var beer: Beer { get }
}

class BeerDetailInteractor: BeerDetailInteractorInput {
    var beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
    }
}
