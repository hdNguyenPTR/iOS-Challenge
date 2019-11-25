//
//  Response+Decode.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 15/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Moya

extension Moya.Response {
    
    func parse<Item: Decodable>() throws -> Item {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try decoder.decode(Item.self, from: self.data)
        return model
    }
}
