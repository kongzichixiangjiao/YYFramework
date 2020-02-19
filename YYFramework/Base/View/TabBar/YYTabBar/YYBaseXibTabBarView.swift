//
//  YYBaseXibTabBarView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/29.
//  Copyright © 2018年 houjianan. All rights reserved.
//  自定义TabBar
//  使用注意：1、连线buttons
//          2、设置tag

import UIKit

@objc protocol YYBaseXibTabBarViewDelegate: NSObjectProtocol {
    func base_xibTabBarView(currentIndex c_index: Int, clickedIndex d_index: Int)
    @objc optional func base_xibTabBarViewClickedCurrentItem(index: Int)
}

class YYBaseXibTabBarView: UITabBar {
    
    weak var mDelegate: YYBaseXibTabBarViewDelegate?
    
    var currentIndex: Int = 0
    
    var _specialView: UIView?
    
    @IBOutlet var buttons: [YYXibTabBarItem]!
    
    static func loadBaseXibTabBarView() -> YYBaseXibTabBarView {
        return Bundle.main.loadNibNamed("YYBaseXibTabBarView", owner: self, options: nil)?.last as! YYBaseXibTabBarView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0..<buttons.count {
            let b = buttons[i]
            b.mDelegate = self
        }
    }
    
    func updateView(title: String, index: Int) {
        let button = buttons[index]
        button.mLabel.text = title
    }
    
    func b_tabBarVeiwReload() {
        for i in 0..<buttons.count {
            buttons[i].isHighlight = false
        }
        
        buttons[currentIndex].isHighlight = true
    }
    
    func b_tabBarVeiwClicked(tag: Int) {
        if currentIndex == tag {
            mDelegate?.base_xibTabBarViewClickedCurrentItem?(index: currentIndex)
        }
        
        for i in 0..<buttons.count {
            buttons[i].isHighlight = false
        }
        
        buttons[tag].isHighlight = true
        
        mDelegate?.base_xibTabBarView(currentIndex: currentIndex, clickedIndex: tag)
        
        currentIndex = tag
    }
    
    // 特殊的按钮：xib文件正常配置，需要替换特殊的view调此方法替换；也可以再定义新的xibtabbarview
    // index 位置
    func b_tabBarSpecialView(v: UIView, index: Int) {
        _specialView = v
        
        let indexView = buttons[index]
        indexView.addSubview(v)
    }
    
    // MARK: - 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        // 判断是否为根控制器
        if self.isHidden {
            // tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
        }else{
            // 特殊按钮不存在 系统处理
            guard let v = _specialView else {
                return super.hitTest(point, with: event)
            }
            // 将单钱触摸点转换到按钮上生成新的点
            let onV = self.convert(point, to: v)
            // 判断新的点是否在按钮上
            if v.point(inside: onV, with: event){
                return v
            }else{
                // 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
    
}

extension YYBaseXibTabBarView: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(tabBar, item)
    }
}

extension YYBaseXibTabBarView: YYXibTabBarItemDelegate {
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
