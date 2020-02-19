//
//  GAEstimatedCollectionViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/26.
//  Copyright © 2018年 houjianan. All rights reserved.
//  适应文案宽高

import UIKit

class GAEstimatedCollectionViewController: YYBaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: kScreenWidth / 2 - 20, height: 400)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: CGRect(x: 0, y: kNavigationViewHeight, width: kScreenWidth, height: kScreenHeight - kNavigationViewHeight), collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        v.backgroundColor = UIColor.lightGray
        return v
    }()
    
    var data: [String] = ["YYBaseCollectionViewControllerYYBaseCollectionViewControllerYYBaseCollectionViewController", "2233", "YYBaseCollectionViewControllerYYBaseCollectionViewController", "YYBaseCollectionViewControllerYYBaseCollectionViewController", "YYBaseCollectionViewControllerYYBaseCollectionViewControllerYYBaseCollectionViewController", "2233", "YYBaseCollectionViewControllerYYBaseCollectionViewController", "YYBaseCollectionViewControllerYYBaseCollectionViewController", "YYBaseCollectionViewControllerYYBaseCollectionViewControllerYYBaseCollectionViewController", "2233", "YYBaseCollectionViewControllerYYBaseCollectionViewController", "YYBaseCollectionViewControllerYYBaseCollectionViewController", "YYBaseCollectionViewControllerYYBaseCollectionViewControllerYYBaseCollectionViewController", "2233", "YYBaseCollectionViewControllerYYBaseCollectionViewController", "YYBaseCollectionViewControllerYYBaseCollectionViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "自适应", isShow: true)
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(kNavigationViewHeight)
        }
        collectionView.yy_register(nibName: GAEstimatedCell.identifier)
    }

}

extension GAEstimatedCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GAEstimatedCell.identifier, for: indexPath) as! GAEstimatedCell
        cell.l.text = data[indexPath.row]
        cell.l1.text = data[indexPath.row]
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}
