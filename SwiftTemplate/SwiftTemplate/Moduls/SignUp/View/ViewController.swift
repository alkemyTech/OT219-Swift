//
//  ViewController.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 24/5/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    private var viewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupTextFields(){
//        name.addTarget(self, action: #selector(viewModel.), for: <#T##UIControl.Event#>)
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if viewModel.validateTextFields(name: name.text, email: email.text, password: password.text, confirmPassword: confirmPassword.text) == true{
            buttonOutlet.backgroundColor = .green
        }else {
            buttonOutlet.backgroundColor = .red
        }
        
        
    }
    
}
