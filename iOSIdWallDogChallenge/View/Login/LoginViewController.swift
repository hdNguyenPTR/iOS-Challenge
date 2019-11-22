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
    
    var viewModel: LoginViewModel!
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel.goToFeed = { [unowned self] user in
            self.navigationController?.pushViewController(FeedViewController(),
                                                          animated: true)
        }
        
        viewModel.invalidEmailError = { [unowned self] in
            self.showAlert(alertText: "Email inválido",
                           alertMessage: "Digite um email válido")
        }
        
        viewModel.showError = { [unowned self] serviceError in
            self.showAlert(alertText: "Ocorreu algum erro, tente novamente",
                           alertMessage: serviceError.localizedDescription)
        }
        
        viewModel.isLoading = { [unowned self] isLoading in
            if isLoading {
                self.showSpinner(onView: self.view)
            }else {
                self.removeSpinner()
            }
        }
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        viewModel.login(loginTextField.text)
    }
}
