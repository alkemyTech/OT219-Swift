//
//  SignUpViewModel.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 24/5/22.
//

import Foundation
import UIKit

class SignUpViewModel{
    
    func login(email:String, password:String){
        
    }
    
    

}
//MARK: - Validate
extension SignUpViewModel{

 
    func validateTextFields(name: String?, email: String?, password: String?, confirmPassword: String?)-> Bool{
        var button = Bool()
        if name!.isEmpty || email!.isEmpty || password!.isEmpty || confirmPassword!.isEmpty{
            print("block login")
            button = false
        }else {
            print("change color")
            validateData(name: name, email: email, password: password, confirmPassword: confirmPassword)
            button = true
        }
        return button
    }
    
    private func validateData(name: String?, email: String?, password: String?, confirmPassword: String?){
        
        
    }
    
    
    
}
