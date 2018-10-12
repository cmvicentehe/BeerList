//
//  Config.swift
//  BeerList
//
//  Created by Carlos Manuel Vicente Herrero on 12/10/2018.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct Config {
    static let hostUrl: String = Bundle.main.object(forInfoDictionaryKey: Constants.hostUrl) as? String ?? ""
    static let apiKey: String = Bundle.main.object(forInfoDictionaryKey: Constants.apiKey) as? String ?? ""
}
