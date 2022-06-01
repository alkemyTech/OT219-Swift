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
    func showAlertsTextFields(messages: String)
    func activateButton()
    func desactivateButton()
    func labelPasswordShow()
    func labelPasswordNotShow()
}

class SignUpViewModel {
    
    private var nameValidation: Bool = false
    private var emailValidation: Bool = false
    private var passwordValidation : Bool = false
    private var confPasswordValidation : Bool = false
    
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

//MARK: - FuntionsToActivateRegister
extension SignUpViewModel{
    func showButtonRegister(){
        if nameValidation && emailValidation && passwordValidation && confPasswordValidation{
//            activate Button
            self.delegate?.activateButton()
        }else {
            self.delegate?.desactivateButton()
        }
    }
}

//MARK: - ValidateData
extension SignUpViewModel{

    //MARK: - ValidationName
    func validateName(value: String?){
        if let nameValue = value{
            validationNameCharacters(value: nameValue)
            if nameValue.count < 3{
                let message = "The name must have more that 2 characters"
                self.delegate?.showAlertsTextFields(messages: message)
                nameValidation = false
            }else{
                nameValidation = true
            }
        }
        showButtonRegister()
    }

    func validationNameCharacters(value: String){
        let decimalCharters = CharacterSet.decimalDigits
        let decimalRange = value.rangeOfCharacter(from: decimalCharters)
        if decimalRange != nil{
            let message = "Plase don't used number un your name"
            self.delegate?.showAlertsTextFields(messages: message)
        }
    }

    //MARK: - Validation Email
    func validateEmail(value: String?){
        
        if let emailValue = value{
                let regularExpresion = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
                if !predicate.evaluate(with: emailValue){
                    let message = "Please type an email address. example@gmail.com"
                    self.delegate?.showAlertsTextFields(messages: message)
                    emailValidation = false
                } else{
                    emailValidation = true
                }
        }
        showButtonRegister()
    }

    //MARK: - Validate Password
    func validatePasswordA(value: String?){
        if let passwordValue = value{
            if passwordValue.count < 6{
                passwordValidation = false
            }else{
                if contentDigit(value: passwordValue) &&
                    contentLowerCase(value: passwordValue) &&
                    contentUpperCase(value: passwordValue) {
                    passwordValidation = true
                }else{
                    let message = "Please use uppercase, lowercase and numbers to create a password"
                    self.delegate?.showAlertsTextFields(messages: message)
                    passwordValidation = false
                }
            }
        }
        showButtonRegister()
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

    func validateSamePassword(valueA: String?, valueB: String?){
        if let passA = valueA, let passB = valueB{
            if passA == passB{
                confPasswordValidation = true
                self.delegate?.labelPasswordNotShow()
            }else{
                self.delegate?.labelPasswordShow()
            }
        }
        showButtonRegister()
    }
}
