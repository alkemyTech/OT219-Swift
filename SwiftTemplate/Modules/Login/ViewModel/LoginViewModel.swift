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
    func activateButton()
    func desactivateButton()
    func requiredEmailLabel()
    func hiddenRequiredEmail()
    func requiredPasswordLabel()
    func hiddenRequiredPassword()
}

class LoginViewModel{
    	
    weak var delegate: LoginViewModelDelegate?
    
    
    var emailValidation = false
    var passwordValidation = false
    //MARK: - Login
    func login(email: String, pass: String) {
        let user = LoginUser(email: email, password: pass)
        LoginService.shared.login(user: user) { [weak self] token in
            let userDefaults = UserDefaults.standard
            userDefaults.set(token, forKey: "token")
            self?.delegate?.didSuccessUserLogin()
        } onError: { [weak self] error in
            self?.delegate?.didFailUserLogin(error: error)
        }
    }
    
    
    //MARK: - Activate Button
    func activaButton(){
        if emailValidation && passwordValidation{
            self.delegate?.activateButton()
            
        }else{
            self.delegate?.desactivateButton()
        }
    }
    
    //MARK: - Validations
    
    func validateEmail(email: String?){
        
        if let emailValue = email {
            let regularExpresion = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
            if !predicate.evaluate(with: emailValue){
                let message = "Type an email address. example@gmail.com"
                self.delegate?.didFailUserLogin(error: message)
                emailValidation = false
            }else{
                emailValidation = true
            }
        }
        activaButton()
    }
    
    func showRequiredEmail(email: String?){
        if let emailData = email{
            if emailData.isEmpty{
                self.delegate?.requiredEmailLabel()
            }else{
                self.delegate?.hiddenRequiredEmail()
            }
        }
    }
    
    func showRequiredPassword(password: String?){
        if let passwordValue = password {
            if passwordValue.count == 0{
                self.delegate?.requiredPasswordLabel()
            }else{
                self.delegate?.hiddenRequiredPassword()
            }
        }
    }
    
    func validationsPassword(password: String?){
        if let passwordValue = password{
            if passwordValue.count < 6{
                passwordValidation = false
            }else{
                
                if contentDigit(value: passwordValue) &&
                    contentLowerCase(value: passwordValue) &&
                    contentUpperCase(value: passwordValue) {
                    passwordValidation = true
                }else{
                    let message = "Please add more that 6 characters and use uppercase, lowercase and numbers to create a password"
                    self.delegate?.didFailUserLogin(error: message)
                    passwordValidation = false
                }
            }
        }
        activaButton()
    }
    
    func contentDigit(value: String) -> Bool{
        let regularExpresion = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }

    func contentLowerCase(value: String) -> Bool{
        let regularExpresion = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }

    func contentUpperCase(value: String) -> Bool{
        let regularExpresion = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
        return predicate.evaluate(with: value)
    }
}
