//
//  LoginViewController.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!{
        didSet {
            loginButton.layer.cornerRadius = 25.0
        }
    }
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    @IBAction func didTapLogin(_ sender: Any) {
    
    }
}
