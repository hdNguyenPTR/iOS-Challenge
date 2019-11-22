//
//  CollectionDataSource.swift
//  iOSIdWallDogChallenge
//
//  Created by joão lucas on 18/11/19.
//  Copyright © 2019 jv. All rights reserved.
//

import UIKit

protocol Identifiable: class { }

extension Identifiable where Self: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}

protocol ViewCellHandler: Identifiable {
    associatedtype Item
    var data: Item? { get set }
}

class CollectionDataSource<Cell: UICollectionViewCell, Item>: NSObject, UICollectionViewDataSource where Cell: ViewCellHandler, Item == Cell.Item {
    
    let items: [[Item]]
    
    init(items: [[Item]]) {
        self.items = items
        
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusable(fromIndexPath: indexPath) as Cell
        cell.data = items[indexPath.section][indexPath.row]
        return cell
    }
    
}

extension UICollectionView {
    
    func dequeueReusable<T: UICollectionViewCell>(fromIndexPath indexPath: IndexPath) -> T where T: Identifiable {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        
        return cell
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: Identifiable {
        
        let nib = UINib(nibName: T.identifier, bundle: T.bundle)
        register(nib, forCellWithReuseIdentifier: T.identifier)
        
    }
}
