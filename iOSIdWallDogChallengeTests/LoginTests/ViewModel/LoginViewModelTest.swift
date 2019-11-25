//
//  LoginViewModelTest.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import XCTest
@testable import iOSIdWallDogChallenge

class LoginViewModelTest: XCTestCase {

    func testLoginToGoToFeedAfterSignUp() {
        let sut = makeSut(statusCode: 200)
        var user: User?
        let email = "jvlucas@g.com.br"
        
        sut.goToFeed = { userResponse in
            user = userResponse
        }
        
        sut.login(email)
      
        XCTAssertEqual(user?.user.email, email)
    }
    
    func testShowLoginError() {
        let sut = makeSut(statusCode: 500)
        var serverError: ServiceError?
        
        sut.showError = { error in
            serverError = error
        }
        
        sut.login("jvlucas@g.com.br")
        
        XCTAssertEqual(serverError, ServiceError.serverError)
    }
    
    func testInvalidEmail() {
        let sut = makeSut(statusCode: 200)
        var isValidEmail = true
        
        sut.invalidEmailError = {
            isValidEmail = false
        }
        
        sut.login("aaaaa")
        
        XCTAssertFalse(isValidEmail)
    }
    
    func testEmailInputValidation() {
        let sut = makeSut(statusCode: 200)
        
        let validEmail = sut.isValid("cc@m.com")
        let validEmail2 = sut.isValid("cc@a.com")
        
        let notValidEmail = sut.isValid("aaaaa")
        let invalidEmailNoDot = sut.isValid("cc@")
        let invalidEmailWithDot = sut.isValid("cc@.")
        let emptyEmail = sut.isValid("")
        
        XCTAssertTrue(validEmail)
        XCTAssertTrue(validEmail2)
       
        XCTAssertFalse(notValidEmail)
        XCTAssertFalse(invalidEmailNoDot)
        XCTAssertFalse(invalidEmailWithDot)
        XCTAssertFalse(emptyEmail)
    }
    
    private func makeSut(statusCode: Int) -> LoginViewModel{
        let apiService = LoginServiceSpy(statusCode: statusCode)
        let viewModel = LoginViewModel(service: apiService)
        
        return viewModel
    }
}
