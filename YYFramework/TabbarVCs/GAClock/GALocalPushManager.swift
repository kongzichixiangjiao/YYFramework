//
//  GALocalPushManager.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/22.
//  Copyright © 2019 houjianan. All rights reserved.
//  本地推送

import Foundation

class GALocalPushManager {
    
    static let share: GALocalPushManager = GALocalPushManager()
    
    public var localNotifications: [UILocalNotification]? {
        get {
            guard let localNotifications = UIApplication.shared.scheduledLocalNotifications else {
                return nil
            }
            return localNotifications
        }
    }
    
    public func post(fireDate: Date, repeatInterval: NSCalendar.Unit, alertTitle: String, alertBody: String, alertLaunchImage: String = "clock_check_box_selected", soundName: String, userInfo: [String : String]) {
        let notification = UILocalNotification()

        notification.fireDate = fireDate
        notification.timeZone = TimeZone.current
        notification.repeatInterval = repeatInterval
        notification.alertTitle = alertTitle
        notification.alertBody = alertBody
        notification.hasAction = true
        notification.alertAction = "alertAction"
        notification.alertLaunchImage = alertLaunchImage
        notification.applicationIconBadgeNumber = 1
        notification.soundName = soundName
        notification.userInfo = userInfo

        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
        UIApplication.shared.scheduleLocalNotification(notification)
    }

    public func cancel(info: [String : String]) {
        guard let localNotifications = UIApplication.shared.scheduledLocalNotifications else {
            return
        }
        
        for notification in localNotifications {
            guard let userInfo = notification.userInfo else {
                return
            }
        
            if let value = userInfo["key"] as? String {
                if value == info["key"] {
                    UIApplication.shared.cancelLocalNotification(notification)
                    break
                }
            }
        }
    }
    
    public func cancelAll() {
        guard let localNotifications = UIApplication.shared.scheduledLocalNotifications else {
            return
        }
        #if DEBUG
        print("一共有通知\(localNotifications.count)个。")
        #endif
        if localNotifications.count != 0 {
            UIApplication.shared.cancelAllLocalNotifications()
            #if DEBUG
            print("取消任务")
            #endif
        }
    }
}
