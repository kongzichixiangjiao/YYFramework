//
//  GATagCollectionViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/28.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class GATagCollectionViewController: YYBaseCollectionViewController {

    lazy var layout: GATagFlowLayout = {
        let l = GATagFlowLayout()
        l.flowEdgeInset = UIEdgeInsets(top: 20, left: 10, bottom: 15, right: 10)
        l.columSpace = 10
        l.rowSpaces = [10]
        l.delegate = self
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ["123123", "123123", "2312123312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231", "12", "1231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123", "12312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312300", "123123123", "1231123123123123123121231231231231231212331231231212323123", "123123123", "123123123", "123123123", "123123", "2312123312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231", "12", "1231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123", "12312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312312312312312123123123123123121231231231231231212312300", "123123123", "1231123123123123123121231231231231231212331231231212323123", "123123123", "123123123", "123123123"]
    }

    override func base_initCollectionViews() {
        super.base_initCollectionViews()
        collectionView.collectionViewLayout = layout
        
        collectionView.yy_register(nibName: GATagCollectionViewCell.identifier)
    }
    
    func stringSize(s: String) -> CGSize {
        if s.count == 0 {
            return CGSize.zero
        }
        let font = UIFont.systemFont(ofSize: 14)
        
        let width = UIScreen.main.bounds.size.width - self.layout.flowEdgeInset.left - self.layout.flowEdgeInset.right
        let contentSize = (s as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size
        // 30是label距离左右的间距和 // 20距离上下和 
        let size = CGSize(width: min(contentSize.width + 30 + 2, width + 2), height: max(28, contentSize.height + 20))

        return size
    }
}

extension GATagCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GATagCollectionViewCell.identifier, for: indexPath) as! GATagCollectionViewCell
        cell.tagLabel.text = dataSource[indexPath.row] as? String
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GATagCollectionViewController: GATagFlowLayoutDelegate {
    func tag(layout: GATagFlowLayout, indexPath: IndexPath) -> CGSize {
        return stringSize(s: dataSource[indexPath.row] as! String)
    }
}
