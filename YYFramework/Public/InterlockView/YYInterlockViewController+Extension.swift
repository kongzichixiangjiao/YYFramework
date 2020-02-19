//
//  YYInterlockViewController+Extension.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

extension UIViewController {
    private struct YYVCKey {
        static var scrollViewKey = "scrollViewKey"
        static var offsetKey = "offsetKey"
    }
    
    @objc public var yy_scrollView: UIScrollView? {
        get {
            return objc_getAssociatedObject(self, &YYVCKey.scrollViewKey) as? UIScrollView
        }
        set {
            objc_setAssociatedObject(self, &YYVCKey.scrollViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
