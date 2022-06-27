//
//  Test_Contact_ViewModel.swift
//  Test
//
//  Created by Cristian Costa on 25/06/2022.
//

import XCTest
@testable import SwiftTemplate

class Test_Contact_ViewModel: XCTestCase {
    var sut: ContactViewModel!

    override func setUpWithError() throws {
        sut = ContactViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    //Test Name
    func test_ContactViewModel_shouldValidateName() {
        let name = "Cristian"
        sut.validateName(value: name)
        XCTAssertTrue(sut.nameValidation)
    }
    
    func test_ContactViewModel_nameTooShort() {
        let name = "1c"
        sut.validateName(value: name)
        XCTAssertFalse(sut.nameValidation)
    }
    
    //Test Email
    func test_ContactViewModel_shouldValidateEmail() {
        let email = "cristian@gmail.com"
        sut.validateEmail(value: email)
        XCTAssertTrue(sut.emailValidation)
    }
    
    func test_ContactViewModel_shouldNotValidateEmail() {
        //Without domain
        var email = "cristian"
        sut.validateEmail(value: email)
        XCTAssertFalse(sut.emailValidation)
        
        //without userName
        email = "@gmail.com"
        sut.validateEmail(value: email)
        XCTAssertFalse(sut.emailValidation)
        
        //Incomplete domain
        email = "cristian@gmail."
        sut.validateEmail(value: email)
        XCTAssertFalse(sut.emailValidation)
    }
    
    //Test Message
    func test_ContactViewModel_shouldValidateMessage() {
        //Message > 9 chars
        let message = "0123456789"
        sut.validateMessage(value: message)
        XCTAssertTrue(sut.messageValidation)
    }
    
    func test_ContactViewModel_shouldNotValidateMessage() {
        //Message <= 9 chars
        let message = "012345678"
        sut.validateMessage(value: message)
        XCTAssertFalse(sut.messageValidation)
    }
}
