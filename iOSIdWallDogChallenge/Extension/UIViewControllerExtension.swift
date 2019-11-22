//
//  File.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 21/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import UIKit

var vSpinner: UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension UIViewController {

    func showAlert(alertText: String, alertMessage : String) {
        let alert = UIAlertController(title: alertText,
                                      message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      
        self.present(alert, animated: true, completion: nil)
    }
}
