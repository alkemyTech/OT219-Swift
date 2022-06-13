//
//  MockNewsServiceFail.swift
//  Test
//
//  Created by Cristian Sancricca on 06/06/2022.
//

import Foundation
@testable import SwiftTemplate

class MockNewsServiceFail: NewsFetching{
    
    func fetchNews(onComplete: @escaping ([News]) -> (), onError: @escaping (String) -> ()) {
            onError(ApiError.noNewsData.errorDescription!)
    }
}
