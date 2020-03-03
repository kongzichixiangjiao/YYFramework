//
//  AppDelegate-UM.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/2.
//  Copyright © 2019 houjianan. All rights reserved.
//  友盟统计

import Foundation

extension AppDelegate {
    
    func ga_configUMengAnalytics() {
//        DispatchQueue.global().async {
//            UMCommonLogManager.setUp()
//            // um账号 kongzichixiangjiao
//            UMConfigure.initWithAppkey("5d43cc4a0cafb2603500084d", channel: "App Store")
//            UMConfigure.setLogEnabled(true)
//            
//            MobClick.setAutoPageEnabled(false)
//        }
        self.statistics()
    }
    
    func statistics() {
        let _ = UIViewController.ga_share
        let _ = UIControl.ga_share
    }

}
