//
//  Button+Statistical.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/10/10.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

// 统计按钮事件使用 方法交换
/*
 // appdelegate
    UIButton.statistical_share
 */

// 防止重复点击
extension UIButton {
    
    static let ga_share: UIButton = UIButton(statistical_swizzle: true)
    
    convenience init(statistical_swizzle: Bool) {
        self.init()
//        let selector = #selector(UIButton.sendAction(_:to:for:))
//        let selector1 = #selector(UIButton.statistical_sendAction(_:to:for:))

        let selector = #selector(UIButton.touchesEnded(_:with:))
        let selector1 = #selector(UIButton.statistical_touchesEnded(_:with:))
        let method = class_getInstanceMethod(UIButton.classForCoder(), selector)
        let method1 = class_getInstanceMethod(UIButton.classForCoder(), selector1)
        
        let isAddMethod = class_addMethod(UIButton.classForCoder(), selector1, method_getImplementation(method1!), method_getTypeEncoding(method1!))
        
        if isAddMethod {
            class_replaceMethod(UIButton.classForCoder(), selector1, method_getImplementation(method!), method_getTypeEncoding(method!))
        } else {
            method_exchangeImplementations(method!, method1!)
        }
        
    }
    
    @objc  func statistical_touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.statistical_touchesEnded(touches, with: event)
        #if DEBUG
        print("statistical_touchesEnded", self.titleLabel?.text ?? "----")
        #endif
        /* 这里做按钮事件统计 */
    }
    

}
