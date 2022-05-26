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
    let user: User
    let token: String
}


struct User: Codable {
    let id: Int
    let name, email: String
}
