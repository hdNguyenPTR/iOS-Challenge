//
//  LoginSpy.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Moya
import Result
@testable import iOSIdWallDogChallenge

struct LoginServiceSpy: BaseService, LoginServiceProtocol {
    typealias Target = IdWallDogAPI
    let statusCode: Int
    let email: String
    let networkMock: NetworkMock<Target>
    
    init(statusCode: Int, email: String = "jv@gmail.com") {
        self.statusCode = statusCode
        self.email = email
        networkMock = NetworkMock<Target>(statusCode: statusCode)
    }
    
    func signup(_ email: String,
                completion: @escaping (Result<User, ServiceError>) -> ()) {
        networkMock.provider.request(.sigup(email)) { result in
            completion(self.handle(result: result))}
    }
}
