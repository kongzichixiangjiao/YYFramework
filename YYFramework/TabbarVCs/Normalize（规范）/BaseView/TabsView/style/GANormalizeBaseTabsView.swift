//
//  GANormalizeBaseTabsView.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/10.
//  Copyright © 2019 houjianan. All rights reserved.
//  tabsViewd头部基类

import UIKit

protocol GANormalizeBaseTabsViewDelegate: class {
    func ga_normalizeBaseTabsViewClickedItem(title: String, index: Int)
}

class GANormalizeBaseTabsView: UIView {
    
    public var isShowLineView: Bool = true
    
    typealias ClickedItemHandler = (_ title: String, _ currentIndex: Int) -> ()
    public var _clickedItemHandler: ClickedItemHandler?
    
    weak var delegate: GANormalizeBaseTabsViewDelegate?

    // 必须实现
    public func moveTo(index: Int) {
        
    }
    
    // 下滑线动画
    public func scrollOffset(x: CGFloat, contentWidth: CGFloat) {
        
    }
    
}
