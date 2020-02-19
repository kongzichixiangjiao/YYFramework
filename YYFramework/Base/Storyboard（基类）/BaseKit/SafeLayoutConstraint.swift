//
//  SafeLayoutConstraint.swift
//  eduOnline
//
//  Created by lixy on 2019/5/31.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

class SafeTopLayoutConstraint: NSLayoutConstraint {
    override var constant: CGFloat {
        set {
            super.constant = newValue
        }
        get {
            return super.constant + SafeTopHeight - 20
        }
    }
}

class SafeBottomLayoutConstraint: NSLayoutConstraint {
    override var constant: CGFloat {
        set {
            super.constant = newValue
        }
        get {
            return super.constant + SafeBottomHeight
        }
    }
}
