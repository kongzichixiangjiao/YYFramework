//
//  YYReuseCollectionView.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/23.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  轮播 collectionview  无样式 可循环

import UIKit

@objc
protocol YYReuseCollectionViewDelegate: class {
    @objc optional func reuseCollectionViewGetImage(row: Int) -> UIImage
    @objc optional func reuseCollectionViewClicked(row: Int)
}

open class YYReuseCollectionView: UIView {
    
    weak var delegate: YYReuseCollectionViewDelegate?

    public var pageControl_currentColor: UIColor!
    public var pageControl_defaultColor: UIColor!
    public var currentPage: Int = 0
    public var allPage: Int = 0
    public var isAutoScroll: Bool = true
    public var timeInterval: Double = 3.0
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        v.backgroundColor = UIColor.clear
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.delegate = self
        v.dataSource = self
        v.isPagingEnabled = true
        if #available(iOS 11.0, *) {
            v.contentInsetAdjustmentBehavior = .never
        }
        v.register(UINib(nibName: YYReuseCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYReuseCollectionCell.identifier)
        return v
    }()
    
    lazy var pageControl: GAPageControl = {
        let v = GAPageControl(frame: CGRect(x: 0, y: self.bounds.size.height - 10, width: self.bounds.size.width, height: 4), currentImageColor: pageControl_currentColor, defaultImageColor: pageControl_defaultColor, maxCount: self.allPage, currentPage: currentPage)
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, allPage: Int, currentPage: Int? = 0, pageControl_defaultColor: UIColor? = UIColor.black, pageControl_currentColor: UIColor? = UIColor.orange) {
        self.init(frame: frame)
        
        self.allPage = allPage
        self.currentPage = currentPage!
    
        self.pageControl_currentColor = pageControl_currentColor!
        self.pageControl_defaultColor = pageControl_defaultColor!
        
        pageControl.maxCount = allPage
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        
        collectionView.contentOffset = CGPoint(x: collectionView.bounds.width * CGFloat(self.allPage) * 50, y: 0)

        coutDown.addTimer {
            [weak self] count, b in
            DispatchQueue.main.async {
                if let weakSelf = self {
                    weakSelf.pageControl.currentPage = Int(weakSelf.collectionView.contentOffset.x / weakSelf.bounds.width) % allPage
                    weakSelf.collectionView.setContentOffset(CGPoint(x: weakSelf.collectionView.contentOffset.x + weakSelf.collectionView.bounds.width, y: 0), animated: true)
                }
            }
        }
    }
    
    lazy var coutDown: YYReuseTimer = {
        let c = YYReuseTimer(interval: 2, isRepeat: true)
        return c
    }()
    
    deinit {
        coutDown.cancleTimer()
    }
}

extension YYReuseCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYReuseCollectionCell.identifier, for: indexPath) as! YYReuseCollectionCell
        if let image = delegate?.reuseCollectionViewGetImage?(row: indexPath.row) {
            cell.image = image
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allPage
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1000
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("\(Date())scrollViewDidEndDecelerating \(Int(collectionView.contentOffset.x / self.bounds.width) % allPage)")
        pageControl.currentPage = Int(collectionView.contentOffset.x / self.bounds.width) % allPage
        coutDown.goOnTimer()
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        coutDown.stopTimer()
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        coutDown.stopTimer()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.reuseCollectionViewClicked?(row: indexPath.row)
    }
}

            
