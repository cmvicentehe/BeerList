//
//  Response.swift
//  GameList
//
//  Created by Carlos Manuel Vicente Herrero on 7/7/18.
//  Copyright © 2018 Carlos Manuel Vicente Herrero. All rights reserved.
//

import Foundation

struct Response {
    let statusCode: Int
    let url: URL?
    let data: Data?
    let error: Error?
}
