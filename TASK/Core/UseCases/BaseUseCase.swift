//
//  BaseUseCase.swift
//
//  Created by Muhammed Elsayed on 5/4/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

class BaseUseCase {
    
    var body: [String: Any]?
    
    func extract() {}
    func validate() throws {}
    func process<T: Decodable>(_ outputType: T.Type, completionHandler: @escaping (Result<T>) -> Void) {
        completionHandler(Result<T>.failure(NSError()))
    }
    
    final func execute<T: Decodable>(_ outputType: T.Type, completionHandler: @escaping (Result<T>) -> Void) {
        do {
            extract()
            try validate()
            process(outputType, completionHandler: completionHandler)
        } catch let error {
            completionHandler(Result<T>.failure(error))
        }
    }
    
}
