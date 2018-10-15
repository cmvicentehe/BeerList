//
//  BeerDetailVC.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

class BeerDetailVC: UIViewController {
    
    var presenter: BeerDetailPresenterInput?
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

extension BeerDetailVC: BeerDetailUI {
    func show(_ beer: Beer) {
        // TODO: Implement!
    }
}
