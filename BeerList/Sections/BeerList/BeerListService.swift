//
//  BeerListService.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 13/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

enum BeerListError: Error {
    case serviceError(Error)
}

protocol BeerListServiceInput {
    var beerList: [Beer] { get set }
    func fetchBeerList()
    func fetchImage(from url: String, completion: @escaping (Data) -> Void)
    func clearImageCache()
}

protocol BeerListServiceOutput {
    func beerListRetrieved(with result:  Result<[Beer], BeerListError>)
}


class BeerListService {
    let networkClient: NetworkClient
    let imageDownloader: ImageDownloader
    var page: Int
    var beerList: [Beer]
    var interactor: BeerListServiceOutput?
    
    init(networkClient: NetworkClient, page: Int, imageDownloader: ImageDownloader) {
        self.networkClient = networkClient
        self.page = page
        self.beerList = [Beer]()
        self.imageDownloader = imageDownloader
    }
    
    private func buildRequest() -> URLRequest? {
        let scheme = Constants.scheme
        let host = Config.hostUrl
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = Constants.beers
        
        let keyQueryItem = URLQueryItem(name: Constants.key, value: Config.apiKey)
        let abvPlus10QueryItem = URLQueryItem(name: Constants.abv, value: Constants.abvPlus10)
        //        let abvMinusQueryItem = URLQueryItem(name: Constants.abv, value: Constants.abvMinus10) // TODO: Uncomment to retrieve all beers there are lot of them and its hard to wait for all beers ending
        let pageQueryItem = URLQueryItem(name: Constants.p, value: String(page))
        urlComponents.queryItems = [keyQueryItem, abvPlus10QueryItem, /*abvMinusQueryItem, */pageQueryItem]
        guard let url = urlComponents.url else {
            print("Invalid url")
            return nil
        }
        let request = URLRequest.init(url: url,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 30)
        return request
    }
    
    private func parse(_ data: Data) -> [Beer]? {
        var beersResult: [Beer]? = nil
        do {
            let decoder = JSONDecoder()
            let beerList: BeerList = try decoder.decode(BeerList.self, from: data)
            beersResult = [Beer]()
            beersResult = beerList.beers
        } catch let error {
            print("Error received", error)
        }

        return beersResult
    }
}

extension BeerListService: BeerListServiceInput {
    func fetchBeerList() {
        guard let request = self.buildRequest() else { return print("Invalid url request") }
        self.networkClient.performRequest(for: request) { (response) in
            guard let data = response?.data else {
                if let error =  response?.error {
                    print("There was an error \(error)")
                    let serviceError = BeerListError.serviceError(error)
                    self.interactor?.beerListRetrieved(with: Result.error(serviceError))
                }
                return
            }
            guard let beerList = self.parse(data) else {
                print("There are no more beers")
                let result = Result<[Beer], BeerListError>.success(self.beerList)
                self.interactor?.beerListRetrieved(with: result)
                return
            }
          self.beerList += beerList
          self.page += 1
          print("Beer List --> \(beerList)")
          print("Page --> \(self.page)")
          self.fetchBeerList()
        }
    }
    
    func fetchImage(from url: String, completion: @escaping (Data) -> Void) {
        guard let data = self.imageDownloader.loadCachedImage(from: url) else {
            print("Image \(url) NOT CACHED")
            self.imageDownloader.loadImage(from: url, completion: completion)
            return
        }
        print("Image \(url) CACHED")
        completion(data)
    }
    
    func clearImageCache() {
        self.imageDownloader.clearCache()
    }
}
