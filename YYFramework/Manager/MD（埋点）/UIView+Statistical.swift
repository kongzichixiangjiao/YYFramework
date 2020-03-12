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
        swizzleCollectionViewDelegate()
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
        print("statistical_handleGesture-类名称：", sender.view?.ga_nameOfClass ?? "")
        print("statistical_handleGesture-当前控制器：", UIViewController.ga_currentVC() ?? "")
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
        print("statistical_sendAction-类名称：", self.ga_nameOfClass)
        print("statistical_sendAction-方法名称：", action.description)
        if self.ga_nameOfClass == "UIButton" {
            let b = self as! UIButton
            print("statistical_sendAction-TAG：", b.tag)
            print("statistical_sendAction-按钮标题：", b.titleLabel?.text ?? "")
        }
        print("statistical_sendAction-当前控制器：", UIViewController.ga_currentVC() ?? "")
//        print("statistical_sendAction-父视图：", self.superview ?? "")
        #endif
    }
    
    func swizzleTableViewDelegate() {
        let originalSelector = #selector(setter: UITableView.delegate)
        let swizzleSelector = #selector(UITableView.statistical_setTableView(delegate:))
        global_swizzleInstanceSelector(origSel: originalSelector, fromClass: UITableView.classForCoder(), replaceSel: swizzleSelector)
    }
    
    @objc func statistical_setTableView(delegate: UITableViewDelegate?) {
        statistical_setTableView(delegate: delegate)
        
        guard let delegate = delegate else {return}
        let originalSelector = #selector(delegate.tableView(_:didSelectRowAt:))
        let swizzleSelector = #selector(UITableView.statistical_tableView(_:didSelectRowAt:))
        global_swizzleClassSelector(origSel: originalSelector, origClass: type(of: delegate), replaceSel: swizzleSelector, replaceClass: UITableView.self)
        
    }
    
    @objc func statistical_tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        self.statistical_tableView(tableView, didSelectRowAt: didSelectRowAt)
        #if DEBUG
        print("statistical_tableView-类名称：", self.ga_nameOfClass)
        print("statistical_tableView-当前控制器：", UIViewController.ga_currentVC() ?? "")
//        print("statistical_tableView-父视图：", self.superview ?? "")
        #endif
    }
    
    func swizzleCollectionViewDelegate() {
        let originalSelector = #selector(setter: UICollectionView.delegate)
        let swizzleSelector = #selector(UICollectionView.statistical_setCollectionView(delegate:))
        global_swizzleInstanceSelector(origSel: originalSelector, fromClass: UICollectionView.classForCoder(), replaceSel: swizzleSelector)
    }
    
    @objc func statistical_setCollectionView(delegate: UICollectionViewDelegate?) {
        statistical_setCollectionView(delegate: delegate)
        
        guard let delegate = delegate else {return}
        let originalSelector = #selector(delegate.collectionView(_:didSelectItemAt:))
        let swizzleSelector = #selector(UICollectionView.statistical_collectionView(_:didSelectItemAt:))
        global_swizzleClassSelector(origSel: originalSelector, origClass: type(of: delegate), replaceSel: swizzleSelector, replaceClass: UICollectionView.self)
        
    }
    
    @objc func statistical_collectionView(_ collectionView: UICollectionView, didSelectItemAt: IndexPath) {
        self.statistical_collectionView(collectionView, didSelectItemAt: didSelectItemAt)
        #if DEBUG
        print("statistical_collectionView-类名称：", self.ga_nameOfClass)
        print("statistical_collectionView-当前控制器：", UIViewController.ga_currentVC() ?? "")
//        print("statistical_collectionView-父视图：", self.superview ?? "")
        #endif
    }
}
