//
//  SlidesService.swift
//  SwiftTemplate
//
//  Created by Alejandro Martinez on 7/06/22.
//

import Foundation

import Foundation

struct SlidesService {
    
    static let shared = SlidesService()
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endpointSlides = ProcessInfo.processInfo.environment["endpoint.Slides"]!
    
    
    func fetchSlides(onComplete: @escaping ([Slides]) -> (), onError: @escaping (String) -> ()){
        ApiManager.shared.get(url: "\(baseURL)\(endpointSlides)") { response in
            switch response{
            case .success(let data):
                do{
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(SlidesResponse.self, from: data)
                        if response.success {
                            onComplete(response.data)
                        }else {
                            onError(ApiError.noSlidesData.errorDescription!)
                        }
                    }else{
                        onError(ApiError.noSlidesData.errorDescription!)
                    }
                }catch{
                    onError(ApiError.noSlidesData.errorDescription!)
                }
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
}
