//
//  BeerDetailInteractor.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol BeerDetailInteractorInput {
    var beer: Beer { get }
    func fetchImage(from url: String, completion: @escaping (Data) -> Void)
    func clearImageCache()
}

protocol BeerDetailInteractorOutput: class {
    func showActivityIndicator()
    func hideActivityIndicator()
}

class BeerDetailInteractor {
    var beer: Beer
    let imageDownloader: ImageDownloader
    weak var presenter: BeerDetailInteractorOutput?
    
    init(beer: Beer, imageDownloader: ImageDownloader) {
        self.beer = beer
        self.imageDownloader = imageDownloader
    }
}

extension BeerDetailInteractor: BeerDetailInteractorInput {
    func fetchImage(from url: String, completion: @escaping (Data) -> Void) {
        self.presenter?.showActivityIndicator()
        guard let data = self.imageDownloader.loadCachedImage(from: url) else {
            print("Image \(url) NOT CACHED")
            self.imageDownloader.loadImage(from: url, completion: completion)
            return
        }
        print("Image \(url) CACHED")
        self.presenter?.hideActivityIndicator()
        completion(data)
    }
    
    func clearImageCache() {
        self.imageDownloader.clearCache()
    }
}
