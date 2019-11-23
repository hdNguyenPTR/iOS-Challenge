//
//  DogCollectionViewCell.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import UIKit
import Kingfisher

class DogCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dogImageView: UIImageView!

    private var viewRepresentable: String? {
        didSet {
            guard let absoluteUrl = viewRepresentable, let url = URL(string: absoluteUrl) else { return }
                dogImageView.kf.indicatorType = .activity
                dogImageView.kf.setImage(with: url)
            }
        }
}

extension DogCollectionViewCell: ViewCellHandler {

    typealias Item = String

    var data: Item? {
        get {
            return nil
        }
        set {
            viewRepresentable = newValue
        }
    }
}
