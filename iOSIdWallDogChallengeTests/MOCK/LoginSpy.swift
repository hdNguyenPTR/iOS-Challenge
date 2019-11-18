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
}
