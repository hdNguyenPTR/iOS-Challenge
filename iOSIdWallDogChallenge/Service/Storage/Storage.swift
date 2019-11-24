//
//  Storage.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 21/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol Storage {
    func save(data: String, key: String)->Bool
    func get(for key: String) -> String?
    func remove(for key: String)-> Bool
}

class LocalStorage: Storage {
    @discardableResult
    func remove(for key: String)-> Bool {
        return KeychainWrapper.standard.removeObject(forKey: key)
    }
    
    @discardableResult
    func save(data: String, key: String)->Bool {
        return KeychainWrapper.standard.set(data, forKey: key)
    }
    
    func get(for key: String) -> String?{
        return KeychainWrapper.standard.string(forKey: key)
    }
}
