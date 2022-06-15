//
//  ApiError.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 29/05/2022.
//

import Foundation

enum ApiError {
    case loginError, noNewsData, noSlidesData, noTestimonialsData
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .loginError : return "The email address or password you entered is invalid"
        case .noNewsData : return "News data is not available"
        case .noSlidesData : return "Slides data is not available"
        case .noTestimonialsData : return "Testimonials data is not available"
        }
    }
}
