//
//  AppDelegate+WeChat.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/9/25.
//  Copyright © 2019 houjianan. All rights reserved.
//

/*
 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
     guard let sourse = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String else {
         return true
     }
     if wx_hanleOpen(url: url, sourse: sourse) {
         return true
     } else {
         return true
     }
}
 
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    wx_register()
}
 */

import Foundation


extension AppDelegate {
    func wx_register(type: GAWeChatRegisterType = .qywx) {
        if type == .qywx {
            GAWeChat.share.register()
        } else {
            GAWXLib.share.register()
        }
    }
    
    // func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    func wx_hanleOpen(url: URL, sourse: String) -> Bool {
        if sourse == "com.tencent.ww" {
            return GAWeChat.share.hanleOpen(url: url, sourse: sourse)
        } else if sourse == "com.tencent.ww" {
            return WXApi.handleOpen(url, delegate: self as? WXApiDelegate)
        } else {
            return false 
        }
    }
    
    func wx_application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return GAWXLib.share.handleOpenUniversalLink(userActivity: userActivity)
    }
    
}
