//
//  BeerListInteractor.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol BeerListInteractorInput {
    var beerList: [Beer]? { get }
    var categoryName: String { get }
    func fetchBeerList()
    func fetchImage(from url: String, completion: @escaping (Data) -> Void)
    func clearImageCache()
    func addBeerToFavorites(beer: Beer)
}

protocol BeerListInteractorOutput: class {
    func retrievedBeerList(_ beerList: [Beer])
    func retrievedError(_ error: BeerListError)
}

class BeerListInteractor {
    let service: BeerListServiceInput
    let beerCategory: BeerCategory
    weak var presenter: BeerListInteractorOutput?
    var beerList: [Beer]?
    var categoryName: String {
        get {
            return self.beerCategory.name
        }
    }
    
    init(service: BeerListServiceInput, beerCategory: BeerCategory) {
        self.service = service
        self.beerCategory = beerCategory
    }
    
    private func filter(beerList: [Beer]) -> [Beer] {
        return beerList.filter { $0.style?.category.id == beerCategory.id}
    }
}

extension BeerListInteractor: BeerListInteractorInput {
    func fetchBeerList() {
        self.service.fetchBeerList()
    }
    
    func clearImageCache() {
       self.service.clearImageCache()
    }
    
    func fetchImage(from url: String, completion: @escaping (Data) -> Void) {
        self.service.fetchImage(from: url, completion: completion)
    }
    
    func addBeerToFavorites(beer: Beer) {
        guard let beerList = self.beerList else {
            print("There are no beers available")
            return
        }
        let beerListModified: [Beer] = beerList.compactMap {
            if $0.id == beer.id {
                 $0.favorite = true
            }
            return $0
        }
        self.beerList = beerListModified
    }
}

extension BeerListInteractor: BeerListServiceOutput {
    func beerListRetrieved(with result: Result<[Beer], BeerListError>) {
        switch result {
        case .success(let beerList):
            let filteredBeerList = self.filter(beerList: beerList)
            self.beerList = filteredBeerList
            self.presenter?.retrievedBeerList(beerList)
        case .error(let error):
            self.presenter?.retrievedError(error)
        }
    }
}
