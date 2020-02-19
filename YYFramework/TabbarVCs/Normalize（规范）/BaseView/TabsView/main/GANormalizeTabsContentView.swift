//
//  GANormalizeTabsMainView.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/10.
//  Copyright © 2019 houjianan. All rights reserved.
//  tabsview承载内容的类

import UIKit

protocol GANormalizeTabsContentViewDelegate: class {
    func ga_normalizeTabsContentViewMoveTo(index: Int, vc: UIViewController)
    func ga_normalizeTabsContentViewDidScroll(x: CGFloat, contentWidth: CGFloat)
}

class GANormalizeTabsContentView: UIView {
    
    weak var delegate: GANormalizeTabsContentViewDelegate?
    
    public var currentVC: UIViewController! {
        get {
            let row = (self.collectionView.visibleCells.first! as! GANormalizeTabsMainCell).row
            return self.vcs[row]
        }
    }
    
    public func moveTo(index: Int, animated: Bool = true) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: animated)
    }
    
    private var vcs = [UIViewController]()
    private var views = [UIView]()
    
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: flow)
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.isPagingEnabled = true
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    convenience init(frame: CGRect, vcs: [UIViewController]) {
        self.init(frame: frame)
        
        self.vcs = vcs
        for vc in vcs {
            let rect = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
            vc.view.bounds = rect
            views.append(vc.view)
        }
        
        _initViews()
    }
    
    private func _initViews() {
        collectionView.register(UINib(nibName: "GANormalizeTabsMainCell", bundle: nil), forCellWithReuseIdentifier: "GANormalizeTabsMainCell")
        self.addSubview(collectionView)
    }
    
}

extension GANormalizeTabsContentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GANormalizeTabsMainCell", for: indexPath) as! GANormalizeTabsMainCell
        cell.row = indexPath.row
        cell.mView = self.views[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return views[indexPath.row].size
    }
}

extension GANormalizeTabsContentView {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let row = (self.collectionView.visibleCells.first! as! GANormalizeTabsMainCell).row
        delegate?.ga_normalizeTabsContentViewMoveTo(index: row, vc: vcs[row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.ga_normalizeTabsContentViewDidScroll(x: scrollView.contentOffset.x, contentWidth: self.bounds.width)
    }
}
