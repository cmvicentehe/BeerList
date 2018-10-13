//
//  ImageDownloader.swift
//  GameList
//
//  Created by Carlos Vicente on 16/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

protocol ImageDownloader {
    func loadImage(from url: String, completion: @escaping (Data) -> Void)
    func loadCachedImage(from url: String) -> Data?
    func clearCache()
}

struct ImageDownloaderImpl {
    let cache: NSCache<NSString, NSData>
    
    init(cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()) {
        self.cache = cache
    }
}

extension ImageDownloaderImpl: ImageDownloader {
    func loadImage(from url: String, completion: @escaping (Data) -> Void) {
        DispatchQueue.global(qos: .background).async() {
            guard let imageURL = URL(string: url) else {
                print("Invalid image url")
                return
            }
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                DispatchQueue.main.async {
                    guard let dataNotNil = data else {
                        print("Invalid data")
                        return
                    }
                    let key = NSString(string: url)
                    let dataConverted = NSData(data: dataNotNil)
                    self.cache.setObject(dataConverted, forKey: key)
                    completion(dataNotNil)
                }
    
            }.resume()
        }
    }
    
    func loadCachedImage(from url: String) -> Data? {
        let key = NSString(string: url)
        guard let data = self.cache.object(forKey: key) else {
            print("Not data cached")
            return nil
        }
        return Data(referencing: data)
    }
    
    func clearCache() {
        self.cache.removeAllObjects()
    }
}
