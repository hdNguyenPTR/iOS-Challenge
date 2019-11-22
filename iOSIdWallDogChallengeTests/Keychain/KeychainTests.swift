//
//  KeychainTests.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 21/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import XCTest
@testable import iOSIdWallDogChallenge

class KeychainTests: XCTestCase {
    var storage: Storage!
    
    override func setUp() {
        super.setUp()
        storage = makeSut()
    }
    
    func testSaveToken() {
        let token = storage.get(for: "token")
        
        XCTAssertEqual(token, "1234")
    }
    
    func testRemoveToken() {
        let isRemoved = storage.remove(for: "token")
        
        XCTAssertTrue(isRemoved)
    }
    
    func testWrongKeyToRetrieve() {
        let token = storage.get(for: "wrongkey")
    
        XCTAssertNil(token)
    }
    
    func testWrongKeyToRemove() {
        let token = storage.remove(for: "wrongkey")
  
        XCTAssertFalse(token)
    }
    
    func makeSut()-> Storage {
        let storage = LocalStorage()
        let isSaved = storage.save(data: "1234", key: "token")
        XCTAssertTrue(isSaved)
        return storage
        
    }
}
