//
//  BeerCategoriesVC.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

class BeerCategoriesVC: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: CategoriesPresenterInput?

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.title = "Beer Categories"
    }
}

extension BeerCategoriesVC: CategoriesUI {

    func show(categories: [BeerCategory]) {
        DispatchQueue.main.async {
            self.categoriesTableView.reloadData()
        }
    }
    
    
    func show(message: String) {
         self.presenter?.userDidReceiveError(message)
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }

}

extension BeerCategoriesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.presenter?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: Constants.categoryCell, for: indexPath)
        
        if let beerCategory = self.presenter?.categories?[indexPath.row] {
            cell.textLabel?.text = beerCategory.name
            cell.detailTextLabel?.text = String(beerCategory.id)
        }
        
        return cell
    }
}

extension BeerCategoriesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let beerCategory = self.presenter?.categories?[indexPath.row] else { return print("No category selected") }
        
        self.presenter?.userDidTapCategory(beerCategory)
        self.categoriesTableView.deselectRow(at: indexPath, animated: true)
    }
}
