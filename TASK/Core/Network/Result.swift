//
//  Result.swift
//
//  Created by Muhammed Elsayed on 2/28/21.
//  Copyright © 2021. All rights reserved.
//

import Foundation
// to check if the request is success or failed and return in a structure of switch cases
enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
