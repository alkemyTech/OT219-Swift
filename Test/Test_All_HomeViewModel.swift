//
//  Test_All_HomeViewModel.swift
//  Test
//
//  Created by Adriancys Jesus Villegas Toro on 14/6/22.
//

import XCTest
@testable import SwiftTemplate

class Test_All_HomeViewModel: XCTestCase {

    var homeViewModel : HomeViewModel!
    
    override func setUp() {
        homeViewModel = HomeViewModel()
    }
    

    
    //MARK: - Welcome Methods
    
    func test_LookDescriptionWelcomeData_NotNil(){
        let data = homeViewModel.getDescriptionWelcome()
        XCTAssertNotNil(data)
    }
    
    func test_LookImagenWelcomeData_NotNil(){
        let data = homeViewModel.getImageWelcome()
        XCTAssertNotNil(data)
    }
    
    //MARK: - News
    func test_NewsService_ShouldReturnData(){
        let mock = MockNewsServiceSuccess()
        homeViewModel = HomeViewModel(newsService: mock)
        
        let expectation = XCTestExpectation(description: "Should return data")
        homeViewModel.newsService.fetchNews { news in
            XCTAssertTrue(news.count > 0)
            expectation.fulfill()
        } onError: { error in
            XCTAssertTrue(error.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func test_NewsService_ShouldReturnError(){
        let mock = MockNewsServiceFail()
        homeViewModel = HomeViewModel(newsService: mock)
        
        let expectation =  XCTestExpectation(description: "Should return error")
        
        homeViewModel.newsService.fetchNews { news in
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
        homeViewModel = HomeViewModel(testimonio: mock)
         
        homeViewModel.testimonialService.fetchTestimonials { testimonials in
            XCTAssertTrue(testimonials.count > 0)
        } onError: { error in
            XCTAssertEqual(error, "")
        }
    }
    
    func test_TestimonialsService_ShouldReturnError(){
        let mock = MockTestimonialsFail()
        homeViewModel = HomeViewModel( testimonio: mock)
        
        homeViewModel.testimonialService.fetchTestimonials { testimonials in
            XCTAssertNil(testimonials)
            
        } onError: { error in
            XCTAssertEqual(error, "Testimonials data is not available")
        }
    }
    
    
}
