//
//  BeerListWireframe.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

protocol BeerListWireframeInput {
    func showError(message: String)
    func showBeerDetails()
}

class BeerListWireframe {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showBeerList(by category: BeerCategory) {
        let storyboard = UIStoryboard(name: Constants.beerListStoryBoard, bundle: nil)
        if let beerListVC: BeerListVC = storyboard.instantiateViewController(withIdentifier: Constants.beerListVC) as? BeerListVC {
            let networkClient = NetworkClient()
            let imageDownloader = ImageDownloaderImpl()
            let service = BeerListService(networkClient: networkClient, page: 1, imageDownloader: imageDownloader)
            let interactor = BeerListInteractor(service: service, beerCategory: category)
            let presenter = BeerListPresenter(view: beerListVC,
                                              interactor: interactor,
                                              wireframe: self)
            
            service.interactor = interactor
            beerListVC.presenter = presenter
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            self.navigationController.show(beerListVC, sender: nil)
        }
    }
}

extension BeerListWireframe: BeerListWireframeInput {
    func showError(message: String) {
        let alertController = UIAlertController(title: "BeerList", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.navigationController.present(alertController, animated: true, completion: nil)
    }
    
    func showBeerDetails() {
        // Implement!
    }
}
