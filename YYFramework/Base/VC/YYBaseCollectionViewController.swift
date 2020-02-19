//
//  YYBaseCollectionViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/29.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYBaseCollectionViewController: YYBaseViewController {

    var dataSource: [Any] = []
    
    lazy var collectionView: UICollectionView = {
        let flow = YYBaseCollectionFlowLayout()
        let v = UICollectionView(frame: self.view.bounds, collectionViewLayout: flow)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_initCollectionViews()
    }
    
    public func base_initCollectionViews() {
        self.view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYBaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

class YYBaseCollectionFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
    }
}
