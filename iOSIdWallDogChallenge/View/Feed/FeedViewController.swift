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
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.register(DogCollectionViewCell.self)
        }
    }
    private var collectionViewDataSource: CollectionDataSource<DogCollectionViewCell, String>?
    
    var viewModel: FeedViewModel!
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        breedButtons.forEach{ $0.layer.cornerRadius = $0.frame.width/2}
        
        viewModel.getFeed(for: "husky")
        viewModel.showFeed = { dogURL in
            self.configureCollection(items: dogURL)
        }
        
        viewModel.isLoading = { [unowned self] loading in
            if loading {
                self.showSpinner(onView: self.view)
            }else {
                self.removeSpinner()
            }
        }
    }
    
    private func configureCollection(items: [String]) {
        collectionViewDataSource = CollectionDataSource(items: [items])
        collectionView.dataSource = collectionViewDataSource
        collectionView.reloadData()
    }
    
    @IBAction func didTapHusky(_ sender: Any) {
   
    }
}
