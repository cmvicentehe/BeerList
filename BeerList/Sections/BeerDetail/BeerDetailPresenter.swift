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
}

protocol BeerDetailPresenterInput {
    func viewDidLoad()
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
}


