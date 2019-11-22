//
//  FeedViewController.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet var breedButtons: [UIButton]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        breedButtons.forEach{ $0.layer.cornerRadius = $0.frame.width/2}
    }
}
