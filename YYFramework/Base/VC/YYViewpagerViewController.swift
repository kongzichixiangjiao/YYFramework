//
//  YYViewpagerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2018/8/12.
//  Copyright © 2018年 houjianan. All rights reserved.
//  新特性界面 轮播图

import UIKit

class YYViewpagerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYViewpagerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYViewpagerViewCell.identifier, for: indexPath) as! YYViewpagerViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

class YYViewpagerViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        
    }
}

