//
//  FeedViewModelTest.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 23/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import XCTest
@testable import iOSIdWallDogChallenge

class FeedViewModelTest: XCTestCase {
    
    func testFeedLoading() {
        let sut = makeSut(statusCode: 200)
        var isLoading: Bool?
        
        sut.isLoading = { loading in
            isLoading = loading
        }
        
        sut.getFeed(for: Dog.husky.rawValue)
        
        
        XCTAssertFalse(isLoading ?? true)
    }
    
    func testGetFeedForHuskyBreed() {
        let sut = makeSut(statusCode: 200)
        var feed: Feed?
        sut.showFeed = { response in
            feed = response
        }
        
        sut.getFeed(for: Dog.husky.rawValue)
        
        XCTAssertEqual(feed?.category, Dog.husky.rawValue)
    }
    
    func testGetFeedForHoundBreed() {
        let sut = makeSut(statusCode: 200)
        var feed: Feed?
        
        sut.showFeed = { response in
            feed = response
        }
        
        sut.getFeed(for: Dog.hound.rawValue)
        
        
        XCTAssertEqual(feed?.category, Dog.hound.rawValue)
    }
    
    func testGetFeedForPugBreed() {
        let sut = makeSut(statusCode: 200)
        var feed: Feed?
        let dog = Dog.pug.rawValue
        
        sut.showFeed = { response in
            feed = response
        }
        
        sut.getFeed(for: dog)
        
        XCTAssertEqual(feed?.category, dog)
    }
    
    func testGetFeedForLabradorBreed() {
        let sut = makeSut(statusCode: 200)
        var feed: Feed?
        let dog = Dog.labrador.rawValue
        
        sut.showFeed = { response in
            feed = response
        }
        
        sut.getFeed(for: dog)
        
        XCTAssertEqual(feed?.category, dog)
    }
    
    func testShowFeedError() {
        let sut = makeSut(statusCode: 500)
        var serverError: ServiceError?
        
        sut.showError = { error in
            serverError = error
        }
        
        sut.getFeed(for: Dog.husky.rawValue)
        
        XCTAssertEqual(serverError, ServiceError.serverError)
    }
    
    func testBackToLoginAfterUnauthorizedResponse() {
        let sut = makeSut(statusCode: 401)
        var backToLogin: Bool = false
        
        sut.backToLogin = { _, _ in
            backToLogin = true
        }
        
        sut.getFeed(for: Dog.hound.rawValue)
        
        XCTAssertTrue(backToLogin)
    }
    
    private func makeSut(statusCode: Int) -> FeedViewModel{
        let apiService = FeedServiceSpy(statusCode: statusCode)
        let viewModel = FeedViewModel(service: apiService)
        
        return viewModel
    }
}
