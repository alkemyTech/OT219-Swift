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

    //MARK: - Welcome
    func test_LookDescriptionWelcomeData_NotNil(){
        sut = HomeViewModel()
        let data = sut.getDescriptionWelcome()
        XCTAssertNotNil(data)
    }

    func test_LookImagenWelcomeData_NotNil(){
        sut = HomeViewModel()
        let data = sut.getImageWelcome()
        XCTAssertNotNil(data)
    }

    //MARK: - News
    func test_HomeViewModel_GetsNewsData_ShouldReturnData(){
        let mock = MockNewsServiceSuccess()
        sut = HomeViewModel(newsService: mock)
        let expectation = XCTestExpectation(description: "Should return data")
        
        sut.newsService.fetchNews { news in
            XCTAssertTrue(news.count > 0)
            expectation.fulfill()
        } onError: { error in
            XCTAssertTrue(error.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func test_HomeViewModel_GetsNewsData_ShouldShowError(){
        let mock = MockNewsServiceFail()
        sut = HomeViewModel(newsService: mock)
        
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

    //MARK: - Testimonials
    func test_TestimonialsService_ShouldReturnData(){

        let mock = MockTestimonialsSuccess()
        sut = HomeViewModel(testimonio: mock)
         
        sut.testimonialService.fetchTestimonials { testimonials in
            XCTAssertTrue(testimonials.count > 0)
        } onError: { error in
            XCTAssertEqual(error, "")
        }
    }
    
    func test_TestimonialsService_ShouldReturnError(){
        let mock = MockTestimonialsFail()
        sut = HomeViewModel( testimonio: mock)
        
        sut.testimonialService.fetchTestimonials { testimonials in
            XCTAssertNil(testimonials)
            
        } onError: { error in
            XCTAssertEqual(error, "Testimonials data is not available")
        }
    }
}
