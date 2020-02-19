//
//  GANormalizeBaseCollectionViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/12.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeBaseCollectionViewController: GANormalizeBaseViewController {
    
    public var dataSource: [Any] = []  // 数据源
    
    lazy var collectionView: UICollectionView = {
        let flow = GABaseCollectionFlowLayout()
        let v = UICollectionView(frame: self.view.bounds, collectionViewLayout: flow)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        if #available(iOS 11.0, *) {
            v.contentInsetAdjustmentBehavior = .never
        }
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViews() {
        self.view.addSubview(collectionView)
        
        super.initViews()

        initCollectionViews()
    }
    
    public func initCollectionViews() {
        let y = base_isNavigationViewAnimation ? 0 : (base_isShowNavigationView ? navigationView.frame.size.height : 0)
        let h = self.view.bounds.height - y - (base_isShowTabbarView ? kTabBarHeight : 0)
        collectionView.frame = CGRect(x: 0, y: y, width: self.view.bounds.width, height: h)
        
        if base_isNavigationViewAnimation {
            let top = collectionView.contentInset.top
            collectionView.contentInset = UIEdgeInsets(top: navigationView.frame.maxY + top, left: 0, bottom: 0, right: 0)
        }
    }
}

extension GANormalizeBaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GANormalizeBaseCollectionViewController: GANormalizeBaseNavigationAnimationProtocol {
    func base_navigationViewAnimation(y: CGFloat) {
        let tempY = y + collectionView.contentInset.top
        if base_isShowNavigationView && base_isNavigationViewAnimation {
            /*
             *  具体动画按需求实现
             */
            if tempY < 0 {
                navigationView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kStatusBarHeight + kNavigationHeight)
                return
            }
            if tempY > kStatusBarHeight + kNavigationHeight {
                navigationView.frame = CGRect(x: 0, y: -kStatusBarHeight - kNavigationHeight, width: kScreenWidth, height: kStatusBarHeight + kNavigationHeight)
                return
            }
            self.navigationView.frame = CGRect(x: 0, y: -tempY, width: kScreenWidth, height: kStatusBarHeight + kNavigationHeight)
        }
    }
}

class GABaseCollectionFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }
}
