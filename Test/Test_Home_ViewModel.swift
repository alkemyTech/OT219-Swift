//
//  Test_Home_ViewModel.swift
//  Test
//
//  Created by Cristian Sancricca on 02/06/2022.
//

import XCTest
@testable import SwiftTemplate

class Test_Home_ViewModel: XCTestCase {
    
    var sut: HomeViewModel!

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_HomeViewModel_GetsNewsData_ShouldReturnData(){
        let mock = MockNewsServiceSuccess()
        sut = HomeViewModel(newsFetching: mock)
        let expectation = XCTestExpectation(description: "Should return data")
        
        sut.getNewsData()
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(sut.getNewsCount(), 2)
        XCTAssertEqual(sut.news[1].name, "Prueba")
    }
    
    func test_HomeViewModel_GetsNewsData_ShouldShowError(){
        let mock = MockNewsServiceFail()
        sut = HomeViewModel(newsFetching: mock)
        
        let expectation = XCTestExpectation(description: "Should return error")
        
        sut.newsService.fetchNews { news in
            XCTAssertNil(news)
            expectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, "News data is not available")
            expectation.fulfill()
        
        }

        wait(for: [expectation], timeout: 5)
        
    }

}
