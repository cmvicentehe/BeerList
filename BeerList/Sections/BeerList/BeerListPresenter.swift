//
//  BeerListPresenter.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol BeerListUI: class {
    func set(title: String)
    func show(beerList: [Beer])
    func show(message: String)
    func showActivityIndicator()
    func hideActivityIndicator() 
}

protocol BeerListPresenterInput {
    var beerList: [Beer]? { get }
    
    func viewDidLoad()
    func userDidReceiveError(_ message: String)
    func cell(for beer: Beer, completion: @escaping(Data) -> Void)
    func viewDidReciveMemoryWarning()
    func userDidAddBeerToFavorites(beer: Beer)
    func userDidSelect(_ beer: Beer)
}

class BeerListPresenter {
    weak var view: BeerListUI?
    var interactor: BeerListInteractorInput
    var wireframe: BeerListWireframeInput
    
    var beerList: [Beer]? {
        get {
            return self.interactor.beerList
        }
        
    }
    
    init(view: BeerListUI, interactor:BeerListInteractorInput, wireframe: BeerListWireframeInput) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension BeerListPresenter: BeerListPresenterInput {
    func viewDidLoad() {
        self.view?.set(title: self.interactor.categoryName)
        self.view?.showActivityIndicator()
        self.interactor.fetchBeerList()
    }
    
    func cell(for beer: Beer, completion: @escaping(Data) -> Void) {
        guard let url = beer.label?.iconUrl else { return print("Invalid image url") }
        self.interactor.fetchImage(from:url, completion: completion)
    }
    
    func userDidReceiveError(_ message: String) {
        self.wireframe.showError(message: message)
    }
    
    func viewDidReciveMemoryWarning() {
        self.interactor.clearImageCache()
    }
    
    func userDidAddBeerToFavorites(beer: Beer) {
        self.interactor.addBeerToFavorites(beer: beer)
    }
}

extension BeerListPresenter: BeerListInteractorOutput {
    func retrievedBeerList(_ beerList: [Beer]) {
        self.view?.hideActivityIndicator()
        self.view?.show(beerList: beerList)
    }
    
    func retrievedError(_ error: BeerListError) {
        self.view?.hideActivityIndicator()
        self.view?.show(message: error.localizedDescription)
    }
    
    func userDidSelect(_ beer: Beer) {
        self.wireframe.showBeerDetails(beer)
    }
}
