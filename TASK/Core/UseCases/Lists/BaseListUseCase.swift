
//
//  BaseListUseCase.swift
//
//  Created by Muhammed Elsayed on 5/5/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

class BaseListUseCase: BaseUseCase {
    var page = 1
    var tag = ""
    var parameters = ""
    /**
     *BaseListUseCase Constructor*
     
     Without first '/'
     
     - Parameter tag: the API name after the base URL  *Without first '/'*
     */
    init(tag: String) {
        self.tag = tag
    }
    
    override func process<T: Decodable>(_ outputType: (T.Type), completionHandler: @escaping (Result<T>) -> Void) {
        ApiClient().execute(request: ApiRequest(urlSuffix: "/\(tag)?page=\(page)&\(parameters)", method: "GET"), completionHandler: { (result: Result<ApiResponse<T>>) in
            switch result {
            case let .success(response):
                completionHandler(.success(response.entity))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        })
        
    }

}
