//
//  GABannerView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GABannerView: GABannerBaseView, GABanner {
    public weak var dataSource: GABannerDataSource? {
        didSet {
            reloadView()
        }
    }
    
    public weak var delegate: GABannerDelegate?
    
    var identifier: String? = "GABannerBaseView"
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupBase()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _setupBase()
    }
    
    func reloadView() {
        
        // Stop Animation
        _stop()
        
        // refresh
        _refreshDataSource()
        _refreshDelegate()
        _refreshData()
        
        // Start Animation
        _start()
    }
}

// MARK: 私有方法
extension GABannerView {
    
    private func _setupBase() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // 检测IndexPath错误
    private func _indexPathErrorDetection() {
        let indexPaths = collectionView.indexPathsForVisibleItems
        var attriArr = [UICollectionViewLayoutAttributes?]()
        for indexPath in indexPaths {
            let attri = collectionView.layoutAttributesForItem(at: indexPath)
            attriArr.append(attri)
        }
        let centerX: CGFloat = collectionView.contentOffset.x + collectionView.frame.width * 0.5
        var minSpace = CGFloat(MAXFLOAT)
        var shouldSet = true
        if layout.model?.layoutType != nil && indexPaths.count <= 2 {
            shouldSet = false
        }
        for atr in attriArr {
            if let obj = atr, shouldSet {
                obj.zIndex = 0;
                if(abs(minSpace) > abs(obj.center.x - centerX)) {
                    minSpace = obj.center.x - centerX;
                    currentIndexPath = obj.indexPath;
                }
            }
        }
        
        scrollViewWillBeginDecelerating(collectionView)
    }
    
    // 初始化collectionView数据
    private func _refreshDataSource() {
        if let _ = dataSource?.gaBanner(numberOfItems: self),
            let tempDataSource = dataSource {
            
            // Register cell
            if let register = dataSource?.gaBanner(self) {
                if let nib = register.nib {
                    collectionView.register(
                        nib,
                        forCellWithReuseIdentifier: register.reuseIdentifier)
                } else {
                    collectionView.register(
                        register.type,
                        forCellWithReuseIdentifier: register.reuseIdentifier)
                    if register.type == nil {
                        
                    }
                }
                
                cellRegister = register
            }
            
            // numberOfItems
            pageCount = tempDataSource.gaBanner(numberOfItems: self)
            
            // model
            model = dataSource?.gaBanner(self, model: model) ?? model
            layout.isPagingEnabled = model.isPagingEnabled
            collectionView.contentInset = model.contentInset
            
            // layoutmodel
            layout.model = tempDataSource.gaBanner(self, layoutModel: layout.model!)
            
            // PageControl
            //               refreshPageControl()
        }
    }
    
    private func _refreshDelegate() {
        if let tempDelegate = delegate {
            tempDelegate.gaBanner(self, coverView: coverView)
        }
    }
    
    private func _refreshData() {
        model.currentRollingDirection = .right
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.bounces = model.isBounces
        collectionView.reloadData()
        if pageCount == 1,
            model.cycleWay == .forward {
            model.cycleWay = .skipEnd
        }
        placeholderImgView.isHidden = pageCount > 0
        
        _reinitializeIndexPath()
    }
    
    private func _reinitializeIndexPath() {
        if pageCount > 0,
            model.cycleWay == .forward {
            currentIndexPath = IndexPath(row: (kMultiplier * pageCount / 2), section: 0)
        } else {
            currentIndexPath = IndexPath(row: 0, section: 0)
        }
        if pageCount > 0 {
            scrollToIndexPath(currentIndexPath, animated: false)
        }
    }
}

// MARK: UIScrollViewDelegate
extension GABannerView {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _pause()
    }
    
    // 获取currentIndexPath
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        _pause()
        
        if model.cycleWay != .forward {
            if velocity.x >= 0 ,
                currentIndexPath.row == pageCount - 1 { return }
            if velocity.x <= 0 ,
                currentIndexPath.row == 0 { return }
        }
        
        if velocity.x > 0 {
            currentIndexPath = currentIndexPath + 1
        } else if velocity.x < 0 {
            currentIndexPath = currentIndexPath - 1
        } else {
            _indexPathErrorDetection()
        }
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollToIndexPath(currentIndexPath, animated: true)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        _start()
        setScrollCurrentIndex()
    }
}

extension GABannerView {
    
    override func setScrollCurrentIndex() {
        let point = CGPoint(x: collectionView.contentOffset.x + collectionView.frame.width * 0.5,  y: collectionView.contentOffset.y + collectionView.frame.height * 0.5)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            let currentPage = indexOfIndexPath(indexPath)
            //            pageControl?.currentPage = currentPage
            delegate?.gaBanner(self, center: currentPage)
        }
    }
    
    @objc internal override func autoScroll() {
        guard ga_isShowingOnWindow() != false, pageCount > 1 else {
            return
        }
        
        switch model.cycleWay {
        case .forward:
            currentIndexPath = currentIndexPath + 1
            scrollToIndexPath(currentIndexPath, animated: true)
        case .skipEnd:
            if currentIndexPath.row == pageCount - 1 {
                currentIndexPath = IndexPath(row: 0, section: 0)
                scrollToIndexPath(currentIndexPath, animated: false)
                scrollViewDidEndScrollingAnimation(collectionView)
                if let transitionType = model.edgeTransitionType?.rawValue {
                    let transition = CATransition()
                    transition.duration = CFTimeInterval(0.3)
                    transition.subtype = model.edgeTransitionSubtype
                    transition.type = CATransitionType(rawValue: transitionType)
                    transition.isRemovedOnCompletion = true
                    collectionView.layer.add(transition, forKey: nil)
                }
            } else {
                currentIndexPath = currentIndexPath + 1
                scrollToIndexPath(currentIndexPath, animated: true)
            }
        case .rollingBack:
            switch model.currentRollingDirection {
            case .right:
                if currentIndexPath.row == pageCount - 1 {
                    currentIndexPath = currentIndexPath - 1
                    model.currentRollingDirection = .left
                } else {
                    currentIndexPath = currentIndexPath + 1
                }
                scrollToIndexPath(currentIndexPath, animated: true)
            case .left:
                if currentIndexPath.row == 0 {
                    currentIndexPath = currentIndexPath + 1
                    model.currentRollingDirection = .right
                } else {
                    currentIndexPath = currentIndexPath - 1
                }
                scrollToIndexPath(currentIndexPath, animated: true)
            }
        }
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension GABannerView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)  -> Int {
        return model.cycleWay == .forward ? kMultiplier * pageCount : pageCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRegister.reuseIdentifier, for: indexPath)
        return dataSource?.gaBanner(self, cellForItemAt: indexPath.row, cell: cell) ?? cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.gaBanner(self, didSelectItemAt: indexPath)
        _indexPathErrorDetection()
    }
    
    func indexOfIndexPath(_ indexPath : IndexPath) -> Int {
        return Int(indexPath.item % pageCount)
    }
}
