//
//  LoginService.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 26/05/2022.
//

import Foundation

struct LoginService {
    
    enum LoginError: String{
        case genericError = "The email address or password you entered is invalid"
    }
    
    static let shared = LoginService()
    
    let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    let endpointLogin = ProcessInfo.processInfo.environment["endpoint.Login"]!
    
    let params = ["email": "cristian", "password": "cristian"]
    
    func login(onComplete: @escaping (String) -> (), onError: @escaping (String) ->() ){
        
        ApiManager.shared.loginUser(url: "\(baseURL)\(endpointLogin)", params: params) { response in
            switch response{
            case .success(let data):
                do{
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(LoginUserResponse.self, from: data)
                        if response.success {
                            onComplete(response.data.token)
                        }else{
                            onError(response.message)
                        }
                    } else {
                        onError(LoginError.genericError.rawValue)
                    }
                }catch{
                    onError(LoginError.genericError.rawValue)
                }
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
}
