//
//  Test_Signup_ViewModel.swift
//  Test
//
//  Created by Cristian Sancricca on 18/06/2022.
//

import XCTest
@testable import SwiftTemplate

class Test_Signup_ViewModel: XCTestCase {

    var sut: SignUpViewModel!
    
    override func setUpWithError() throws {
        sut = SignUpViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_SignupViewModel_ShouldValidateCorrectUserDates(){
        let name = "Cristian"
        let email = "cris@gmail.com"
        let password = "Crisan22"
        let confirmPassword = "Crisan22"
        
        
        sut.validateName(value: name)
        sut.validateEmail(value: email)
        sut.validatePasswordA(value: password)
        sut.validateSamePassword(valueA: password, valueB: confirmPassword)
        
        XCTAssertTrue(sut.nameValidation)
        XCTAssertTrue(sut.emailValidation)
        XCTAssertTrue(sut.passwordValidation)
        XCTAssertTrue(sut.confPasswordValidation)
        
        
    }

    func test_SignupViewModel_ShouldNotValidateWrongUserDates(){
        let nameWithNumber = "Cristian9"
        let wrongEmail = "cris.com"
        let password = "crisan"
        let confirmPassword = "sancri"
        
        sut.validateName(value: nameWithNumber)
        sut.validateEmail(value: wrongEmail)
        sut.validatePasswordA(value: password)
        sut.validateSamePassword(valueA: password, valueB: confirmPassword)
        
        XCTAssertFalse(sut.nameValidation)
        XCTAssertFalse(sut.emailValidation)
        XCTAssertFalse(sut.passwordValidation)
        XCTAssertFalse(sut.confPasswordValidation)
        
        
    }

}
