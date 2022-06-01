//
//  NewsService.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 31/05/2022.
//

import Foundation

struct NewsService {
    
    static let shared = NewsService()
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endpointNews = ProcessInfo.processInfo.environment["endpoint.News"]!
    
    
    func fetchNews(onComplete: @escaping ([News]) -> (), onError: @escaping (String) -> ()){
        ApiManager.shared.get(url: "\(baseURL)\(endpointNews)") { response in
            switch response{
            case .success(let data):
                do{
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(NewsResponse.self, from: data)
                        if response.success {
                            onComplete(response.data)
                        }else {
                            onError(ApiError.noNewsData.errorDescription!)
                        }
                    }else{
                        onError(ApiError.noNewsData.errorDescription!)
                    }
                }catch{
                    onError(ApiError.noNewsData.errorDescription!)
                }
            case .failure(let error):
                onError(error.localizedDescription)
            }
        }
    }
    
}
