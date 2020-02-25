//
//  SwizzledMethod.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/22.
//  Copyright © 2020 houjianan. All rights reserved.
//  交互方法

import Foundation
// 示例：
// ga_swizzle(originalSelector: #selector(UIViewController.viewWillAppear(_:)), swizzledSelector: #selector(UIViewController.ga_viewWillAppear(animated:)))

func ga_swizzle(originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(UIViewController.classForCoder(), originalSelector)
    let swizzledMethod = class_getInstanceMethod(UIViewController.classForCoder(), swizzledSelector)
    
    let didAddMethod = class_addMethod(UIViewController.classForCoder(), originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
    
    if didAddMethod {
        class_replaceMethod(UIViewController.classForCoder(), swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
    } else {
        method_exchangeImplementations(originalMethod!, swizzledMethod!);
    }
}

