//
//  FeedViewModel.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 22/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation


protocol FeedRepresentable {
    var feedImages: [URL?]? { get }
}

struct Dog: FeedRepresentable {
    var feedImages: [URL?]?
    private var feed: Feed {
        didSet {
            feedImages = feed.list.map { URL(string: $0)}
        }
    }
    
    init(for feed: Feed) {
        self.feed = feed
    }
}


class FeedViewModel {
    private let service: FeedServiceProtocol
    
    var showFeed: (([String])->())?
    var showError: ((ServiceError)->())?
    var isLoading: ((Bool)->())?
    
    init(service: FeedServiceProtocol) {
        self.service = service
    }
    
    func getFeed(for category: String){
        isLoading?(true)
        service.feed(for: category) { [unowned self] response in
            switch response {
            case .success(let feed):
                self.showFeed?(feed.list)
            case .failure(let error):
                self.showError?(error)
            }
            self.isLoading?(false)
        }
    }
}
