//
//  UITableView.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellClass: AnyClass) -> Void {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func register(cellNibClass: AnyClass) -> Void {
        let identifier = String(describing: cellNibClass)
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func register(headerFooterClass: AnyClass) -> Void {
        let identifier = String(describing: headerFooterClass)
        register(headerFooterClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func register(headerFooterNibClass: AnyClass) -> Void {
        let identifier = String(describing: headerFooterNibClass)
        register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableCell(withIdentifier: identifier) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderFooter<T: UIView>(cellClass: T.Type) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
    }
}

