//
//  SignUpManager.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 25/05/2022.
//

import Foundation
import Alamofire

struct SignUpManager {
    let url = ProcessInfo.processInfo.environment["baseURL"]
    
    func registerUser(user: NewUser, didSignUp: @escaping (UserRegisterData) -> (), didFail: @escaping () -> ()) {
        guard let parameters = user.dictionary else {return}
        post(url: "\(url!)api/register", params: parameters, completion: { response in
            switch response {
                case .success(let data):
                    do {
                        if let data = data {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let resp = try decoder.decode(UserRegisterData.self, from: data)
                            didSignUp(resp)
                        } else {
                            didFail()
                        }
                    } catch {
                        didFail()
                    }
                case .failure(_):
                    didFail()
            }
        })
    }
    
    func post(url: String, params: [String:Any] ,completion: @escaping (Result<Data?, AFError>) -> Void) {
        print(url)
        AF.request(url, method: .post, parameters: params).validate().response { response in
            completion(response.result)
        }
    }
}
