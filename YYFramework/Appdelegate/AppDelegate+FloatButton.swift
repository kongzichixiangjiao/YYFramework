//
//  AppDelegate+FloatButton.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/15.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

extension AppDelegate {
    func _showFloatButton() {
        DispatchQueue.main.fw_after(2.0) {
            GAFloatWindow.show {
                guard let currentVC = UIApplication.ga_currentVC() else {
                    return
                }
                if currentVC.ga_nameOfClass.contains("XC"), let tabbarVC = currentVC.tabBarController, let nav = tabbarVC.navigationController {
                    nav.popToRootViewController(animated: true)
                }
            }
        }
    }
}
