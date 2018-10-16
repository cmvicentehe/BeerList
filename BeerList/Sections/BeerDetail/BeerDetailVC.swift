//
//  BeerDetailVC.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

class BeerDetailVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerCategory: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: BeerDetailPresenterInput?

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 10.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.presenter?.viewDidReciveMemoryWarning()
    }
}

extension BeerDetailVC: BeerDetailUI {
    func show(_ beer: Beer) {
        self.title = beer.name
        self.beerImage.image = #imageLiteral(resourceName: "no_image_available")
        self.beerName.text = beer.name
        self.beerCategory.text = beer.style?.category.name
        self.beerDescription.text = beer.beerDescription
        
        guard let url = beer.label?.largeUrl else {
            print("Invalid url")
            return
        }
        
        self.presenter?.fetchImage(from: url) { data in
            if let image = UIImage(data: data) {
                self.hideActivityIndicator()
                self.beerImage.image = image
            }
        }
    }
    
    func showActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}

extension BeerDetailVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.beerImage
    }
}
