//
//  Config.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct Config {
    private static let host = Bundle.main.object(forInfoDictionaryKey: Constants.hostUrl)
    static let hostUrl = "https://\(String(describing: host))"
    static let apiKey =  Bundle.main.object(forInfoDictionaryKey: Constants.apiKey) as? String
}
