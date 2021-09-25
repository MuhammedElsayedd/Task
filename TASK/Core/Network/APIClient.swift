//
//  APIClient.swift
//
//  Created by Muhammed Elsayed on 2/28/21.
//  Copyright © 2021. All rights reserved.
//



import UIKit

protocol ApiClientProtocol {
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

// API Client is just a class layer to run APIs like "PostMan"
final class ApiClient: ApiClientProtocol{
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: ("http://bellman-bd.restart-technology.com/" + request.urlSuffix).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
      
        if request.queryItems.count != 0 {
            var x =  URLComponents(string: "http://bellman-bd.restart-technology.com/" + request.urlSuffix)!
            x.queryItems = request.queryItems
            urlRequest = URLRequest(url: x.url!)
        }
        
        urlRequest.httpMethod = request.method
        urlRequest.httpBody = request.body?.toJsonData()
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

//        let lang = LanguageHandler.isArabic ? "ar":"en"
//        urlRequest.addValue(lang, forHTTPHeaderField: "X-localization")
//        urlRequest.addValue("Bearer \(AppManager.userToken ?? "")", forHTTPHeaderField: "Authorization")
        
        // this closure takes in three objects data(actual data object being retrived from the server), respone(status code ex: 200 success) , error
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpUrlResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(NetworkRequestError(error: error! as NSError)))
                    return
                }
                
                let successRange = 200...299
                if successRange.contains(httpUrlResponse.statusCode) || httpUrlResponse.statusCode == 422 {
                    do {
                        let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                        completionHandler(.success(response))
                    } catch { // Parsing Error
                        completionHandler(.failure(error))
                    }
                }  else if httpUrlResponse.statusCode == 401 {
//                    AppManager.logout {
//                        if let topVC = UIApplication.topViewController() {
//                            topVC.presentAlert(title: "Not Logged in", message: "You're not login, please login to proceed", actionTitle: "Signin", cancelTitle: "Later", actionHandler: { (_) in
//                                topVC.gotoLoginRoot()
//                            }, cancelHandler: (nil))
//                        }
//                    }
                    let error = ValidationError(message: "Not Logged in")
                    completionHandler(.failure(error))
                } else { // Network Error
                    completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
                }
            }
        }
        dataTask.resume()
    }
}
