//
//  Test_API_Login.swift
//  Test_API_Login
//
//  Created by Cristian Sancricca on 27/05/2022.
//


import XCTest
@testable import SwiftTemplate

class Test_API_Login: XCTestCase {

    var sut: LoginService!
    
    override func setUp() {
        sut = LoginService()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_LoginService_WithValidUser_ShouldReturnAValidToken(){
        
        let expectation = XCTestExpectation(description: "Should return a valid token")
        
        let user = LoginUser(email: "cristian", password: "cristian")
        sut.login(user: user) { userToken in
            XCTAssertNotNil(userToken)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_LoginService_WithInvalidUser_ShouldReturnAError(){
        
        let expectation = XCTestExpectation(description: "Should return a error")
        
        let user = LoginUser(email: "cris", password: "cris")
        sut.login(user: user) { userToken in
            XCTAssertNil(userToken)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error, "The email address or password you entered is invalid")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    

}
