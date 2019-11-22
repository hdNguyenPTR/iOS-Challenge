//
//  LoginApiDescriptor.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Moya

enum IdWallDogAPI {
    case sigup(_ email: String)
    case feed(_ category: String)
}

struct IdWallDogPath {
    static let baseUrl  = "https://api-iddog.idwall.co/"
    static let sigup = "signup"
    static let feed = "feed"
}

extension IdWallDogAPI: TargetType {
    var baseURL: URL { return URL(string: IdWallDogPath.baseUrl)! }
    var path: String {
        switch self {
        case .sigup:
            return IdWallDogPath.sigup
        case .feed(_):
            return IdWallDogPath.feed
        }
    }
    var method: Moya.Method {
        switch self {
        case .sigup:
            return .post
        case .feed(_):
            return .get
        }
    }
    var task: Task {
        switch self {
            
        case .sigup(let email):
            return .requestParameters(
                parameters: ["email": email],
                encoding: JSONEncoding.default)
            
        case .feed(let category):
            return .requestParameters(parameters: ["category": category],
                                      encoding: URLEncoding(destination: .queryString))
            
        }
    }
    
    var sampleData: Data {
        switch self {
        case .sigup(let email):
            return """
                {
                "user": {
                "_id": "someId",
                "email": "\(email)",
                "token": "someToken",
                "createdAt": "2019-11-15T19:24:10.337Z",
                "updatedAt": "2019-11-15T19:24:10.337Z",
                "__v": 0
                }
                }
                """.utf8Encoded
        case .feed(let category):
            return """
                {
                    "category": "\(category)",
                    "list": [
                    "https://images.dog.ceo/breeds/hound-english/n02089973_1.jpg"
                    ]
            
            }
            """.utf8Encoded
        }
        
    }
    
    public var headers: [String: String]? {
        switch  self {
        case .sigup:
            return [
                "Content-Type": "application/json"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Token"
            ]
        }
        
    }
}

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

