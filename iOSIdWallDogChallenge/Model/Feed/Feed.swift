//
//  Feed.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation

protocol DogRepresentable {
    
    var imageURL: URL? { get }
        
}
struct Feed: Codable {
    let category: String
    let list: [String]
}
