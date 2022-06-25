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
    func showSpinner()
    func hiddenSpinner()

}

class LoginViewModel{
    	
    weak var delegate: LoginViewModelDelegate?
       
    func login(email: String, pass: String) {
        self.delegate?.showSpinner()
        let user = LoginUser(email: email, password: pass)
        LoginService.shared.login(user: user) { [weak self] token in
            let userDefaults = UserDefaults.standard
            userDefaults.set(token, forKey: "token")
            self?.delegate?.didSuccessUserLogin()
            self?.delegate?.hiddenSpinner()
        } onError: { [weak self] error in
            self?.delegate?.didFailUserLogin(error: error)
            self?.delegate?.hiddenSpinner()
        }
    }
}
