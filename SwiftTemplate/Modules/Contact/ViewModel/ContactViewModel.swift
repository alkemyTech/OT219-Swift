//
//  ContactViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 19/06/2022.
//

import Foundation

protocol ContactViewModelDelegate: AnyObject {
    func activateButton()
    func desactivateButton()
    func showAlertsTextFields(messages: String)
}

class ContactViewModel {
    private var nameValidation: Bool = false
    private var emailValidation: Bool = false
    private var messageValidation: Bool = false

    
    weak var delegate: ContactViewModelDelegate?

    func validateName(value: String?){
        if let nameValue = value {
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
    
    func validateMessage(value: String?) {
        if let message = value {
            if message.count < 10 {
                let message = "The message must have more than 10 characters"
                self.delegate?.showAlertsTextFields(messages: message)
                messageValidation = false
            } else {
                messageValidation = true
            }
        }
        showButtonRegister()
    }
    
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
    
    func validationNameCharacters(value: String){
        let decimalCharters = CharacterSet.decimalDigits
        let decimalRange = value.rangeOfCharacter(from: decimalCharters)
        if decimalRange != nil{
            let message = "Plase don't used number un your name"
            self.delegate?.showAlertsTextFields(messages: message)
        }
    }
    
    func showButtonRegister(){
        if nameValidation && emailValidation && messageValidation {
            self.delegate?.activateButton()
        }else {
            self.delegate?.desactivateButton()
        }
    }
}
