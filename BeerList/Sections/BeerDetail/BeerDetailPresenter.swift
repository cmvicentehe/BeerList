//
//  BeerDetailPresenter.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol BeerDetailUI: class {
    func show(_ beer: Beer)
    func showActivityIndicator()
    func hideActivityIndicator() 
}

protocol BeerDetailPresenterInput {
    func viewDidLoad()
    func viewDidReciveMemoryWarning()
    func fetchImage(from url: String, completion: @escaping (Data) -> Void)
}

class BeerDetailPresenter {
    weak var view: BeerDetailUI?
    let interactor: BeerDetailInteractor
    let wireframe: BeerDetailWireframe
    
    init(view: BeerDetailUI,
         interactor: BeerDetailInteractor,
         wireframe: BeerDetailWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension BeerDetailPresenter: BeerDetailPresenterInput {
    func viewDidLoad() {
        let beer = self.interactor.beer
        self.view?.show(beer)
    }
    
    func viewDidReciveMemoryWarning() {
        self.interactor.clearImageCache()
    }
    
    func fetchImage(from url: String, completion: @escaping (Data) -> Void) {
        self.interactor.fetchImage(from: url, completion: completion)
    }
}

extension BeerDetailPresenter: BeerDetailInteractorOutput {
    func showActivityIndicator() {
        self.view?.showActivityIndicator()
    }
    
    func hideActivityIndicator() {
        self.view?.hideActivityIndicator()
    }
}
