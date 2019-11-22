//
//  NetworkMock.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 21/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Moya

struct NetworkMock<T: TargetType> {
    typealias Target = T
    let statusCode: Int
    
    init(statusCode: Int) {
        self.statusCode = statusCode
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
}
