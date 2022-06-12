//
//  UserRegisterData.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 25/05/2022.
//

import Foundation

struct UserRegisterData: Codable {
    let success: Bool
    let data: UserData
    let message: String
}

struct UserData: Codable {
    let user: User
    let token: String
}

struct User: Codable {
    let name, email, password: String
    let roleId: Int
    let updatedAt, createdAt: String
    let id: Int
}

//struct UserRegisterError: Codable {
//    let message: String
//    let errors: Errors
//}
//
//struct Errors: Codable {
//    let email: [String]
//}
