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
        sut = HomeViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_HomeViewModel_GetsNewsData_ShouldReturnData(){
        
        sut.getNewsData()
        
        let expectation = XCTestExpectation(description: "Should have data")
        
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(sut.getNewsCount)
    }

}
