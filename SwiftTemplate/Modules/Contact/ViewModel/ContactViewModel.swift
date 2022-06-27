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
    func sendMessageSuccess()
    func sendMessageError()
}

class ContactViewModel {
    var nameValidation: Bool = false
    var emailValidation: Bool = false
    var messageValidation: Bool = false

    weak var delegate: ContactViewModelDelegate?
    var contactServive = ContactService()

    func send(name: String, email: String, message: String) {
        let message = ContactMessage(name: name, email: email, message: message)
        contactServive.postMessage(message: message) { response in
            self.delegate?.sendMessageSuccess()
        } didFail: {
            self.delegate?.sendMessageError()
        }
    }
    
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
                messageValidation = false
            } else {
                messageValidation = true
            }
        }
        showButtonRegister()
    }
    
    func showAlertMessage(value: String?) {
        if let message = value {
            if message.count < 10 {
                let message = "The message must have more than 10 characters"
                self.delegate?.showAlertsTextFields(messages: message)
                messageValidation = false
            } else {
                messageValidation = true
            }
        }
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
        } else {
            nameValidation = true
        }
    }
    
    func resetButtonRegister() {
        nameValidation = false
        emailValidation = false
        messageValidation = false
        self.delegate?.desactivateButton()
    }
    
    func showButtonRegister(){
        if nameValidation && emailValidation && messageValidation {
            self.delegate?.activateButton()
        }else {
            self.delegate?.desactivateButton()
        }
    }
}
