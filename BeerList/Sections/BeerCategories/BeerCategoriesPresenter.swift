//
//  BeerCategoriesPresenter.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol CategoriesUI: class {
    func show(message: String)
    func show(categories: [BeerCategory])
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol CategoriesPresenterInput {
    var categories: [BeerCategory]? { get }
    func viewDidLoad()
    func userDidTapCategory(_ category: BeerCategory)
    func userDidReceiveError(_ message: String)
}

class CategoriesPresenter {
    weak var view: CategoriesUI?
    var categories: [BeerCategory]? {
        get {
          return self.interactor.categories
        }
        
    }
    var interactor: BeerCategoriesInteractorInput
    var wireframe: BeerCategoriesWireframeInput
    
    init(view: CategoriesUI, interactor: BeerCategoriesInteractorInput, wireframe: BeerCategoriesWireframeInput) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension CategoriesPresenter: CategoriesPresenterInput {
    func viewDidLoad() {
        self.interactor.fetchCategories()
        self.view?.showActivityIndicator()
    }
    
    func userDidTapCategory(_ category: BeerCategory) {
       self.wireframe.navigateToBeerList(for: category)
    }
    
    func userDidReceiveError(_ message: String) {
        self.wireframe.showError(message: message)
    }
}

extension CategoriesPresenter: BeerCategoriesInteractorOutput {

    func retrievedCategories(_ categories: [BeerCategory]) {
        self.view?.show(categories: categories)
        self.view?.hideActivityIndicator()
    }
    
    func retrievedError(_ error: CategoryError) {
        self.view?.show(message: error.localizedDescription)
        self.view?.hideActivityIndicator()
    }
}
