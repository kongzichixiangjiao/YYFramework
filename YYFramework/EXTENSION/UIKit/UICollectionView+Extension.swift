//
//  UICollectionView+Extension.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func ga_register(nibName: AnyClass) {
        let identifier = String(describing: nibName)
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func ga_dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    
    func yy_register(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func yy_register(nibNames: [String]) {
        for nibName in nibNames {
            yy_register(nibName: nibName)
        }
    }
    
    func yy_registerSection(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibName)
    }
    
    func yy_registerSection(nibNames: [String]) {
        for nibName in nibNames {
            yy_registerSection(nibName: nibName)
        }
    }
    
    func yy_registerFooter(nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: nibName)
    }
}

extension UICollectionView {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UICollectionReusableView {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UICollectionView {
    var ga_edgeInsetTop: CGFloat {
        set {
            self.contentInset = UIEdgeInsets(top: newValue, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
        get {
            return self.contentInset.top
        }
    }
}
