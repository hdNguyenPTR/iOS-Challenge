//
//  BaseService.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation
import Moya
import Result

protocol BaseService {
    associatedtype Target : TargetType
    var provider : MoyaProvider<Target> { get }
}

extension BaseService {

    var provider: MoyaProvider<Target> {
        return MoyaProvider<Self.Target>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }
    
    func handle<T: Codable>(result: Result<Moya.Response, MoyaError>) -> Result<T, ServiceError> {
        
        switch result {
        case let .success(response):
            
            switch response.statusCode {
            case 200...299:
                do {
                    let model = try response.parse() as T
                    return .success(model)
                } catch let error {
                    print(error)
                    return .failure(.modelMapping)
                }
                
            default:
                return .failure(.convert(MoyaError.statusCode(response)))
            }
        case let .failure(error):
            return .failure(.convert(error))
        }
    }
}
