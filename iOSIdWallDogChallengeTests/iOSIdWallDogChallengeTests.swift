//
//  iOSIdWallDogChallengeTests.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import XCTest
import Moya
import Result
@testable import iOSIdWallDogChallenge

class iOSIdWallDogChallengeTests: XCTestCase {
    var serviceError: ServiceError?
    
    func testLogin_response200() {
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
    
    func testLogin_response401() {
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
    
    func testLogin_responseNoInternetConnection() {
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
    
    func testLogin_response404() {
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
    
    func makeSUT(code: Int, email: String = "jv@gmail.com")-> LoginServiceSpy{
        let loginService = LoginServiceSpy(statusCode: code,
                                           email: email)
        return loginService
    }
}

struct LoginServiceSpy: BaseService, LoginServiceProtocol {
    typealias Target = IdWallDogAPI
    let statusCode: Int
    let email: String
    
    init(statusCode: Int, email: String = "jv@gmail.com") {
        self.statusCode = statusCode
        self.email = email
    }
    
    var provider: MoyaProvider<Target> {
        return MoyaProvider<Target>(endpointClosure: getCustomEndpoint,
                                    stubClosure: MoyaProvider.immediatelyStub,
                                    plugins: [NetworkLoggerPlugin(verbose: true)])
    }
    
    private func getCustomEndpoint(_ target: Target)-> Endpoint{
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(self.statusCode, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    func signup(_ email: String,
                completion: @escaping (Result<User, ServiceError>) -> ()) {
        provider.request(.sigup(email)) { result in
            completion(self.handle(result: result))}
    }
    
    func load(completion: @escaping (Result<User, ServiceError>) -> ()) {
        signup(self.email) { response in
            switch response {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
