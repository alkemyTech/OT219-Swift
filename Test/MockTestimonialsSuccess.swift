//
//  MockTestimonialsSuccess.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 14/6/22.
//

import Foundation
@testable import SwiftTemplate

class MockTestimonialsSuccess: TestimonialsFetching{
    
    func fetchTestimonials(onComplete: @escaping ([Testimonials]) -> (), onError: @escaping (String) -> ()) {
        let url = Bundle.main.url(forResource: "TestimonialsMock", withExtension: "json")
        do{
            let jsonFile = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let dataTestimonials = try decoder.decode(TestimonialsResponse.self, from: jsonFile)
            onComplete(dataTestimonials.data)
        }catch{
           onError("")
        }
    }
    
}
