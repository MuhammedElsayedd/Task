//
//  BaseResponse.swift
//
//  Created by Muhammed Elsayed on 2/28/21.
//  Copyright © 2021. All rights reserved.
//

import Foundation

// this is just a base structure for the response or the API
struct ResponseModel<T: Decodable>: Decodable {
    var status_code: Int?
    var data: T?
    var message: String?
}

