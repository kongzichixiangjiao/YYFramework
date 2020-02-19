//
//  GAPreviewImage.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/10.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

open class GAPreviewImage: UIView {
    
    public var images: [UIImage] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        v.isPagingEnabled = true
        v.register(UINib(nibName: YYReuseCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYReuseCollectionCell.identifier)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, images: [UIImage]) {
        self.init(frame: frame)
    }
}

extension GAPreviewImage: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYReuseCollectionCell.identifier, for: indexPath) as! YYReuseCollectionCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9999
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: self.bounds.height)
    }
    
}
