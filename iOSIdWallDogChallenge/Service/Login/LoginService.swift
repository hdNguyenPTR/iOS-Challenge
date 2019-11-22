//
//  LoginService.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Result

protocol LoginServiceProtocol {
    func signup(_ email: String,
               completion: @escaping (Result<User, ServiceError>)->())
}

struct LoginService: BaseService, LoginServiceProtocol {
    typealias Target = IdWallDogAPI
    
    func signup(_ email: String,
               completion: @escaping (Result<User, ServiceError>)->()) {
        provider.request(.sigup(email)) { result in
            completion(self.handle(result: result))
        }
    }
}

