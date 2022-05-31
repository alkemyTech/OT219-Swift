//
//  ApiError.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 29/05/2022.
//

import Foundation

enum ApiError {
    case loginError
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .loginError : return "The email address or password you entered is invalid"
        }
    }
}
