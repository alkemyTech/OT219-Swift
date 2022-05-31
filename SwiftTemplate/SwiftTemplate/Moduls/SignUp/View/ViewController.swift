//
//  ViewController.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 24/5/22.
//

import UIKit

protocol ViewControllerDelegate{
    func textValidation() -> [String?]
    func messageError(message: String)
    func activateRegister()
    func messagePassword(message: String)
}

class ViewController: UIViewController {

    @IBOutlet weak var errorPasswordSame: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    private var viewModel : SignUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SignUpViewModel(delegate: self)
//        setupTarget()
        resetForm()
    }

    
    func resetForm(){
        buttonOutlet.isEnabled = false
        buttonOutlet.backgroundColor = .gray
        errorPasswordSame.isHidden = true
        
        name.text = ""
        email.text = ""
        password.text = ""
        confirmPassword.text = ""
    }

    @IBAction func nameChange(_ sender: Any) {
        viewModel?.validateName(value: name.text)
        
    }
    
    @IBAction func emailChange(_ sender: Any) {
        viewModel?.validateEmail(value: email.text)
    }
    
    @IBAction func passwordChange(_ sender: Any) {
        viewModel?.validatePasswordA(value: password.text)
    }
    
    @IBAction func confirmPasswordChange(_ sender: Any) {
        viewModel?.validateSamePassword(valueA: password.text, valueB: confirmPassword.text)
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
    }

    
}
//MARK: - ViewControllerDelegate

extension ViewController: ViewControllerDelegate{
    func messagePassword(message: String) {
        errorPasswordSame.isHidden = false
        errorPasswordSame.text = message
    }
    
    func activateRegister() {
        errorPasswordSame.isHidden = true
        buttonOutlet.isEnabled = true
        buttonOutlet.backgroundColor = .green
    }
    
    func messageError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func textValidation() -> [String?] {
        let allTextFields = [name.text, email.text, password.text, confirmPassword.text]
        return allTextFields
    }

    
}
//MARK: - TextFields

extension ViewController: UITextFieldDelegate{
}
