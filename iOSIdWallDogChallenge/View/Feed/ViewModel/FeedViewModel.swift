//
//  FeedViewModel.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 22/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation

class FeedViewModel {
    let service: FeedService
    let category: String
    
    let showFeed: ((Feed)->())?
    let showError: ((ServiceError)->())?
    
    init(service: FeedService, category: String) {
        self.service = service
        self.category = category
    }
    
    func getFeed(){
        service.feed(for: category) { [unowned self] response in
            switch response {
            case .success(let feed):
                self.showFeed?(feed)
            case .failure(let error):
                self.showError?(error)
            }
        }
    }
}
