//
//  ServiceManagerSingleton.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 26/05/2022.
//

import Foundation
import Alamofire

class ServiceManagerSingleton {
    static let serviceManager = ServiceManagerSingleton()
    
    func post(url: String, params: [String:Any] ,completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: params).validate().response { response in
            completion(response.result)
        }
    }
}
