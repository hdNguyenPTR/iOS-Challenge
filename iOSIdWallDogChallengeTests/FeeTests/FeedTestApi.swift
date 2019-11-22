//
//  FeedTestApi.swift
//  iOSIdWallDogChallengeTests
//
//  Created by joão lucas on 21/11/19.
//  Copyright © 2019 jv. All rights reserved.
//
import XCTest
import Moya
import Result
@testable import iOSIdWallDogChallenge

class  FeedApiTests: XCTestCase {
    var serviceError: ServiceError?
    
    func testFeed_response200() {
        let sut = makeSUT(code: 200)
        var feed: Feed?
        
        sut.feed(for: "hound") { response in
            switch response {
            case .success(let data):
                feed = data
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertEqual(feed?.category, "hound")
    }
    
    func testLogin_response401() {
        let sut = makeSUT(code: 401)
        
        sut.feed(for: "jv@gmail.com") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .unauthorized)
    }
    
    func testLogin_responseNoInternetConnection() {
        let sut = makeSUT(code: NSURLErrorNotConnectedToInternet)
        
        sut.feed(for: "husky") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .notConnectedToInternet)
    }
    
    func testLogin_response404() {
        let sut = makeSUT(code: 404)
        
        sut.feed(for: "lol") { response in
            switch response {
            case .success(_ ): break
            case .failure(let error):
                self.serviceError = error
            }
        }
        
        XCTAssertEqual(serviceError, .notFound)
    }
    
    func makeSUT(code: Int, category: String = "husky")-> FeedServiceSpy{
        let feedService = FeedServiceSpy(statusCode: code,
                                           category: category)
        return feedService
    }
}


