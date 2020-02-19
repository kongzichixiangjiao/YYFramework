//
//  GANormalizeTestCollectionViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/12.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeTestCollectionViewController: GANormalizeBaseCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func initViews() {
        base_isNavigationViewAnimation = true
        collectionView.yy_register(nibName: GANormalizeTestCollectionViewCell.identifier)
        collectionView.yy_registerSection(nibName: GANormalizeTestCollectionReusableView.identifier)
        
        let layout = GABaseCollectionFlowLayout()
        layout.itemSize = CGSize(width: self.view.width, height: 24)
        collectionView.collectionViewLayout = layout
        
        super.initViews()
    }
    
}

extension GANormalizeTestCollectionViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        base_navigationViewAnimation(y: scrollView.contentOffset.y)
    }
}

extension GANormalizeTestCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GANormalizeTestCollectionReusableView.identifier, for: indexPath)
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 66)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GANormalizeTestCollectionViewCell.identifier, for: indexPath) as! GANormalizeTestCollectionViewCell
        cell.l.text = "GANormalizeTestCollectionViewCell"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.width, height: 60)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

