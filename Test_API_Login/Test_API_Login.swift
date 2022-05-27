//
//  Test_API_Login.swift
//  Test_API_Login
//
//  Created by Cristian Sancricca on 27/05/2022.
//


import XCTest
@testable import SwiftTemplate

class Test_API_Login: XCTestCase {

    var service: LoginService!
    
    override func setUp() {
        service = LoginService()
    }
    
    override func tearDown() {
        service = nil
    }
    
    func test_Login_With_Valid_User(){
        //let service = LoginService()
        
        let expectation = XCTestExpectation(description: "Should return a valid token")
        
        let user = LoginUser(email: "cristian", password: "cristian")
        service.login(user: user) { userToken in
            XCTAssertNotNil(userToken)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_Login_With_Invalid_User(){
        let service = LoginService()
        
        let expectation = XCTestExpectation(description: "Should return a error")
        
        let user = LoginUser(email: "cris", password: "cris")
        service.login(user: user) { userToken in
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
