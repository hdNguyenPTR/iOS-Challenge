//
//  ServiceError.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Moya

struct StatusCode {
    let code: [Int: ServiceError] = [401: .unauthorized,
                                    404: .notFound,
                                    400: .unauthorized,
                                    ]
}
public enum ServiceError: Swift.Error {
    case modelMapping
    case unexpected
    case unauthorized
    case serverError
    case notConnectedToInternet
    case notFound
    case badRequest
    
    static func convert(_ error: MoyaError) -> ServiceError {
        
        switch error {
        
        case .jsonMapping(_):
            return .modelMapping
            
        case let .statusCode(response):
            print("response.statusCode \(response.statusCode)")
            var serverError: ServiceError!
            
            switch response.statusCode {
                case let x where x >= 500:
                    serverError = .serverError
                case 404:
                    serverError = .notFound
                case 401:
                    serverError = .unauthorized
                case 400:
                    serverError = .badRequest
                case NSURLErrorNotConnectedToInternet:
                    serverError = .notConnectedToInternet
                default:
                    serverError = .unexpected
            }
            
            return serverError
        default:
            return .unexpected
        }
    }
}

