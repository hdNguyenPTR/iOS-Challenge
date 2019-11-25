//
//  iOSIdWallDogChallengeTests.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import XCTest

@testable import iOSIdWallDogChallenge

class LoginApiTests: XCTestCase {
    var serviceError: ServiceError?
    
    func testLoginResponse200() {
        let sut = makeSUT(code: 200)
        var user: User?
        
        sut.signup("jv@gmail.com") { response in
            switch response {
            case .success(let data):
                user = data
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertEqual(user!.user.email, "jv@gmail.com")
    }
    
    func testLoginResponse401() {
        let sut = makeSUT(code: 401)
        
        sut.signup("jv@gmail.com") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .unauthorized)
    }
    
    func testLoginResponseNoInternetConnection() {
        let sut = makeSUT(code: NSURLErrorNotConnectedToInternet)
        
        sut.signup("jv@gmail.com") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .notConnectedToInternet)
    }
    
    func testLoginResponse404() {
        let sut = makeSUT(code: 404)
        
        sut.signup("jv@gmail.com") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .notFound)
    }
    
    func testLoginResponse500() {
        let sut = makeSUT(code: 500)
        
        sut.signup("jv@gmail.com") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .serverError)
    }
    
    func testLoginResponseUnexpected() {
        let sut = makeSUT(code: 100)
        
        sut.signup("jv@gmail.com") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .unexpected)
    }
    
    func makeSUT(code: Int, email: String = "jv@gmail.com")-> LoginServiceSpy{
        let loginService = LoginServiceSpy(statusCode: code,
                                           email: email)
        return loginService
    }
}


