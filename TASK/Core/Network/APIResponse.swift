//
//  ApiResponse.swift
//
//  Created by Muhammed Elsayed on 2/28/21.
//  Copyright © 2021. All rights reserved.
//

import Foundation

// Just to store the response of any given type (like User, [User], [Product] ... etc) from the API Client
struct ApiResponse<T: Decodable> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try JSONDecoder().decode(T.self, from: data ?? Data())
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiParseError(data: data, httpUrlResponse: httpUrlResponse, error: error as NSError)
        }
    }
}
