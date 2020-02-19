//
//  UINavigationController+Extension.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/7.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

extension UINavigationController {
    func ga_isEnabledPop(_ b: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = b
    }
}
