//
//  BeerCategoriesWireframe.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

protocol BeerCategoriesWireframeInput {
    func showError(message: String)
    func navigateToBeerList(for: BeerCategory)
}

class BeerCategoriesWireframe {
    let window: UIWindow
    var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showCategories() {
       let storyboard = UIStoryboard(name: Constants.beerCategoriesStoryboard, bundle: nil)
        if let beerCategoriesVC: BeerCategoriesVC = storyboard.instantiateViewController(withIdentifier: Constants.beerCategoriesVC) as? BeerCategoriesVC {
            let networkClient = NetworkClient()
            let service = BeerCategoriesService(networkClient: networkClient)
            let interactor = BeerCategoriesInteractor(service: service)
            let presenter = CategoriesPresenter(view: beerCategoriesVC,
                                                interactor: interactor,
                                                wireframe: self)
            service.interactor = interactor
            beerCategoriesVC.presenter = presenter
            presenter.interactor = interactor
            interactor.presenter = presenter
            self.navigationController = UINavigationController(rootViewController: beerCategoriesVC)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}

extension BeerCategoriesWireframe: BeerCategoriesWireframeInput {
    func showError(message: String) {
        let alertController = UIAlertController(title: "BeerList", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func navigateToBeerList(for: BeerCategory) {
        // TODO: Implement!
    }
}
