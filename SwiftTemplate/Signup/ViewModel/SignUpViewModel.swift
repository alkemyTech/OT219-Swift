//
//  SignUpViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 25/05/2022.
//

import Foundation

protocol SignUpViewModelDelegate: AnyObject {
    func userRegisterSuccess()
    func userRegisterError()
}

class SignUpViewModel {
    var signUpManager = SignUpManager()
    weak var delegate: SignUpViewModelDelegate?
    
    func register(name: String, email: String, pass: String) {
        let user = NewUser(name: name, email: email, password: pass)
        signUpManager.registerUser(user: user) { response in
            self.delegate?.userRegisterSuccess()
        } didFail: {
            self.delegate?.userRegisterError()
        }

    }
}

