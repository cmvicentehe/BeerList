//
//  BeerCategoriesService.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

enum CategoryError: Error {
    case serviceError(Error)
}

protocol BeerCategoriesServiceInput {
    func fetchCategories()
}

protocol BeerCategoryServiceOutput {
   func categoriesRetrieved(with result:  Result<[BeerCategory], CategoryError>)
}

class BeerCategoriesService {
    let networkClient: NetworkClient
    var interactor: BeerCategoryServiceOutput?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    private func buildRequest() -> URLRequest? {
        let scheme = Constants.scheme
        let host = Config.hostUrl
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = Constants.categories
        
        let queryItem = URLQueryItem(name: Constants.key, value: Config.apiKey)
        urlComponents.queryItems = [queryItem]
        guard let url = urlComponents.url else {
            print("Invalid url")
            return nil
        }
        let request = URLRequest.init(url: url,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 30)
        return request
    }
    
    private func parse(_ data: Data) -> [BeerCategory]? {
        var categories: [BeerCategory]? = [BeerCategory]()
        do {
            let decoder = JSONDecoder()
            let categoryList: BeerCategoryList = try decoder.decode(BeerCategoryList.self, from: data)
            categories = categoryList.categories
        } catch let error {
            print("Error received", error)
        }
        
        return categories
    }
        
}

extension BeerCategoriesService: BeerCategoriesServiceInput {
    func fetchCategories() {
        guard let request = self.buildRequest() else { return print("Invalid url request") }
        self.networkClient.performRequest(for: request) { (response) in
            guard let data = response?.data else {
                if let error =  response?.error {
                    print("There was an error \(error)")
                    let serviceError = CategoryError.serviceError(error)
                    self.interactor?.categoriesRetrieved(with: Result.error(serviceError))
                }
                return
            }
            guard let categories = self.parse(data) else {
                print("Invalid category list")
                return
            }
            
            let result = Result<[BeerCategory], CategoryError>.success(categories)
            self.interactor?.categoriesRetrieved(with: result)
        }
    }
}
