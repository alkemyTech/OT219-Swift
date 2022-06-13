//
//  TestimonialsResponse.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 10/06/2022.
//

import Foundation

struct TestimonialsResponse: Codable {
    let success: Bool
    let data: [Testimonials]
}

struct Testimonials: Codable {
    let id: Int
    let name: String?
    let image: String?
    let description: String?
}
