//
//  FeedSpy.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 21/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Moya
import Result
@testable import iOSIdWallDogChallenge

struct FeedServiceSpy: BaseService, FeedServiceProtocol {
    
    typealias Target = IdWallDogAPI
    let statusCode: Int
    let category: String
    let networkMock: NetworkMock<Target>
    
    init(statusCode: Int, category: String = "husky") {
        self.statusCode = statusCode
        self.category = category
        networkMock = NetworkMock<Target>(statusCode: statusCode)
    }
    
    func feed(for category: String,
              completion: @escaping (Result<Feed, ServiceError>)->()) {
        networkMock.provider.request(.feed(category)) { result in
            completion(self.handle(result: result))}
    }
}
