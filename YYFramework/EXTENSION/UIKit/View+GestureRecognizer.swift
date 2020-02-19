//
//  View+GestureRecognizer.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/28.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

// 添加手势
extension UIView {

    // 添加单机手势
    func ga_addTapGestureRecognizer(target: Any?, action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
    
    // 添加长按手势
    func ga_addLongPressGestureRecognizer(action: Selector?, duration: Double) {
        let longPress = UILongPressGestureRecognizer(target: self, action: action)
        longPress.minimumPressDuration = duration
        self.addGestureRecognizer(longPress)
    }
}

