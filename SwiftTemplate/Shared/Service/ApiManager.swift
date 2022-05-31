//
//  ApiManager.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 26/05/2022.
//

import Foundation
import Alamofire

struct ApiManager{
    
    static let shared = ApiManager()
    
    private init(){}
    
    func post(url: String, params: [String:Any] ,completion: @escaping (Result<Data?, AFError>) -> ()){
        
        AF.request(url, method: .post, parameters: params).response { response in
            completion(response.result)
        }
    }
    
    func get(url: String, completion: @escaping (Result<Data?, AFError>) -> () ){
        AF.request(url).response { response in
            completion(response.result)
        }
    }
   
}
