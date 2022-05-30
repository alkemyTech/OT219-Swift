//
//  LoginUserResponse.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 26/05/2022.
//

import Foundation

struct LoginUserResponse: Codable {
    let success: Bool
    let data: LoginData
    let message: String
}


struct LoginData: Codable {
    let user: UserLogin
    let token: String
}


struct UserLogin: Codable {
    let id: Int
    let name, email: String
}
