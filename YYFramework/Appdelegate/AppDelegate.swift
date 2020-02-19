//
//  AppDelegate.swift
//  YYFramework
//
//  Created by houjianan on 2018/8/11.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit
import SwiftTheme
import Flutter
import FlutterPluginRegistrant // Used to connect plugins.

@UIApplicationMain
// 集成FlutterAppDelegate之后代理方法要override
class AppDelegate: FlutterAppDelegate {

    var _player: AVAudioPlayer!
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(NSHomeDirectory())
        
        flutter_run()
        
        apple_login()
        
        _initViews()
        
        bugly_Config()
        theme_setupNormalTheme()
        dbFace_initBDFace()
        wx_register(type: .qywx)
        wx_register(type: .wx)
//        growingIO_start()
//        ga_configUMengAnalytics()
//        ga_configBaiduMobStat
        bdMap_register()
        bdMap_location()
//        VZInspector_config()
        
        pxmd_applicationDidFinishLaunching()
        
        _showFloatButton()
        
        // 七牛云直播
//        PLStreamingEnv.initEnv()
        
        // 腾讯云直播 sdk与播放冲突
//        let licenceURL = "http://license.vod2.myqcloud.com/license/v1/1a3c4eda40d6b0fd0fd8e5ecfda580a8/TXLiveSDK.licence"
//        let licenceKey = "2769a13f6c90dd8eeae60806ad33b7d7"
//        //TXLiveBase 位于 "TXLiveBase.h" 头文件中
//        TXLiveBase.setLicenceURL(licenceURL, key: licenceKey)
        
        // 七牛云 pili 短视频日志系统
        pl_config()
        
        return true
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourse = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String else {
            return true
        }
        if wx_hanleOpen(url: url, sourse: sourse) {
            return true
        } else {
//        return growingIO_open(url: url)
            return true
        }
    }
    
    override func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return wx_hanleOpen(url: url, sourse: "")
    }
    
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return wx_application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    // 退到后台
    override func applicationWillResignActive(_ application: UIApplication) {
        
    }
    // 进入前台
    override func applicationWillEnterForeground(_ application: UIApplication) {
        pxmd_applicationWillEnterForeground(application)
    }
    // 退到后台
    override func applicationDidEnterBackground(_ application: UIApplication) {
        pxmd_applicationDidEnterBackground(application)
    }
    
    override func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }
    
    override func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        notification_application(application, didReceive: notification)
    }
    
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        notification_application(application, didReceiveRemoteNotification: userInfo)
    }
    
   override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        notification_application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    deinit {
        
    }
}

extension AppDelegate {
    private func _initViews() {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            
        }
    }
}
