//
//  UIButton+Extension.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/27.
//  Copyright © 2018年 houjianan. All rights reserved.
//  

import UIKit

protocol UIButtonExtensionProtocol {
    var ga_numbers: Int {set get}
}

// 按钮字体自动换行
extension UIButton: UIButtonExtensionProtocol {
    @IBInspectable var ga_numbers: Int {
        set {
            self.titleLabel?.numberOfLines = newValue
        }
        get {
            return self.titleLabel?.numberOfLines ?? 0
        }
    }
}

// 添加圆角 // 继承自定义button，使用xib，在plus上会出现问题
extension UIButton {
    func yy_button_circularBead(byRoundingCorners: UIRectCorner, cornerRadii: CGSize) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: byRoundingCorners, cornerRadii: cornerRadii)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        let maskAdsLayer = CAShapeLayer()
        maskAdsLayer.frame = self.bounds
        maskAdsLayer.path = path.cgPath
        
        self.layer.mask = maskAdsLayer
    }
}

/*
 // 001、appdelegate
    UIButton.init(swizzle: true)
 
 // 002、
 let b = UIButton(type: UIButtonType.contactAdd)
 b.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
 b.addTarget(self, action: #selector(action1), for: UIControlEvents.primaryActionTriggered)
 b.yy_eventAfterDelay = 0
 self.view.addSubview(b)
 */

// 防止重复点击
extension UIButton {
    
    static var kEventUnavailableKey: UInt = 101901
    static var kEventAfterDelay: UInt = 101902
    
    static let share: UIButton = UIButton(swizzle: true)
    
    // 是否忽略事件
    var yy_eventUnavailable: Bool {
        set {
            objc_setAssociatedObject(self, &UIButton.kEventUnavailableKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let b = objc_getAssociatedObject(self, &UIButton.kEventUnavailableKey) {
                return b as! Bool
            }
            return false
        }
    }
    
    var yy_eventAfterDelay: Double {
        set {
            objc_setAssociatedObject(self, &UIButton.kEventAfterDelay, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &UIButton.kEventAfterDelay) as? Double ?? 0.0
        }
    }
    
    convenience init(swizzle: Bool) {
        self.init()
        let selector = #selector(UIButton.sendAction(_:to:for:))
        let selector1 = #selector(UIButton.yy_sendAction(_:to:for:))
        let method = class_getInstanceMethod(UIButton.classForCoder(), selector)
        let method1 = class_getInstanceMethod(UIButton.classForCoder(), selector1)
        
        let isAddMethod = class_addMethod(UIButton.classForCoder(), selector1, method_getImplementation(method1!), method_getTypeEncoding(method1!))
        
        if isAddMethod {
            class_replaceMethod(UIButton.classForCoder(), selector1, method_getImplementation(method!), method_getTypeEncoding(method!))
        } else {
            method_exchangeImplementations(method!, method1!)
        }
    }
    
    @objc func yy_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {

        if yy_eventUnavailable {return}
        
        if self.yy_eventAfterDelay > 0.0 {
            self.yy_eventUnavailable = true
            self.perform(#selector(setEventUnavailable(b:)), with: false, afterDelay: self.yy_eventAfterDelay)
        }
        
        self.yy_sendAction(action, to: target, for: event)
        
    }
    
    @objc func setEventUnavailable(b: Bool) {
        yy_eventUnavailable = b
    }
}
