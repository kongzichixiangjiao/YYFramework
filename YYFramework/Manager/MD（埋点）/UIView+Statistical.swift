//
//  Gesture+Static.swift
//  YYFramework
//
//  Created by houjianan on 2020/3/2.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

extension UIView {
    static let ga_share: UIView = UIView(statistical_swizzle: true)
    
    convenience init(statistical_swizzle: Bool) {
        self.init()
        swizzleAddGestureRecognizer()
        swizzleSendAction()
        swizzleTableViewDelegate()
    }
    
    func swizzleAddGestureRecognizer() {
        let originalSelector = #selector(UIView.addGestureRecognizer(_:))
        let swizzleSelector = #selector(UIView.statistical_addGestureRecognizer(_:))
        
        global_swizzleinstanceSelector(origSel: originalSelector, replaceSel: swizzleSelector)
    }
    
    @objc func statistical_addGestureRecognizer(_ sender: UIGestureRecognizer) {
        self.statistical_addGestureRecognizer(sender)
        sender.addTarget(self, action: #selector(statistical_handleGesture))
    }
    
    @objc func statistical_handleGesture(sender: UIGestureRecognizer) {
        #if DEBUG
        print("类名称：", sender.view?.ga_nameOfClass ?? "")
        print("当前控制器：", UIViewController.ga_current)
        #endif
    }
    
    func swizzleSendAction() {
        let originalSelector = #selector(UIControl.sendAction(_:to:for:))
        let swizzleSelector = #selector(UIView.statistical_sendAction(_:to:for:))
        
        global_swizzleInstanceSelector(origSel: originalSelector, fromClass: UIControl.classForCoder(), replaceSel: swizzleSelector)
    }
    
    @objc func statistical_sendAction(_ action: Selector, to: Any?, for envent: UIEvent?) {
        self.statistical_sendAction(action, to: to, for: envent)
        #if DEBUG
        print("类名称：", self.ga_nameOfClass)
        print("方法名称：", action.description)
        if self.ga_nameOfClass == "UIButton" {
            let b = self as! UIButton
            print("TAG：", b.tag)
            print("按钮标题：", b.titleLabel?.text ?? "")
        }
        print("当前控制器：", UIViewController.ga_current)
        #endif
    }
    
    func swizzleTableViewDelegate() {
        let originalSelector = #selector(setter: UITableView.delegate)
        let swizzleSelector = #selector(UITableView.statistical_set(delegate:))
        global_swizzleInstanceSelector(origSel: originalSelector, fromClass: UITableView.classForCoder(), replaceSel: swizzleSelector)
    }
    
    @objc func statistical_set(delegate: UITableViewDelegate?) {
        statistical_set(delegate: delegate)
        
        guard let delegate = delegate else {return}
        let originalSelector = #selector(delegate.tableView(_:didSelectRowAt:))
        let swizzleSelector = #selector(UITableView.statistical_tableView(_:didSelectRowAt:))
        global_swizzleInstanceSelector(origSel: originalSelector, fromClass: UITableView.classForCoder(), replaceSel: swizzleSelector)
    }
    
    @objc func statistical_tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        #if DEBUG
        print("类名称：", self.ga_nameOfClass)
        print("当前控制器：", UIViewController.ga_currentVC())
        #endif
    }
    
}
