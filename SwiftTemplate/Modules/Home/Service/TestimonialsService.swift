//
//  TestimonialsService.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 10/06/2022.
//

import Foundation

protocol TestimonialsFetching {
    func fetchTestimonials(onComplete: @escaping ([Testimonials]) -> (), onError: @escaping (String) -> ())
}

struct TestimonialsService: TestimonialsFetching {

    static let shared = TestimonialsService()
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endpointTestimonials = ProcessInfo.processInfo.environment["endpoint.Testimonials"]!
    
    func fetchTestimonials(onComplete: @escaping ([Testimonials]) -> (), onError: @escaping (String) -> ()){
        ApiManager.shared.get(url: "\(baseURL)\(endpointTestimonials)") { response in
            switch response{
            case .success(let data):
                do{
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(TestimonialsResponse.self, from: data)
                        if response.success {
                            onComplete(response.data)
                        }else {
                            onError(ApiError.noTestimonialsData.errorDescription!)
                        }
                    }else{
                        onError(ApiError.noTestimonialsData.errorDescription!)
                    }
                }catch{
                    onError(ApiError.noTestimonialsData.errorDescription!)
                }
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
}
