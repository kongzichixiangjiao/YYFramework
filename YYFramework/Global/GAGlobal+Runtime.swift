//
//  GAGlobalMethod.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/18.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

// https://developer.apple.com/documentation/objectivec/1418490-class_copymethodlist
/*
 class_copyPropertyList: 通过类名获得类的属性变量。
 class_copyIvarList: 通过类名获得类的实例变量。

 class_copyPropertyList获得的是由@property修饰过的变量，
 class_copyIvarList获得的是class_copyPropertyList修饰的以及在m文件的中@implementation内定义的变量
 */
func global_getClassProperty(cls: AnyClass) -> [String] {
    var count: UInt32 = 0
    let list = class_copyPropertyList(cls, &count)
    
    var names = [String]()
    for i in 0..<Int(count) {
        guard let property = list?[i] else { return [] }
        let cName = property_getName(property)
        if let name = String(utf8String: cName) {
            names.append(name)
        }
    }
    free(list)
    return names
}

func global_getClassIvar(cls: AnyClass) -> [String] {
    var count: UInt32 = 0
    let list = class_copyIvarList(cls, &count)
    
    var names = [String]()
    for i in 0..<Int(count) {
        guard let property = list?[i] else { return [] }
        let cName = property_getName(property)
        if let name = String(utf8String: cName) {
            names.append(name)
        }
    }
    free(list)
    return names
}


func global_getClassMethod(cls: AnyClass) -> [Selector] {
    var count: UInt32 = 0
    let list = class_copyMethodList(cls, &count)
    
    var selecters = [Selector]()
    for i in 0..<Int(count) {
        guard let method = list?[i] else { return [] }
        let methodName = method_getName(method)
        selecters.append(methodName)
    }
    free(list)
    return selecters
}

// MARK: Swizzle

extension NSObject {
    func global_swizzleinstanceSelector(origSel: Selector, replaceSel: Selector) {
        guard let origMethod = class_getInstanceMethod(self.classForCoder, origSel) else {
            return
        }
        guard let replaceMethod = class_getInstanceMethod(self.classForCoder, replaceSel) else {
            return
        }
        
        let didAddMethod = class_addMethod(self.classForCoder, origSel, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))
        if didAddMethod {
            class_replaceMethod(self.classForCoder, replaceSel, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))
        } else {
            method_exchangeImplementations(origMethod, replaceMethod)
        }
    }
    
    func global_swizzleClassSelector(origSel: Selector, replaceSel: Selector) {
        global_swizzleinstanceSelector(origSel: origSel, replaceSel: replaceSel)
    }
    
    func global_swizzleInstanceSelector(origSel: Selector, fromClass: AnyClass, replaceSel: Selector) {
        guard let origMethod = class_getInstanceMethod(fromClass, origSel) else {
            return
        }
        guard let replaceMethod = class_getInstanceMethod(fromClass, replaceSel) else {
            return
        }
        let didAddMethod = class_addMethod(fromClass, replaceSel, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))
        if didAddMethod {
            guard let origReplaceMeth = class_getInstanceMethod(fromClass, replaceSel) else { return }
            method_exchangeImplementations(origMethod, origReplaceMeth)
        } else {
            method_exchangeImplementations(origMethod, replaceMethod)
        }
    }
    
}
