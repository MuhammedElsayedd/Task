//
//  ApiRequest.swift
//
//  Created by Muhammed Elsayed on 2/28/21.
//  Copyright © 2021. All rights reserved.
//

import Foundation

// This class is just to store the request which needed to be implemented
// exg: "/login", "POST", "username: 'tt@tt.tt', password: '123'"

struct ApiRequest {
    var urlSuffix: String
    var method: String = "POST"
    var body: [String: Any]?
    var queryItems:[URLQueryItem] = [] 
}
