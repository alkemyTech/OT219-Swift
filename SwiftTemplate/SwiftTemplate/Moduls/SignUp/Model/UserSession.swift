//
//  UserSession.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 25/5/22.
//

import Foundation

struct UserSession{
    var userName: String?
    var emailAddress: String?
    var password: String?
    var confirmPassword : String?
    
    init(userName: String, email: String, password: String, confirmPassword: String){
        self.userName = userName
        self.emailAddress = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
