//
//  SignUpViewModel.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 24/5/22.
//

import Foundation

class SignUpViewModel{
    
    private var delegate : ViewControllerDelegate?
    
    private var nameValidation: Bool = false
    private var emailValidation: Bool = false
    private var passwordValidation : Bool = false
    private var confPasswordValidation : Bool = false
    
    init(delegate : ViewControllerDelegate){
        self.delegate = delegate
    }
    
    func login(email:String, password:String){
        
    }
}
//MARK: - FuntionsToActivateRegister
extension SignUpViewModel{
    func showButtonRegister(){
        if nameValidation && emailValidation && passwordValidation && confPasswordValidation{
            self.delegate?.activateRegister()
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
                _ = "The name must have more that 2 characters"
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
            self.delegate?.messageError(message: message)
        }
    }

    //MARK: - Validation Email
    func validateEmail(value: String?){
        if let emailValue = value{
            let regularExpresion = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format: "SELF MATCHES %@",regularExpresion)
            if !predicate.evaluate(with: emailValue){
                validateEmailCount(value: emailValue)
                emailValidation = false
            } else{
                emailValidation = true
            }
        }
        showButtonRegister()
    }

    func validateEmailCount(value: String){
        if value.count > 30{
            let message = "Please type an email address. example@gmail.com"
            self.delegate?.messageError(message: message)
        }
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
            }else{
                self.delegate?.messagePassword(message: "Passwords are not the same")
            }
        }
        showButtonRegister()
    }

    
}

