//
//  User.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation

struct User: Codable {
    let user: LoginResponse
}

struct LoginResponse: Codable {
    let id, email, token, createdAt: String
    let updatedAt: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, token, createdAt, updatedAt
        case v = "__v"
    }
}
