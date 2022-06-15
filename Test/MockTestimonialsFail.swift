//
//  MockTestimonialsFail.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 14/6/22.
//

import Foundation
@testable import SwiftTemplate

class MockTestimonialsFail: TestimonialsFetching{
    func fetchTestimonials(onComplete: @escaping ([Testimonials]) -> (), onError: @escaping (String) -> ()) {
        onError(ApiError.noTestimonialsData.errorDescription!)
    }
    
    
}
