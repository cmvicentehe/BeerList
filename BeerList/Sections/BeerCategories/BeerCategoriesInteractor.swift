//
//  BeerCategoriesInteractor.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol BeerCategoriesInteractorInput {
    var categories: [BeerCategory]? { get }
    func fetchCategories()
}

protocol BeerCategoriesInteractorOutput: class {
    func retrievedCategories(_ categories: [BeerCategory])
    func retrievedError(_ error: CategoryError)
}

class BeerCategoriesInteractor {
    var service: BeerCategoriesServiceInput
    weak var presenter: BeerCategoriesInteractorOutput?
    var categories: [BeerCategory]?
    
    init(service: BeerCategoriesServiceInput) {
        self.service = service
    }
}

extension BeerCategoriesInteractor: BeerCategoriesInteractorInput {
    func fetchCategories() {
        self.service.fetchCategories()
    }
}

extension BeerCategoriesInteractor: BeerCategoryServiceOutput {
    func categoriesRetrieved(with result:  Result<[BeerCategory], CategoryError>) {
        switch result {
        case .success(let categories):
            self.categories = categories
            self.presenter?.retrievedCategories(categories)
        case .error(let error):
            self.presenter?.retrievedError(error)
        }
    }
}
