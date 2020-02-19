//
//  AppDelegate+ScreenRotation.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/7.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

var ga_mandatoryLandscape_key: UInt = 191207
extension AppDelegate {
    
    var ga_mandatoryLandscape: Bool? {
        get {
            return objc_getAssociatedObject(self, &ga_mandatoryLandscape_key) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ga_mandatoryLandscape_key, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    override func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if ga_mandatoryLandscape ?? false {
            return .landscapeLeft //强制横屏时这里可保持一个方向
        }
        return .portrait
    }
}
