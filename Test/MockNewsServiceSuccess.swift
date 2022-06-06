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
        
        let news1 = News(id: 1, name: "Prueba", content: nil, image: nil, categoryID: nil, createdAt: "1", updatedAt: "2", groupID: nil)
        let news2 = News(id: 2, name: "Prueba", content: nil, image: nil, categoryID: nil, createdAt: "1", updatedAt: "2", groupID: nil)
        let newsArray = [news1, news2]

            onComplete(newsArray)
    }
}
