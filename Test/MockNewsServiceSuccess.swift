//
//  MockNewsServiceSuccess.swift
//  Test
//
//  Created by Cristian Sancricca on 06/06/2022.
//

import Foundation
@testable import SwiftTemplate

class MockNewsServiceSuccess: NewsFetching{
    
    func fetchNews(onComplete: @escaping ([News]) -> (), onError: @escaping (String) -> ()) {
        
        let url = Bundle.main.url(forResource: "NewsMock", withExtension: "json")
        print(url)
        do{
            let decoder = JSONDecoder()
            let jsonData = try Data(contentsOf: url!)
            let model = try decoder.decode(NewsResponse.self, from: jsonData)
            onComplete(model.data)
        } catch{
            onError("")
        }
        
        

    }
}
