//
//  LoginService.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 26/05/2022.
//

import Foundation

struct LoginService {
    
    static let shared = LoginService()
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endpointLogin = ProcessInfo.processInfo.environment["endpoint.Login"]!
    
    
    func login(user: LoginUser, onComplete: @escaping (String) -> (), onError: @escaping (String) ->() ){
        	
        guard let email = user.email else {return}
        guard let password = user.password else {return}
        
        let params = ["email": email, "password": password]
        
        ApiManager.shared.post(url: "\(baseURL)\(endpointLogin)", params: params) { response in
            switch response{
            case .success(let data):
                do{
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(LoginUserResponse.self, from: data)
                        if response.success {
                            onComplete(response.data.token)
                        }else{
                            onError(ApiError.loginError.errorDescription!)
                        }
                    } else {
                        onError(ApiError.loginError.errorDescription!)
                    }
                }catch{
                    onError(ApiError.loginError.errorDescription!)
                }
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
}
