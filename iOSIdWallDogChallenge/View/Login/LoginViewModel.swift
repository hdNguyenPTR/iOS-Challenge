//
//  LoginViewModel.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import Foundation

class LoginViewModel {
    let loginService: LoginServiceProtocol
    
    var showError: ((ServiceError)->())?
    var goToFeed: ((User)->())?
    var invalidEmailError: (()->())?
    var isLoading: ((Bool)->())?
  
    init(service: LoginServiceProtocol) {
        self.loginService = service
    }
    
    func login(_ email: String?) {
        if let email = email, isValid(email) {
            isLoading?(true)
            loginService.signup(email) { [weak self] response in
                switch response {
                case .success(let user):
                    self?.saveToken(user.user.token)
                    self?.goToFeed?(user)
                case .failure(let error):
                    self?.showError?(error)
                }
                self?.isLoading?(false)
            }
        }else {
            isLoading?(false)
            invalidEmailError?()
        }
    }
    
   
    private func saveToken(_ token: String) {
        LocalStorage().save(data: token, key: "token")
    }
    
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
