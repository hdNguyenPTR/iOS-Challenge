//
//  FeedService.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 21/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Result

protocol FeedServiceProtocol {
    func feed(for category: String,
                completion: @escaping (Result<Feed, ServiceError>)->())
}

struct FeedService: BaseService, FeedServiceProtocol {
    typealias Target = IdWallDogAPI
    
    func feed(for category: String,
                completion: @escaping (Result<Feed, ServiceError>)->()) {
        provider.request(.feed(category)) { result in
            completion(self.handle(result: result))
        }
    }
}
