//
//  NewsResponse.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 31/05/2022.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let success: Bool
    let data: [News]
    let message: String
}

// MARK: - News
struct News: Codable {
    let id: Int
    let name: String?
    let content: String?
    let image: String?
    let categoryID: Int?
    let createdAt, updatedAt: String
    let groupID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, content, image
        case categoryID = "category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case groupID = "group_id"
    }    
}
