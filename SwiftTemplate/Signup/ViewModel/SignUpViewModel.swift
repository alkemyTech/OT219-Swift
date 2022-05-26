//
//  SignUpViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 25/05/2022.
//

import Foundation

protocol SignUpViewModelDelegate {
    func userRegisterSuccess()
    func userRegisterError()
}

class SignUpViewModel {
    var signUpManager = SignUpManager()
    var delegate: SignUpViewModelDelegate?
    
    init(signUpManager: SignUpManager, delegate: SignUpViewModelDelegate) {
        self.signUpManager = signUpManager
        self.delegate = delegate
    }
    
    func register(name: String, email: String, pass: String) {
        let user = NewUser(name: name, email: email, password: pass)
        signUpManager.registerUser(user: user) { response in
            self.delegate?.userRegisterSuccess()
        } didFail: {
            self.delegate?.userRegisterError()
        }

    }
}

