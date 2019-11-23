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

    func testGetDefaultFeed() {
        let sut = makeSut(statusCode: 200)
        var feed: Feed?
        sut.showFeed = { response in
            feed = response
        }
        
        sut.getFeed(for: "husky")
        
        XCTAssertEqual(feed?.category, "husky")
    }
    
    func testFeed_showError() {
        let sut = makeSut(statusCode: 500)
        var serverError: ServiceError?
        
        sut.showError = { error in
            serverError = error
        }
        
        sut.getFeed(for: "husky")
        
        XCTAssertEqual(serverError, ServiceError.serverError)
    }
    
    func testFeedLoading() {
        let sut = makeSut(statusCode: 200)
        var isLoading: Bool?
        
        sut.isLoading = { loading in
            isLoading = loading
        }
        
        sut.getFeed(for: "husky")
        
        
        XCTAssertFalse(isLoading ?? true)
    }
    
    private func makeSut(statusCode: Int) -> FeedViewModel{
        let apiService = FeedServiceSpy(statusCode: statusCode)
        let viewModel = FeedViewModel(service: apiService)
        
        return viewModel
    }
}
