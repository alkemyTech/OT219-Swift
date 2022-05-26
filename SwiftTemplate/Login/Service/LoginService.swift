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
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endpointLogin = ProcessInfo.processInfo.environment["endpoint.Login"]!
    
    
    func login(user: LoginUser, onComplete: @escaping (String) -> (), onError: @escaping (String) ->() ){
        	
        guard let email = user.email else {return}
        guard let password = user.password else {return}
        
        let params = ["email": email, "password": password]
        
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
