//
//  LoginUser.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 26/05/2022.
//

import Foundation

struct LoginUser {
    let email: String?
    let password: String?
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
}
