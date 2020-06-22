//
//  YYBannerView.swift
//  YYFramework
//
//  Created by houjianan on 2020/5/20.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

import UIKit

protocol YYBannerDelegate: class {
    func bannerCollectionView(indexPath: IndexPath)  -> UICollectionViewCell
}

class YYBannerView: UIView {
    
    weak var delegate: YYBannerDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = CardsCollectionViewLayout()
        let collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.autoresizingMask = []
        
        _initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initViews()
    }
    
    private func _initViews() {
        
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.yy_register(nibName: GABannerBaseCell.identifier)
    }
    
    public func setupFlowLayout(layout: UICollectionViewFlowLayout) {
        collectionView.collectionViewLayout = layout
    }
    
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension YYBannerView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)  -> Int {
        return 10000
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
        guard let d = delegate else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GABannerBaseCell.identifier, for: indexPath) as! GABannerBaseCell
            cell.imgView.image = UIImage(named: indexPath.row % 2 == 0 ? "2.jpg" : "1.jpg")
            return cell
        }
        return d.bannerCollectionView(indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

