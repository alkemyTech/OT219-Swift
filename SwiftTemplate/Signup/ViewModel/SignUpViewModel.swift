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
        
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        }
        
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "[A-Z0-9a-z]"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
            }

    }
}

