//
//  FeedViewModel.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 22/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation

class FeedViewModel {
    private let service: FeedServiceProtocol
    
    var showFeed: ((Feed)->())?
    var showError: ((ServiceError)->())?
    var isLoading: ((Bool)->())?
    var updateBreed: ((String)->())?
    var backToLogin: ((String, String)->())?
    
    init(service: FeedServiceProtocol) {
        self.service = service
    }
    
    func getFeed(for category: String){
        isLoading?(true)
        service.feed(for: category) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let feed):
                self.updateBreed?(feed.category)
                self.showFeed?(feed)
            case .failure(let error):
                if error == ServiceError.unauthorized {
                    self.logout(title: "Não autorizado",
                                message: "Essa operação não foi autorizada.")
                }
                self.showError?(error)
            }
            self.isLoading?(false)
        }
    }
    
    func logout(title: String, message: String) {
        LocalStorage().remove(for: "token")
        backToLogin?(title, message)
    }
}
