//
//  LoginViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 26/05/2022.
//

import Foundation

protocol LoginViewModelDelegate{
    func didSuccessUserLogin()
    func didFailUserLogin(error: String)
}

class LoginViewModel{
    	
    private var service: LoginService
    private var delegate: LoginViewModelDelegate?
    
    init(service: LoginService, delegate: LoginViewModelDelegate){
        self.service = service
        self.delegate = delegate
    }
    
    private var email = "cristian"
    private var password = "cristian"
    
    func checkLogin(){
        let user = LoginUser(email: email, password: password)
        service.login(user: user) { [weak self] token in
            let userDefaults = UserDefaults.standard
            userDefaults.set(token, forKey: "token")
            self?.delegate?.didSuccessUserLogin()
        } onError: { [weak self] error in
            self?.delegate?.didFailUserLogin(error: error)
        }

    }
    
}
