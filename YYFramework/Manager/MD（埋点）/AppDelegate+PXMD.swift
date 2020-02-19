//
//  AppDelegate+PXMD.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/1.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    // 启动
    func pxmd_applicationDidFinishLaunching() {
        PXMD.share.md_launched()
        
        let _ = UIViewController.ga_share
    }
    
    // 进入前台
    func pxmd_applicationWillEnterForeground(_ application: UIApplication) {
        print("pxmd_applicationWillEnterForeground")
    }
    
    // 退到后台
    func pxmd_applicationDidEnterBackground(_ application: UIApplication) {
        print("pxmd_applicationDidEnterBackground")
        PXMD.share.md_backgroundOrKill()
    }
    
}

/*
 
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         pxmd_applicationDidFinishLaunching()
         return true
     }
 // 退到后台
 func applicationWillResignActive(_ application: UIApplication) {
     
 }
 // 进入前台
 func applicationWillEnterForeground(_ application: UIApplication) {
     pxmd_applicationWillEnterForeground(application)
 }
 // 退到后台
 func applicationDidEnterBackground(_ application: UIApplication) {
     pxmd_applicationDidEnterBackground(application)
 }
 
 */
