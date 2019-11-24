//
//  FeedViewController.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet var breedButtons: [UIButton]!{
        didSet {
            DispatchQueue.main.async {
                self.breedButtons.forEach{ $0.layer.cornerRadius = $0.frame.width/2
                    $0.layer.borderColor = UIColor.white.cgColor
                    $0.layer.borderWidth = 1.0
                    
                }
            }
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.register(DogCollectionViewCell.self)
            collectionView.delegate = self
        }
    }
    @IBOutlet weak var breedLabel: UILabel!
    
    private var collectionViewDataSource: CollectionDataSource<DogCollectionViewCell,
                                                                String>?
    
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
        
        bind()
    }
    
    private func bind() {
        viewModel.getFeed(for: Dog.husky.rawValue)
        
        viewModel.showFeed = { feed in
            self.configureCollection(items: feed.list)
        }
        
        viewModel.isLoading = { [unowned self] loading in
            if loading {
                self.showSpinner(onView: self.view)
            }else {
                self.removeSpinner()
            }
        }
        
        viewModel.updateBreed = { [unowned self] breed in
            self.updateBreedLabel(breed)
        }
        
        viewModel.backToLogin = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configureCollection(items: [String]) {
        collectionViewDataSource = CollectionDataSource(items: [items])
        collectionView.dataSource = collectionViewDataSource
        collectionView.reloadData()
    }
    
    private func updateBreedLabel(_ text: String) {
        breedLabel.text = text.uppercased()
    }
    
    @IBAction func didTapLabrator(_ sender: Any) {
        viewModel.getFeed(for: Dog.labrador.rawValue)
    }
    @IBAction func didTapPug(_ sender: Any) {
        viewModel.getFeed(for: Dog.pug.rawValue)
    }
    @IBAction func didTapHound(_ sender: Any) {
        viewModel.getFeed(for: Dog.hound.rawValue)
    }
    
    @IBAction func didTapHusky(_ sender: Any) {
        viewModel.getFeed(for: Dog.husky.rawValue)
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
}
