//
//  BeerDetailWireframe.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

struct BeerDetailWireframe {
    let navigationController: UINavigationController
    
    func showBeerDetail(beer: Beer) {
        let storyboard = UIStoryboard(name: Constants.beerDetailStoryboard, bundle: nil)
        if let beerDetailVC: BeerDetailVC = storyboard.instantiateViewController(withIdentifier: Constants.beerDetail) as? BeerDetailVC {

            let interactor = BeerDetailInteractor(beer: beer)
            let presenter = BeerDetailPresenter(view: beerDetailVC,
                                              interactor: interactor,
                                              wireframe: self)
            
            beerDetailVC.presenter = presenter
            self.navigationController.show(beerDetailVC, sender: nil)
        }
    }
}
