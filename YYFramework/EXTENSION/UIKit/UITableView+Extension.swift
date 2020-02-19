//
//  UITableView+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/26.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  UITableView 扩展

import UIKit


extension UITableView {
    
    // 注册单个xib cell
    func yy_register(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    // 注册多个xib cell
    func yy_register(nibNames: [String]) {
        for nibName in nibNames {
            yy_register(nibName: nibName)
        }
    }
    
    // 注册 AnyClass cell
    func yy_register(classString: String) {
        self.register(NSClassFromString(classString), forCellReuseIdentifier: classString)
    }
}

// 注册cell
extension UITableView {
    func ga_register(cellClass: AnyClass) -> Void {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func ga_register_s(cellClasses: [AnyClass]) -> Void {
        for cellClass in cellClasses {
            let identifier = String(describing: cellClass)
            register(cellClass, forCellReuseIdentifier: identifier)
        }
    }
    
    func ga_register_s(cellNibClasses: [AnyClass]) -> Void {
        for cellNibClass in cellNibClasses {
            let identifier = String(describing: cellNibClass)
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func ga_register(cellNibClass: AnyClass) -> Void {
        let identifier = String(describing: cellNibClass)
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func ga_register(headerFooterClass: AnyClass) -> Void {
        let identifier = String(describing: headerFooterClass)
        register(headerFooterClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func ga_register(headerFooterNibClass: AnyClass) -> Void {
        let identifier = String(describing: headerFooterNibClass)
        register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
}

// cell 复用  不必写 as! UITableViewCell
extension UITableView {
    func ga_dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
    func ga_dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    func ga_dequeueReusableHeaderFooter<T: UIView>(cellClass: T.Type) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
    }
}
