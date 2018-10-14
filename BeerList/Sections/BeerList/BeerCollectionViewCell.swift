//
//  BeerCollectionViewCell.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 13/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var beer: UIImageView!
    @IBOutlet weak var favorite: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    
    var tapGestureCompletionBlock: (() -> ())?
    var isFavorite: Bool?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.beer.image = nil
    }
    
    func configureCell(with beer: Beer) {
        self.isFavorite = beer.favorite ?? false
        self.beer.image = #imageLiteral(resourceName: "no_image_available")
        self.beerName.text = beer.name
        self.favorite.image = (self.isFavorite == true) ? #imageLiteral(resourceName: "favorite") : #imageLiteral(resourceName: "add_favorite")
        self.layer.borderWidth = (self.isFavorite == true) ? 2.0 : 0.0
        self.layer.borderColor =  (self.isFavorite == true)  ? UIColor.green.cgColor : UIColor.clear.cgColor
        
        self.beerName.preferredMaxLayoutWidth = 50
    }
    
    func set(image: UIImage) {
        self.beer.image = image
    }
    
    func addTapGestureRecognizer(completion: (() -> ())?) {
        self.tapGestureCompletionBlock = completion
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addBeerToFavorite))
        self.favorite.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func addBeerToFavorite() {
        let currentIsFavoriteValue = !(self.isFavorite ?? false)
        self.isFavorite = currentIsFavoriteValue
        self.favorite.image = (self.isFavorite == true)  ? #imageLiteral(resourceName: "favorite") : #imageLiteral(resourceName: "add_favorite")
        self.layer.borderWidth = (self.isFavorite == true) ? 2.0 : 0.0
        self.layer.borderColor =  (self.isFavorite == true)  ? UIColor.green.cgColor : UIColor.clear.cgColor
        
        guard let completionNotNil = self.tapGestureCompletionBlock else {
            print("Completion block is nil")
            return
        }
        
        completionNotNil()
    }
}
