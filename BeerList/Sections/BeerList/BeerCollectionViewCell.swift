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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.beer.image = nil
    }
    
    func configureCell(with beer: Beer) {
         let isFavorite = beer.favorite ?? false
        self.beer.image = #imageLiteral(resourceName: "no_image_available")
        self.beerName.text = beer.name
        self.favorite.image = isFavorite ? #imageLiteral(resourceName: "favorite") : #imageLiteral(resourceName: "add_favorite")
        self.layer.borderColor =  isFavorite ? UIColor.green.cgColor : UIColor.lightGray.cgColor
    }
    
    func set(image: UIImage) {
        self.favorite.image = image
    }
    
    func addTapGestureRecognizer(completion: (() -> ())?) {
        self.tapGestureCompletionBlock = completion
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addBeerToFavorite))
        self.beer.addGestureRecognizer(gestureRecognizer)
        self.favorite.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func addBeerToFavorite() {
        self.favorite.image = #imageLiteral(resourceName: "favorite")
        self.layer.borderColor = UIColor.green.cgColor
        
        guard let completionNotNil = self.tapGestureCompletionBlock else {
            print("Completion block is nil")
            return
        }
        
        completionNotNil()
    }
}
