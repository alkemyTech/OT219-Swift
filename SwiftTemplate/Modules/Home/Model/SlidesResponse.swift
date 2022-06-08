//
//  SlidesResponse.swift
//  SwiftTemplate
//
//  Created by Alejandro Martinez on 7/06/22.
//

import Foundation


// MARK: - SlidesResponse
struct SlidesResponse: Codable {
    let success: Bool
    let data: [Slides]
    let message: String
}

// MARK: - Slides
struct Slides: Codable {
    let id: Int
    let name: String?
    let description: String?
    let image: String?
    let userID: Int
    let order: Int
   

    enum CodingKeys: String, CodingKey {
        case id, name, description, image, userID, order
     
    }
}
