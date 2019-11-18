//
//  LoginViewModel.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation

class LoginViewModel {
    let loginService: LoginService
    
    var showError: ((ServiceError)->())?
    var goToFeed: ((User)->())?
  
    init(service: LoginService) {
        self.loginService = service
    }
    
    func login(_ email: String) {
        loginService.signup(email) { [weak self] response in
            switch response {
            case .success(let user):
                self?.goToFeed?(user)
            case .failure(let error):
                self?.showError?(error)
            }
        }
    }
}
