//
//  GANormalizeTabsMainView.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/10.
//  Copyright © 2019 houjianan. All rights reserved.
//  装在头部和内容的view

import UIKit

@objc protocol GANormalizeTabsMainViewDelegate: class {
    @objc optional func ga_normalizeTabsMainViewCurrentVC(index: Int, vc: UIViewController)
    @objc optional func ga_normalizeTabsMainViewDidScroll(didIndex: Int, index: Int)
}

class GANormalizeTabsMainView: UIView {
    
    weak var delegate: GANormalizeTabsMainViewDelegate?

    private var vcs = [UIViewController]()
    private var headerView: GANormalizeBaseTabsView!
    private var didIndex: Int = 0
    
    lazy var contentView: GANormalizeTabsContentView = {
        let v = GANormalizeTabsContentView(frame: CGRect(x: 0, y: headerView.bounds.height, width: self.bounds.width, height: self.bounds.height - self.headerView.bounds.height), vcs: self.vcs)
        v.delegate = self
        return v
    }()
    
    public func initVCS(vcs: [UIViewController], headerView: GANormalizeBaseTabsView) {
        self.vcs = vcs
        
        self.headerView = headerView
        headerView.delegate = self
        headerView.center = CGPoint(x: headerView.bounds.width / 2, y: headerView.bounds.height / 2)
        self.addSubview(headerView)
        
        self.addSubview(contentView)
    }
    
    public func moveToVC(index: Int) {
        contentView.moveTo(index: index)
    }

}

extension GANormalizeTabsMainView: GANormalizeTabsContentViewDelegate {
    func ga_normalizeTabsContentViewDidScroll(x: CGFloat, contentWidth: CGFloat) {
        headerView.scrollOffset(x: x, contentWidth: contentWidth)
    }
    
    func ga_normalizeTabsContentViewMoveTo(index: Int, vc: UIViewController) {
        delegate?.ga_normalizeTabsMainViewCurrentVC?(index: index, vc: vc)
        
        // 继承GANormalizeBaseTabsView类实现moveTo方法
        headerView.moveTo(index: index)
        
        delegate?.ga_normalizeTabsMainViewDidScroll?(didIndex: didIndex, index: index)
        didIndex = index
    }
    
}

extension GANormalizeTabsMainView: GANormalizeBaseTabsViewDelegate {
    func ga_normalizeBaseTabsViewClickedItem(title: String, index: Int) {
        delegate?.ga_normalizeTabsMainViewCurrentVC?(index: index, vc: self.vcs[index])
        
        // 继承GANormalizeBaseTabsView类实现moveTo方法
        contentView.moveTo(index: index, animated: false)
        
        delegate?.ga_normalizeTabsMainViewDidScroll?(didIndex: didIndex, index: index)
        didIndex = index
    }
}
