//
//  NetworkClient.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct NetworkClient {
        let urlSession: URLSession
        
        init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
            self.urlSession = urlSession
        }
    
    
    func performRequest(for urlRequest: URLRequest, completion: @escaping (Response?) -> Void)  {
            var urlResponse: Response? = nil
            self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard let responseNotNil = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                urlResponse = Response(statusCode: responseNotNil.statusCode,
                                       url: responseNotNil.url,
                                       data: data,
                                       error: error)
                
                completion(urlResponse)
            }).resume()
        
        }

}
