//
//  GANormalizeTabbarView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

@objc protocol GANormalizeTabbarViewDelegate: NSObjectProtocol {
    func base_xibTabBarView(currentIndex c_index: Int, clickedIndex d_index: Int)
    @objc optional func base_xibTabBarViewClickedCurrentItem(index: Int)
}

class GANormalizeTabbarView: UIView {
    
    weak var mDelegate: YYBaseXibTabBarViewDelegate?
    
    var currentIndex: Int = 0
    
    @IBOutlet var buttons: [YYXibTabBarItem]!
    
    static func loadBaseXibTabBarView() -> GANormalizeTabbarView {
        return Bundle.main.loadNibNamed("GANormalizeTabbarView", owner: self, options: nil)?.last as! GANormalizeTabbarView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0..<buttons.count {
            let b = buttons[i]
            b.mDelegate = self
        }
    }
    
}

extension GANormalizeTabbarView: YYXibTabBarItemDelegate {
    func YYXibTabBarItemTap(title: String, tag: Int) -> Bool {
        if currentIndex == tag {
            mDelegate?.base_xibTabBarViewClickedCurrentItem?(index: currentIndex)
            return false
        }
        for i in 0..<buttons.count {
            buttons[i].isHighlight = false
        }
        
        mDelegate?.base_xibTabBarView(currentIndex: currentIndex, clickedIndex: tag)
        
        currentIndex = tag
        return true
    }
}
