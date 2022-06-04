//
//  LoginViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 26/05/2022.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject{
    func didSuccessUserLogin()
    func didFailUserLogin(error: String)
    func showErrorLogin(message: String)
}

class LoginViewModel{
    	
    weak var delegate: LoginViewModelDelegate?
    
    private var email = "cristian"
    private var password = "cristian"
    
    func checkLogin(){
        let user = LoginUser(email: email, password: password)
        LoginService.shared.login(user: user) { [weak self] token in
            let userDefaults = UserDefaults.standard
            userDefaults.set(token, forKey: "token")
            self?.delegate?.didSuccessUserLogin()
        } onError: { [weak self] error in
            self?.delegate?.didFailUserLogin(error: error)
            self?.delegate?.showErrorLogin(message: error)
        }

    }
    
}
