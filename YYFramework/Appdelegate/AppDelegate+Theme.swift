//
//  AppDelegate+Theme.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation
import SwiftTheme

extension AppDelegate {
    
    // 换肤设置
    func theme_setupNormalTheme() {
        ThemeManager.setTheme(plistName: "Normal", path: .mainBundle)
    }
    
}
