//
//  ZHCalendarCollectionViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/29.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class ZHCalendarCollectionViewController: YYBaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    func initViews() {
        collectionView.collectionViewLayout = ZHCalendarCollectionViewFlowLayout()
        collectionView.yy_register(nibName: ZHCalendarCollectionViewCell.identifier)
        collectionView.alwaysBounceVertical = true
//        collectionView.alwaysBounceHorizontal = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ZHCalendarCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHCalendarCollectionViewCell.identifier, for: indexPath)
        
        if indexPath.row == 0 {
            cell.contentView.backgroundColor = .yellow
        } else if indexPath.row == 1 {
            cell.contentView.backgroundColor = .red
        } else if indexPath.row == 2 {
            cell.contentView.backgroundColor = .blue
        } else {
            cell.contentView.backgroundColor = .orange
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: kScreenWidth, height: 200)
        } else if indexPath.row == 1 {
            return CGSize(width: kScreenWidth, height: 300)
        } else if indexPath.row == 2 {
            return CGSize(width: kScreenWidth, height: 400)
        } else {
            return CGSize(width: kScreenWidth, height: 400)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

class ZHCalendarCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var cellCount: Int = 0
    var center: CGPoint = CGPoint.zero
    var radius: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        cellCount = (collectionView?.numberOfItems(inSection: 0))!
        
        let size = self.collectionView!.frame.size
        center = CGPoint(x: (size.width) / 2.0, y: size.height / 2.0)
        radius = min((size.width), size.height) / 2.5
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let h: CGFloat = (collectionView?.contentOffset.y)!
        if indexPath.row == 0 {
            attributes.size = CGSize(width: kScreenWidth, height: 200)
            attributes.center = CGPoint.zero
        } else if indexPath.row == 1 {
            
            attributes.size = CGSize(width: kScreenWidth, height: h)
            attributes.center = CGPoint(x: 0, y: 200)
        } else if indexPath.row == 2 {
            attributes.size = CGSize(width: kScreenWidth, height: 400)
            attributes.center = CGPoint(x: 0, y: 200 + h)
        } else {
            attributes.size = CGSize(width: kScreenWidth, height: 400)
            attributes.center = CGPoint(x: 0, y: 200 + h + 400)
        }
        
        return attributes;
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for i in 0..<cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            attributes.append(self.layoutAttributesForItem(at: indexPath)!)
        }
        return attributes
    }
    
    override func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutAttributesForItem(at: elementIndexPath)
    }
    
    override func finalLayoutAttributesForDisappearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: elementIndexPath)
        attributes.transform = CGAffineTransform.init(scaleX: 1, y: collectionView!.contentOffset.y / 200.0)
        return attributes
    }
    
}

