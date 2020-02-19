//
//  ViewController+Statistical.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/2.
//  Copyright © 2019 houjianan. All rights reserved.
//  统计

import Foundation

// MARK: let _ = UIViewController.share
// 统计界面使用 方法交换
extension UIViewController {
    
    static let ga_share: UIViewController = UIViewController(swizzle: true)
    
    convenience init(swizzle: Bool) {
        self.init()
        
        // viewWillAppear
        let originalSelector = #selector(UIViewController.viewWillAppear(_:))
        let swizzledSelector = #selector(UIViewController.ga_viewWillAppear(animated:))
        
        let originalMethod = class_getInstanceMethod(UIViewController.classForCoder(), originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIViewController.classForCoder(), swizzledSelector)
        
        let didAddMethod = class_addMethod(UIViewController.classForCoder(), originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(UIViewController.classForCoder(), swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!);
        }
        
        // viewDidDisappear
        let originalSelector1 = #selector(UIViewController.viewDidDisappear(_:))
        let swizzledSelector1 = #selector(UIViewController.ga_viewDidDisappear(animated:))
        
        let originalMethod1 = class_getInstanceMethod(UIViewController.classForCoder(), originalSelector1)
        let swizzledMethod1 = class_getInstanceMethod(UIViewController.classForCoder(), swizzledSelector1)
        
        let didAddMethod1 = class_addMethod(UIViewController.classForCoder(), originalSelector1, method_getImplementation(swizzledMethod1!), method_getTypeEncoding(swizzledMethod1!))
        if didAddMethod1 {
            class_replaceMethod(UIViewController.classForCoder(), swizzledSelector1, method_getImplementation(originalMethod1!), method_getTypeEncoding(originalMethod1!))
        } else {
            method_exchangeImplementations(originalMethod1!, swizzledMethod1!)
        }
    }
    
    // MARK: - Method Swizzling
    @objc func ga_viewWillAppear(animated: Bool) {
        self.ga_viewWillAppear(animated: animated)
        
        let pageName = self.title ?? self.description
        #if DEBUG
//        print("ga_viewDidAppear, pageName: " + pageName)
        #endif
        
        MD.md_pageStart(name: pageName)
        
        PXMD.share.md_pageEnd(code: "", name: pageName)
    }
    
    @objc func ga_viewDidDisappear(animated: Bool) {
        self.ga_viewDidDisappear(animated: animated)
        
        let pageName = self.title ?? self.description
        #if DEBUG
//        print("ga_viewDidDisappear, pageName: " + pageName)
        #endif
        
        MD.md_pageEnd(name: pageName)
        
        PXMD.share.md_pageStart(code: "", name: pageName)
    }
}

