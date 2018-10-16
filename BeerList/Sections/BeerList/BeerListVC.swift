//
//  BeerListVC.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

class BeerListVC: UIViewController {
    
    @IBOutlet weak var beerList: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    var presenter: BeerListPresenterInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.presenter?.viewDidReciveMemoryWarning()
    }

}

extension BeerListVC: BeerListUI {
    func set(title: String) {
        self.title = title
    }
    
    func show(beerList: [Beer]) {
        DispatchQueue.main.async {
            self.beerList.reloadData()
        }
    }
    
    func show(message: String) {
        self.presenter?.userDidReceiveError(message)
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}

extension BeerListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.beerList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let beerList = self.presenter?.beerList
        let row = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.beerCollectionViewCell,
                                                      for: indexPath) as! BeerCollectionViewCell

        if let beer = beerList?[row] {
            cell.configureCell(with: beer)
            cell.addTapGestureRecognizer() {
                self.presenter?.userDidAddBeerToFavorites(beer: beer)
            }
            self.presenter?.cell(for: beer) { data in
                if let image = UIImage(data: data) {
                    cell.set(image: image)
                }
            }
        }
        
        
        return cell
    }
}

extension BeerListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let cellHeight = CGFloat(Constants.cellHeight)
        let width = (collectionView.bounds.width / CGFloat(Constants.numberOfItems)) - CGFloat((Constants.margin * 2)) // Margin left and right

        return CGSize(width: width, height: cellHeight) // TODO: Search for dynamic calculation
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let margin = CGFloat(Constants.margin)
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let margin = Constants.margin
        return CGFloat(margin)
    }

}

extension BeerListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let beerList = self.presenter?.beerList
        guard let beer = beerList?[row] else { return print("Invalid Beer") }
        
        self.presenter?.userDidSelect(beer)
    }
}
