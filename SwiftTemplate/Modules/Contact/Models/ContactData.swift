//
//  ContactModel.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 21/06/2022.
//

import Foundation

struct ContactData: Codable {
    let success: Bool
    let data: MessageData
    let message: String
}

struct MessageData: Codable {
    let updated_at: String
    let created_at: String
    let id: Int
}
